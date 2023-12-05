import 'package:astrologyapp/common/styles/const.dart';
import 'package:flutter/material.dart';

Container bottomNavBarPageWidget(context, model) {
  return Container(
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: colorblack,
      showUnselectedLabels: true,
      elevation: 10,
      selectedFontSize: 13,
      selectedItemColor: colororangeLight,
      unselectedLabelStyle: TextStyle(fontSize: 12, color: colorblack),
      onTap: (index) {
        model.toggle(context, index);
      },
      currentIndex: model.bottombarzindex,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Call',
        ),
        BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colororangeLight, width: 1),
            ),
            width: 30,
            height: 30,
            padding: const EdgeInsets.all(5.0),
            child: Image.asset('assets/icons/Freekundli.png', color: colororangeLight),
          ),
          label: 'Kundali',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          label: 'Chat',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5_outlined),
          label: 'Settings',
        ),
      ],
    ),
  );
}
