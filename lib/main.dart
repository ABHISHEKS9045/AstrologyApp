import 'dart:async';
import 'dart:convert';

import 'package:astrologyapp/changepassword/ChangePasswordProvider.dart';
import 'package:astrologyapp/chat/callList/CallHistoryListPage.dart';
import 'package:astrologyapp/chat/chat%20room/TimerProvider.dart';
import 'package:astrologyapp/chat/chatlist/chatlistmodelpage.dart';
import 'package:astrologyapp/common/appbar/appbarmodal.dart';
import 'package:astrologyapp/edit%20profile/editprofilemodel.dart';
import 'package:astrologyapp/feedback/feedbackpagemodel.dart';
import 'package:astrologyapp/help&support/SupportProvider.dart';
import 'package:astrologyapp/introduction/introductionModelPage.dart';
import 'package:astrologyapp/login%20Page/loginModelPage.dart';
import 'package:astrologyapp/notification/notificationModelPage.dart';
import 'package:astrologyapp/order%20history/OrderHistoryProvider.dart';
import 'package:astrologyapp/plan/planModelPage.dart';
import 'package:astrologyapp/profile%20jyotish/ProfileJyotishProvider.dart';
import 'package:astrologyapp/settings/settingpagemodel.dart';
import 'package:astrologyapp/signup/SignUpPageModel.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';

import 'SplashScreen/splash_screen.dart';
import 'chat/Astrologer response/CustomerResponse.dart';
import 'chat/Astrologer response/atrologerChatResponse.dart';
import 'chat/chat room/ChatHistoryProvider.dart';
import 'chat/chat room/ChatRoomModel.dart';
import 'chat/chat room/chatroomPage.dart';
import 'common/bottomnavbar/bottomnavbar.dart';
import 'common/bottomnavbar/bottomnavbarModelPage.dart';
import 'common/styles/const.dart';
import 'dashboard/dashboardModelPage.dart';
import 'forgetpass/enter mobile number page1/forgetpassModelpage.dart';
import 'forgetpass/password change page3/changepassmodelpage.dart';
import 'freeconsultation/FreeConsultationProvider.dart';
import 'generate kundli/generatekundaliModelPage.dart';
import 'generate kundli/openkundlimodelpage.dart';
import 'login Page/social login/googleSignUpModelPage.dart';

// firebase background message handle
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    // your code that you want to run in background

    DIO.Dio dio = DIO.Dio();
    // dio.options.headers["authorization"] = "Basic ZGMyYjhhNTQ3YjY3ZTQ1MjYwMWYxZmE4NTFhOGFjMjVjNzU4YmNmODc0NjExZDJhOmE5ODZhOTFhNDkzNmY1ZmE1NjgzNjc3NTJjYmMzZGIwNTk0YzMzYzJiYjA0NTNhZA==";
    dio.options.headers["authorization"] = "Basic MTc3M2RmZGQ5NDYxMmY1OWYwYTUwNTdlYjNlZjc2ZTdiN2JjNDkwOTlhNjEwNDE0OmRhNTIzOGUzNjEyYWFiOTA4ZmQ0NDVlOWQ1NTQwNzM3Mjk3ODkwZmRmM2UzNDRkZA==";

    var response = await dio.get('${"https://api.exotel.com/v1/Accounts/connectaastro1/Calls/"}${inputData!['call_sid']}.json');
    final responseData = json.decode(response.toString());
    debugPrint("Main callback Dispatcher after call end =========> $response");
    if (response.statusCode == 200) {
      double amount = (responseData['Call']['Duration'] / 60) * int.parse(inputData['charge_per_minute']);
      await saveCallDetails(
        inputData['user_id'],
        inputData['astro_id'],
        inputData['call_sid'],
        response,
        inputData['to_number'],
        inputData['from_number'],
        amount.ceil(),
        inputData['charge_per_minute'],
        responseData['Call']['Status'],
      );
    }
    return Future.value(true);
  });
}

