import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

import 'notificationModelPage.dart';

Widget notificationListWidget(BuildContext context, NotificationModelPage model) {
  return model.notificationList.isEmpty
      ? const Center(
          child: Text(
            'No any new notification found',
          ),
        )
      : ListView.builder(
          itemCount: model.notificationList.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: colorblack,
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorgreyblack.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: ListTile(
                    minLeadingWidth: 5,
                    leading: const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.notifications_none,
                      ),
                    ),
                    title: Text(
                      model.notificationList[index]['message'].toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        formatNotificationDate(model.notificationList[index]['currents_date'].toString()),
                        style: textstylesubtitle2(context)!.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    // trailing: Container(
                    //   padding: const EdgeInsets.only(
                    //     top: 30,
                    //   ),
                    //   child: Text(
                    //     model.notificationList[index]['currents_date'].toString(),
                    //     style: textstylesubtitle2(context)!.copyWith(
                    //       fontSize: 14,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            );
          });
}

void showCapturedWidgetPost(context, postsIndex) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(postsIndex['title'].toString()),
      content: Text(postsIndex['body'].toString()),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("okay"),
        ),
      ],
    ),
  );
}

placeHolder(double height) {
  return const AssetImage(
    'assets/images/placeholder.png',
  );
}

erroWidget(double size) {
  return Image.asset(
    'assets/images/placeholder.png',
    height: size,
    width: size,
  );
}
