import 'package:astrologyapp/common/appbar/chatpageAppbar.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/feedback/feedbackWidgetPage.dart';
import 'package:astrologyapp/feedback/feedbackpagemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dashboardModel = Provider.of<DashboardModelPage>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: appbarChatScreen(context, 'FEEDBACK'),
            ),
          ),
          body: Consumer<FeedbackPageModel>(
            builder: (context, model, _) {
              return SafeArea(
                child: Form(
                  key: formKey,
                  child: Container(
                    width: deviceWidth(context, 1.0),
                    height: deviceheight(context, 1.0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/BackGround.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 200,
                              height: 200,
                              child: Image(
                                image: AssetImage('assets/images/feedback.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            feedbackname(model, dashboardModel),
                            sizedboxheight(26.0),
                            feedbackemail(model, dashboardModel),
                            sizedboxheight(26.0),
                            feedbackpmobile(model, dashboardModel),
                            sizedboxheight(26.0),
                            messagebox(model),
                            sizedboxheight(26.0),
                            ratingwidget(context, model),
                            sizedboxheight(26.0),
                            sendfeedbackbtn(context, formKey, model),
                            sizedboxheight(26.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
