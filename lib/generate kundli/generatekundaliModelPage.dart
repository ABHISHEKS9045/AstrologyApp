import 'dart:convert';

import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';
import 'details/detailsPage.dart';

class GenratekundliModelPage extends ChangeNotifier {

  String TAG = "GenratekundliModelPage";

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  var panchangDetails;
  var chartImage;
  var charDashDetails;

  toggleshemmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleshemmerdismis() {
    _isShimmer = false;
    notifyListeners();
  }

  bool _autovalidate = false;

  bool get autovalidate => _autovalidate;

  String? _selectaddres;

  String? get selectaddres => _selectaddres;

  setAddress(String val) {
    _selectaddres = val;
  }

  togglselectaddres(add) {
    _selectaddres = add;
    notifyListeners();
    //// print('vinay1 address kundli  $selectaddres');
  }

  String? togglselectaddrestap(modelprofileview) {
    if (selectaddres == null) {
      // print('vinay1111 address kundli $selectaddres');
      return _selectaddres = modelprofileview.userdataMap['address'].toString();
    } else {
      return selectaddres;
    }
  }

  toggleautovalidate() {
    _autovalidate = !_autovalidate;
    notifyListeners();
  }

  String? _kundliUrl;

  String? get kundliUrl => _kundliUrl;

  double? _lattitude;

  double? get lattitude => _lattitude;

  double? _longitude;

  double? get longitude => _longitude;

  Duration? _timezone;

  Duration? get timezone => _timezone;

  TextEditingController kundliName = TextEditingController();

  Map? _kundligenratedetailslist;

  Map? get kundligenratedetailslist => _kundligenratedetailslist;

  DateTime? newdob;
  DateTime currentDate = DateTime.now();

  var planetSignDetails;
  var astroDetails;
  var kpPlanetDetails;
  var rudrashRecc;
  var gemRecc;
  var kalpasaraDetails;
  var manglikDetails;
  var sadesatiDetails;
  var currentSadesatiDetails;
  var kpCuspDetails;
  var yoginiDashaDetails1;

  var planetNakshatraDetails1;

