import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/commonwidgets/commonWidget.dart';
import '../../common/styles/const.dart';
import '../openkundlimodelpage.dart';

class KPTabScreen extends StatefulWidget {
  final kundaliList;

  const KPTabScreen({Key? key, this.kundaliList}) : super(key: key);

  @override
  _KPTabScreenState createState() => _KPTabScreenState();
}

class _KPTabScreenState extends State<KPTabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Openkundlimodelpage>(builder: (context, model, _) {
      return SizedBox(
        height: 73.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bhav Chalit Chart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2.h,
              ),
              SvgPicture.string(model.chartImage),
              SizedBox(
                height: 2.h,
              ),
              dividerHorizontal(),
              SizedBox(
                height: 2.h,
              ),
              // Text('Ruling Planet',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              // SizedBox(height: 2.h,),
              // rulingPlanetCard(model),
              const Text(
                'Planets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2.h,
              ),
              planetsCard(model),
              SizedBox(
                height: 2.h,
              ),
              dividerHorizontal(),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                'Cusp',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 2.h,
              ),
              cuspCard(model),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      );
    });
  }

  cuspCard(model) {
    List<Widget> list = [signRow('Cusp', 'Degree', 'Sign', 'Sign Lord', 'Star Load', 'Sub Lord', true)];

    if (model.kpCuspDetails != null) {
      model.kpCuspDetails.forEach((element) {
        list.add(
          signRow(
            element['house_id'].toString(),
            element['cusp_full_degree'].toString().substring(0, 4),
            element['sign'].toString(),
            element['sign_lord'].substring(0, 2),
            element['nakshatra_lord'].substring(0, 2),
            element['sub_lord'].substring(0, 2),
            false,
          ),
        );
      });
    }
    return Container(
      height: 68.h,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: list,
      ),
    );
  }

  planetsCard(model) {
    List<Widget> list = [signRow('Name', 'Cusp', 'Sign', 'Sign Lord', 'Star Load', 'Sub Lord', true)];

    if (model.kpPlanetDetails != null) {
      model.kpPlanetDetails.forEach((element) {
        list.add(signRow(element['planet_name'], element['house'].toString(), element['sign'], element['sign_lord'].substring(0, 2), element['nakshatra_lord'].substring(0, 2), element['sub_lord'].substring(0, 2), false));
      });
    }
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: list,
      ),
    );
  }

  rulingPlanetCard(
    model,
  ) {
    List<Widget> list = [rulingPlanetRow('--', 'Sign Lord', 'Star Lord', 'Sub Lord', true)];
    model.planetSignDetails.forEach((element) {
      list.add(rulingPlanetRow(element['name'], element['nakshatra'], element['nakshatraLord'], element['house'].toString(), false));
    });
    return Column(
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            border: borderCustom(),
            borderRadius: borderRadiuscircular(15.0),
          ),
          child: Column(
            children: list,
          ),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }

  rulingPlanetRow(palnet, nakshtra, nakshLord, house, isHeader) {
    return Expanded(
      child: Container(
        decoration: isHeader ? BoxDecoration(color: colororangeLight.withOpacity(0.4), borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))) : const BoxDecoration(),
        padding: const EdgeInsets.only(right: 5, left: 5),
        width: double.maxFinite,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 22.w,
              child: Text(
                palnet,
                // 'Planet',
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            // sizedboxheight(3.0),
            SizedBox(
              width: 22.w,
              child: Text(
                nakshtra,
                // "Nakshtra",
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(width: 3.w,),
            dividerVertical(),
            // SizedBox(width: 3.w,),
            SizedBox(
              width: 22.w,
              child: Text(
                nakshLord,
                // "Naksh Lord",
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 22.w,
              child: Text(
                house,
                // "House",
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  signRow(name, cusp, sign, signLord, starLord, subLord, isHeader) {
    return Expanded(
      child: Container(
        decoration: isHeader ? BoxDecoration(color: colororangeLight.withOpacity(0.4), borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15))) : const BoxDecoration(),
        padding: const EdgeInsets.only(right: 5, left: 5),
        width: double.maxFinite,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 12.w,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            // sizedboxheight(3.0),
            SizedBox(
              width: 12.w,
              child: Text(
                cusp,
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(width: 3.w,),
            dividerVertical(),
            // SizedBox(width: 3.w,),
            SizedBox(
              width: 16.w,
              child: Text(
                sign,
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 15.w,
              child: Text(
                signLord,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 15.w,
              child: Text(
                starLord,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 15.w,
              child: Text(
                subLord,
                style: textstylesubtitle1(context)!.copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