saveCallDetails(userId, astroId, callSid, callresponse, To, From, amount, charge_per_minute, status) async {
  DIO.Dio dio = DIO.Dio();
  DIO.FormData formData = DIO.FormData.fromMap(
    {
      "user_id": userId,
      "astro_id": astroId,
      "call_sid": callSid,
      "call_data": callresponse.toString(),
      'to_number': To,
      'from_number': From,
      'current_used_bal': amount,
      'per_minute': charge_per_minute,
      'call_status': status,
    },
  );
  var response = await dio.post("${baseURL}call_back", data: formData);
  debugPrint("Main save Call Details =========> $response");
  try {
    if (response.statusCode == 200) {}
  } catch (e) {
    debugPrint("call api check error ======> ${e.toString()}");
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
    showBadge: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    Workmanager().initialize(callbackDispatcher);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => IntroductionModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => BottomNavbarModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => EditProfileModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SignUpPageModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SettingPageModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => FeedbackPageModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ForgetPassModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => DashboardModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChangePassModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => NotificationModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => GoogleSignUpModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => GenratekundliModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => Openkundlimodelpage(),
          ),
          ChangeNotifierProvider(
            create: (context) => Chatlistmodelpage(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlanModelPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => AppBarModalPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrderHistoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChatRoomModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChatHistoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChangePasswordProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfileJyotishProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TimerProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SupportProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FreeConsultationProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
}

bool isChatConnected = false;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String TAG = "_MyAppState";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // firebase messaging starts here

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print("$TAG onMessage ======> ${message.data.toString()}");

      showNotification(message.data, true);

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: const Color(0xFFF9921F),
              playSound: true,
              icon: '@mipmap/ic_launcher',
              priority: Priority.max,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      print("$TAG instance getInitialMessage =========> ${message?.data}");
      if (message != null) {
        String notificationData = json.encode(message.data);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("notificationData", notificationData);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("$TAG MessageOpenedApp ======> ${message.data.toString()}");
      showNotification(message.data, false);
    });

    FirebaseMessaging.instance.getToken().then((String? value) {
      print("$TAG instance getToken ======> $value");
    });
    // firebase messaging end here
  }

  // used to show notification
  Future<void> showNotification(Map<String, dynamic> data, bool fromMessage) async {
    print('$TAG showNotification');

    if (data["type"] == "waiting" && data["notification_type"] == "astrologer_wait_request") {
      if (isChatConnected) {
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return const BottomNavBarPage(
                  toChat: true,
                );
              },
            ),
            (route) {
              return false;
            },
          );
        });
      }
    } else if (data["type"] == "call_ended" && data["notification_type"] == "call_ended") {
      if (fromMessage) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.to(() => const CallHistoryListPage());
        });
      } else {
        String notificationData = json.encode(data);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("notificationData", notificationData);

        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return const BottomNavBarPage();
              },
            ),
            (route) {
              return false;
            },
          );
        });
      }
    } else if (data["type"] == "astrologer" && data['notification_type'] == 'send_request') {
      print("$TAG message for astrologer to show incoming chat request.");
      if (checkTimeDifference(int.parse(data["time"]))) {
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.to(() => AstrologerResponse(
                receiverId: data['receiver_id'],
                userName: data['user_name'],
                user_image: data['user_image'],
                sender_id: data['sender_id'],
                perMinute: data['per_minute'],
                requestId: data['id'],
              ));
        });
      } else {
        Fluttertoast.showToast(msg: 'Chat Request timeout');
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return const BottomNavBarPage();
              },
            ),
            (route) {
              return false;
            },
          );
        });
      }
    } else if (data['type'] != 'astrologer' && data['notification_type'] == 'cancle') {
      print("$TAG message for customer to show chat request rejected.");
      Fluttertoast.showToast(msg: 'Request rejected by astrologer...');
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return const BottomNavBarPage();
            },
          ),
          (route) {
            return false;
          },
        );
      });
    } else if (data['type'] == 'astrologer' && data['notification_type'] == 'astrologer_reject_request') {
      print("$TAG message for customer to show wait list chat request rejected.");
      Fluttertoast.showToast(msg: 'Request rejected by astrologer...');
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return const BottomNavBarPage();
            },
          ),
          (route) {
            return false;
          },
        );
      });
    } else if (data['type'] == 'astrologer' && data['notification_type'] == 'astrologer_send_request') {
      //CustomerResponse
      print("$TAG message for customer to show incoming chat request from astrologer.");
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(() => CustomerResponse(
              requestType: data["request_type"].toString(),
              receiverId: int.parse(data['receiver_id'].toString()),
              userName: data['user_name'].toString(),
              userImage: data['user_image'].toString(),
              senderId: int.parse(data['sender_id'].toString()),
              perMinute: int.parse(data['per_minute'].toString()),
              requestId: int.parse(data['id'].toString()),
              phoneNo: data['astro_phone'].toString(),
            ));
      });
    } else if (data['type'] == 'astrologer' && data['notification_type'] == 'user_aprrove_request') {
      print("$TAG message for astrologer to show chat request accepted.");
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return ChatRoomPage(
                chatTime: 0,
                receiver_id: data["sender_id"].toString(),
                isForHistory: false,
                userName: data["user_name"].toString(),
                perMinute: data["per_minute"].toString(),
              );
            },
          ),
          (route) {
            return false;
          },
        );
      });
    } else if (data['type'] == 'astrologer' && data['notification_type'] == 'user_reject_request') {
      print("$TAG message for astrologer to show chat request rejected.");
      Fluttertoast.showToast(msg: 'Customer refused to join chat...');

      Future.delayed(const Duration(milliseconds: 100), () {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) {
              return const BottomNavBarPage();
            },
          ),
          (route) {
            return false;
          },
        );
      });
    } else {
      if (checkTimeDifference(int.parse(data["time"]))) {
        try {
          int time = 0;

          SharedPreferences pref = await SharedPreferences.getInstance();
          String? isFree = pref.getString("is_free");

          final model1 = Provider.of<Chatlistmodelpage>(context, listen: false);

          if (isFree != null && isFree == "1" && data["is_free"].toString() == "1" && int.parse(data["free_time"].toString()) > 0) {

            debugPrint("$TAG is free available ======> $isFree");
            debugPrint("$TAG free time available ======> ${data["free_time"]}");

            time = int.parse(data["free_time"].toString());
            Future.delayed(const Duration(milliseconds: 100), () {
              Get.offUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return ChatRoomPage(
                      chatTime: time,
                      isForHistory: false,
                      perMinute: data['per_minute'],
                      userName: data['user_name'],
                      receiver_id: data['sender_id'],
                    );
                  },
                ),
                (route) {
                  return false;
                },
              );
            });
            await model1.toggelreseverid(data['sender_id']);
          } else {
            print("$TAG message for customer to open chat page.");
            await model1.getWalletBalance(context);
            time = (int.parse(model1.walletAmount.toString()) / int.parse(data['per_minute'].toString())).toInt();

            Future.delayed(const Duration(milliseconds: 100), () {
              Get.offUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return ChatRoomPage(
                      chatTime: time,
                      isForHistory: false,
                      perMinute: data['per_minute'],
                      userName: data['user_name'],
                      receiver_id: data['sender_id'],
                    );
                  },
                ),
                (route) {
                  return false;
                },
              );
            });
            await model1.toggelreseverid(data['sender_id']);
          }
        } catch (e) {
          print("$TAG User side catch exception ==========> ${e.toString()}");
          Fluttertoast.showToast(msg: 'User ${e.toString()}');
        }
      } else {
        Fluttertoast.showToast(msg: 'Chat Request timeout');
        Future.delayed(const Duration(milliseconds: 100), () {
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) {
                return const BottomNavBarPage();
              },
            ),
            (route) {
              return false;
            },
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Astrology App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: colorWhite,
            fontFamily: "Poppins",
            primaryTextTheme: TextTheme(
              displayMedium: TextStyle(color: colorblack),
            ),
            textTheme: TextTheme(
              displayLarge: TextStyle(
                color: colororangeLight,
                fontSize: fontsizeheading25,
                letterSpacing: 0.5,
                fontWeight: fontWeight700,
              ),
              titleLarge: TextStyle(
                color: colorblack,
                fontSize: 16,
                letterSpacing: 0.5,
                fontWeight: fontWeight400,
              ),
              displayMedium: TextStyle(
                color: colorblack,
                fontSize: fontsizeheading25,
                letterSpacing: 0.5,
                fontWeight: fontWeight600,
              ),
              displaySmall: TextStyle(
                color: colorblack,
                fontSize: fontsize18,
                letterSpacing: 0.5,
                fontWeight: fontWeight600,
              ),
              titleSmall: const TextStyle(
                color: Colors.grey,
                letterSpacing: 0.5,
                fontSize: 12,
              ),
            ),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: colorWhite,
              elevation: 0,
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