  selectDate(context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colororangeLight, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                // onSurface: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        },
        lastDate: DateTime.now()) as DateTime;
    if (pickedDate != currentDate) currentDate = pickedDate;
    newdob = pickedDate;
    notifyListeners();
  }

  String? onlydate;

  String? gettext(modelprofileview) {
    if (newdob == null) {
      return onlydate = modelprofileview.userdataMap['dob'].toString();
    } else {
      onlydate = DateFormat('dd-MM-yyyy').format(currentDate);
      return onlydate;
      // return "${currentDate.day}/${currentDate.month}/${currentDate.year}";
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  selectTime(context) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: colororangeLight, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                // onSurface: Colors.white, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: colororangeLight, //
                ),
              ),
            ),
            child: child!,
          );
        });
    if (timeOfDay != selectedTime) {
      selectedTime = timeOfDay as TimeOfDay;
      newTime = timeOfDay;
      notifyListeners();
    }
  }

  TimeOfDay? newTime;
  String? onlytime; //TimeOfDay(15:30) remove timeof day
  String? gettimetext(modelprofileview) {
    if (newTime == null) {
      return onlytime = modelprofileview.userdataMap['birth_time'].toString();
    } else {
      final hours = selectedTime.hour.toString().padLeft(2, '0');
      final minutes = selectedTime.minute.toString().padLeft(2, '0');
      // final second = selectedTime.sec.toString().padLeft(2, '0');
      // return DateFormat('dd-MM-yyyy').format(currentDate);
      onlytime = "$hours:$minutes";
      return onlytime;
    }
  }

  late List<Location> _locations;

  List<Location> get locations => _locations;

  kundalisubmit(context, model) async {
    // String? getlatlong = _selectaddres == null ? selectaddres : selectaddres;
    // print('vinay $selectaddres');
    _locations = await locationFromAddress(selectaddres!);
    _lattitude = locations.first.latitude;
    _longitude = locations.first.longitude;

    // print('vinay lat log ${locations.first.latitude}');
    // print('vinay lat log ${locations.first.longitude}');
    toggleshemmerShow();
    DateTime dateTime = DateTime.now();
    // print(DateTime.now());
    // print(dateTime.timeZoneName);
    // print(dateTime.timeZoneOffset);
    _timezone = dateTime.timeZoneOffset;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'd': onlydate,
      't': onlytime,
      // 'lat': '+28.70',
      'lat': lattitude!.toStringAsFixed(2),
      // 'lon': '+77.10',
      'lon': longitude!.toStringAsFixed(2),
      'tz': timezone,
      'userid': 'aman946',
      'authcode': '621457c19852983c83f06ff992ee36d4'
    });
    // print('vinay ${formData.fields}');
    var response = await dio.post("https://api.kundli.click/v0.4/chart-asc", data: formData);
    // print('vinay kundali1 $response');
    final responseData = json.decode(response.toString());
    // final responseData = json.decode(response.data);
    // print('vinay kundali2 $responseData');

    _kundliUrl = responseData['url'];
    //  _kundliUrl = "https://api.kundli.click/v0.4/graphics/getchart?w=400&h=300&chart=11,11,6,3,11,9,12,5,12,6";
    notifyListeners();
    Future.delayed(Duration(seconds: 1));
    await addkundlidatasubmit(context, model);
    toggleshemmerdismis();
    onlydate = null;
    onlytime = null;
    newTime = null;
    newdob = null;
    kundliName.clear();
    _selectaddres = null;
    notifyListeners();
    // print('vinay kundali2 $kundliUrl');
  }

  addkundlidatasubmit(context, model) async {
    // print('vinay add kundli api run');
    await Future.delayed(Duration(seconds: 1));

    // DateTime dateTime = DateTime.now();
    final modelprofileview = Provider.of<DashboardModelPage>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');
    String? deviceToken = prefs.getString('device_token');
    // var useridconvertint = userid?.substring(1, userid.length - 1);
    var deviceTokenconvertint = deviceToken?.substring(1, deviceToken.length - 1);

    DateTime time = DateFormat('dd-MM-yyyy').parse(onlydate!);
    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
      "generate_kundli_image": _kundliUrl,
      "user_name": modelprofileview.userdataMap['name'].toString(),
      // "kundli_user_name": kundliName.text,
      "kundli_user_name": kundliName.text.isEmpty ? modelprofileview.userdataMap['name'].toString() : kundliName.text,
      "dob": onlydate,
      "birth_time": onlytime,
      // "birth_place": kundliPlace.text,
      "birth_place": selectaddres == null ? modelprofileview.userdataMap['address'].toString() : selectaddres,
      "lat": lattitude!.toStringAsFixed(2),
      "long": longitude!.toStringAsFixed(2),
      "time_zone": timezone,
      "birth_day": time.day,
      "birth_month": time.month,
      "birthday_year": time.year,
      "birth_time_hrs": onlytime!.substring(0, 2),
      "birth_time_mintus": onlytime!.substring(3),
      "device_id": deviceTokenconvertint,
      // "device_id":'RKQ1.200826.002',
    });
    // print(formData);
    // print('vinay add kundli api run1');
    var response = await dio.post(baseURL + "add_kundli", data: formData);

    // final responseData = json.decode(response.data);
    final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    // print('vinay add kundli api response $responseData ');

    try {
      if (responseData['status'] == true) {
        _kundligenratedetailslist = {
          'name': kundliName.text.isEmpty ? modelprofileview.userdataMap['name'].toString() : kundliName.text,
          'dob': onlydate,
          'birth_time': onlytime,
          'latitude': lattitude!.toStringAsFixed(2),
          'longitude': longitude!.toStringAsFixed(2),
          'timezone': timezone,
          'kundliimageurl': kundliUrl,
          'birth_place': selectaddres
        };
        notifyListeners();
        Future.delayed(Duration(seconds: 1));
        Get.to(() => DetailKundliPage(
              model: model,
            ));
        _selectaddres = null;
        notifyListeners();
        // print('vinay kundligenratedetailslist $kundligenratedetailslist');
      } else {
        // print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      // print('Error: ${e.toString()}');
    }
  }

  matchHoroscope(bName, DateTime bDOB, TimeOfDay bTime, bPlace, gName, DateTime gDOB, TimeOfDay gTime, gPlace) async {
    var loc = await locationFromAddress(bPlace!);
    var bLat = loc.first.latitude;
    var bLong = loc.first.longitude;

    loc = await locationFromAddress(gPlace!);
    var gLat = loc.first.latitude;
    var gLong = loc.first.longitude;

    toggleshemmerShow();
    DateTime dateTime = DateTime.now();
    _timezone = dateTime.timeZoneOffset;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'm_date': bDOB.day,
      'm_month': bDOB.month,
      'm_year': bDOB.year,
      'm_hour': bTime.hour,
      'm_minute': bTime.minute,
      'm_latitude': bLat.toStringAsFixed(2),
      'm_longitude': bLong.toStringAsFixed(2),
      'm_timezone': timezone,

      'f_date': gDOB.day,
      'f_month': gDOB.month,
      'f_year': gDOB.year,
      'f_hour': gTime.hour,
      'f_minute': gTime.minute,
      'f_latitude': gLat.toStringAsFixed(2),
      'f_longitude': gLong.toStringAsFixed(2),
      'f_timezone': timezone,
      // 'userid': 'aman946',
      // 'authcode': '621457c19852983c83f06ff992ee36d4'
    });
    try {
      var response = await dio.post("${folderURL}astrofeed/match-ashtakoot-points.php", data: formData);
      final responseData = json.decode(response.toString());
      debugPrint("$TAG responseData =======> $responseData");
      toggleshemmerdismis();
      notifyListeners();
      if (responseData['status'] == null) {
        return responseData;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
      notifyListeners();
    } catch(e) {
      toggleshemmerdismis();
      notifyListeners();
      debugPrint("$TAG error match Horoscope =======> ${e.toString()}");
    }
  }

  matchManglikReport(context, bName, DateTime bDOB, TimeOfDay bTime, bPlace, gName, DateTime gDOB, TimeOfDay gTime, gPlace) async {
    var loc = await locationFromAddress(bPlace!);
    var bLat = loc.first.latitude;
    var bLong = loc.first.longitude;

    loc = await locationFromAddress(gPlace!);
    var gLat = loc.first.latitude;
    var gLong = loc.first.longitude;

    toggleshemmerShow();
    DateTime dateTime = DateTime.now();
    _timezone = dateTime.timeZoneOffset;

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      'm_date': bDOB.day,
      'm_month': bDOB.month,
      'm_year': bDOB.year,
      'm_hour': bTime.hour,
      'm_minute': bTime.minute,
      'm_latitude': bLat.toStringAsFixed(2),
      'm_longitude': bLong.toStringAsFixed(2),
      'm_timezone': timezone,

      'f_date': gDOB.day,
      'f_month': gDOB.month,
      'f_year': gDOB.year,
      'f_hour': gTime.hour,
      'f_minute': gTime.minute,
      'f_latitude': gLat.toStringAsFixed(2),
      'f_longitude': gLong.toStringAsFixed(2),
      'f_timezone': timezone,
      // 'userid': 'aman946',
      // 'authcode': '621457c19852983c83f06ff992ee36d4'
    });

    try {
      var response = await dio.post("${folderURL}astrofeed/manglik-report.php", data: formData);
      final responseData = json.decode(response.toString());
      notifyListeners();
      toggleshemmerdismis();
      if (responseData['status'] == null) {
        return responseData;
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
      notifyListeners();
    } catch (e) {
      toggleshemmerdismis();
      notifyListeners();
      debugPrint("$TAG error match Manglik Report ======> ${e.toString()}");
    }
  }

  Future kudaliPanchangDetails(context, model) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();

    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': '${model.kundligenratedetailslist['timezone'].toString().split(':')[0]}.${model.kundligenratedetailslist['timezone'].toString().split(':')[1]}',
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };


    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/basic_panchang", data: map);
      if (response.statusCode == 200) {
        panchangDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future kudaliChart(context, model, chartId) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();

    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };

    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/horoscope_chart.php", data: formData);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/horo_chart_image/" + chartId, data: map);
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        chartImage = response.data['svg'];
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
        return panchangDetails;
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future kudaliChardashaDetails(context, model) async {
    toggleshemmerShow();
    await Future.delayed(Duration(seconds: 1));
    toggleshemmerShow();

    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };

    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/major_vdasha", data: map);
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        charDashDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
    }
  }

  Future YoginidahsDetails(context, model) async {
    toggleshemmerShow();
    await Future.delayed(Duration(seconds: 1));
    toggleshemmerShow();

    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };

    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/major_yogini_dasha", data: map);
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        yoginiDashaDetails1 = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
    }
  }

  Future loadAstroDetails(context, model) async {
    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };

    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/astro_details", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        astroDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadPlanetSignDetails(context, model) async {
    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/planets", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        planetSignDetails = response.data;
        //// print(planetSignDetails);
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadPlanetNakshtraDetails(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    // var response = await dio.post("https://json.astrologyapi.com/v1/general_nakshatra_report", data: map);
    var response = await dio.post("https://json.astrologyapi.com/v1/planets/extended", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        // print(response.statusCode);

        planetNakshatraDetails1 = response.data;

        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadKPPlanetDetails(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/kp_planets", data: map);

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        kpPlanetDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadRudrakshaRecc(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/rudraksha_suggestion", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        rudrashRecc = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadGemstoneRecc(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/basic_gem_suggestion", data: map);

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        gemRecc = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadKalpasaraDetails(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/kalsarpa_details", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        kalpasaraDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadManglikDetails(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/manglik", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        manglikDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadSadesatiDetails(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };
    // var response = await dio.post("http://md-54.whb.tempwebhost.net/~democdyb/astrologer/astrofeed/panchang.php", data: formData);
    var response = await dio.post("https://json.astrologyapi.com/v1/sadhesati_life_details", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        sadesatiDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadCurrentSadesatiDetails(context, model) async {
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/sadhesati_current_status", data: map);

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        currentSadesatiDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  Future loadKPCuspDetails(context, model) async {
    toggleshemmerShow();
    await Future.delayed(Duration(seconds: 1));
    toggleshemmerShow();

    Dio dio = Dio();
    dio.options.headers["authorization"] = "Basic " + encodedKey;
    DateTime time = DateFormat('dd-MM-yyyy').parse(model.kundligenratedetailslist['dob']);
    Map map = {
      'day': time.day,
      'month': time.month,
      'year': time.year,
      'lat': double.parse(model.kundligenratedetailslist['latitude']),
      'lon': double.parse(model.kundligenratedetailslist['longitude']),
      'tzone': model.kundligenratedetailslist['timezone'].toString().split(':')[0] + '.' + model.kundligenratedetailslist['timezone'].toString().split(':')[1],
      'hour': int.parse(model.kundligenratedetailslist['birth_time']!.substring(0, 2)),
      'min': int.parse(model.kundligenratedetailslist['birth_time']!.substring(3)),
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/kp_house_cusps", data: map);

    // final responseData = json.decode(response.data);
    // final responseData = json.decode(response.toString());
    //map is not a subtype of string error aaye to ye then apply

    try {
      if (response.statusCode == 200) {
        //// print('vinay split db userid sp $useridconvertint');

        kpCuspDetails = response.data;
        //// print('vkg kundlilist get $kundlilist');
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
        //// print('Error: ${responseData["message"]}');
      }
    } catch (e) {
      toggleshemmerdismis();
      // print('Error: ${e.toString()}');
      return "";
    }
  }

  downloadpdfkundli() async {
    // try {
    //   launch(kundliUrl!);
    // } on PlatformException catch (e) {
    //   launch(kundliUrl!);
    // } finally {
    //   launch(kundliUrl!);
    // }
  }
}
