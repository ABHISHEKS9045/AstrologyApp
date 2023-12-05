import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common/commonwidgets/commonWidget.dart';
import '../common/shimmereffect.dart';
import '../common/styles/const.dart';
import 'generatekundaliModelPage.dart';

class DashaTabScreenGenerate extends StatefulWidget {
  final kundaliList;
  const DashaTabScreenGenerate({Key? key,this.kundaliList}) : super(key: key);

  @override
  _DashaTabScreenGenerateState createState() => _DashaTabScreenGenerateState();
}

class _DashaTabScreenGenerateState extends State<DashaTabScreenGenerate> {

  int tabIndex =0;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GenratekundliModelPage>(builder: (context, model, _) {

      return model.isShimmer ? loadingForKundaliTabs() : SizedBox(
        height: 71.h,
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SwichTab(0,'Vimshottari'),
                  SwichTab(1,'Yogini'),
                ],
              ),



              sizedboxheight(10.0),
              IndexedStack(
                index: tabIndex,
                children: [
                  Container(child:
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,

                          child: Text('Vimshottari Dasha',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                      SizedBox(height: 2.h,),
                      Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          border: borderCustom(),
                          borderRadius: borderRadiuscircular(15.0),
                        ),
                        child: Column(
                          children: [
                            dashaRow(context, 'Planets', 'Start Date' , 'End Date',true),
                            dividerHorizontal(),
                            dashaRow(context, model.charDashDetails[0]['planet'], model.charDashDetails[0]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),

                            dashaRow(context, model.charDashDetails[1]['planet'], model.charDashDetails[1]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),
                            dashaRow(context, model.charDashDetails[2]['planet'], model.charDashDetails[2]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),

                            dividerHorizontal(),dashaRow(context, model.charDashDetails[3]['planet'], model.charDashDetails[3]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),
                            dividerHorizontal(),dashaRow(context, model.charDashDetails[4]['planet'], model.charDashDetails[4]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),
                            dividerHorizontal(),dashaRow(context, model.charDashDetails[5]['planet'], model.charDashDetails[5]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),
                            dividerHorizontal(),dashaRow(context, model.charDashDetails[6]['planet'], model.charDashDetails[6]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),
                            dividerHorizontal(),dashaRow(context, model.charDashDetails[7]['planet'], model.charDashDetails[7]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),
                            dividerHorizontal(),dashaRow(context, model.charDashDetails[8]['planet'], model.charDashDetails[8]['start'].substring(0, 10) , model.charDashDetails[0]['end'].substring(0, 10),false),
                            dividerHorizontal(),








                          ],
                        ),
                      ),
                      // SizedBox(height: 2.h,),
                      // dividerHorizontal(),
                      // SizedBox(height: 2.h,),
                      // Text('Understanding your dasha',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      // SizedBox(height: 2.h,),
                      // yourDasha(model)
                    ],
                  ),),
                  Container(child:
                  Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,

                          child: Text('Yogini Dasha',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                      SizedBox(height: 2.h,),
                      Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          border: borderCustom(),
                          borderRadius: borderRadiuscircular(15.0),
                        ),
                        child: Column(
                          children: [
                            dashaRow(context, 'Planets', 'Start Date' , 'End Date',true),
                            dividerHorizontal(),
                            dashaRow(context, model.yoginiDashaDetails1[0]['dasha_name'], model.yoginiDashaDetails1[0]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[0]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),
                            //
                            dashaRow(context, model.yoginiDashaDetails1[1]['dasha_name'], model.yoginiDashaDetails1[1]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[1]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),
                            dashaRow(context, model.yoginiDashaDetails1[2]['dasha_name'], model.yoginiDashaDetails1[2]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[2]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),
                            dashaRow(context, model.yoginiDashaDetails1[3]['dasha_name'], model.yoginiDashaDetails1[3]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[3]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),

                            dashaRow(context, model.yoginiDashaDetails1[4]['dasha_name'], model.yoginiDashaDetails1[4]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[4]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),
                            dashaRow(context, model.yoginiDashaDetails1[5]['dasha_name'], model.yoginiDashaDetails1[5]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[5]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),
                            dashaRow(context, model.yoginiDashaDetails1[6]['dasha_name'], model.yoginiDashaDetails1[6]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[6]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),
                            dashaRow(context, model.yoginiDashaDetails1[7]['dasha_name'], model.yoginiDashaDetails1[7]['start_date'].substring(0, 10) , model.yoginiDashaDetails1[7]['end_date'].substring(0, 10),false),
                            dividerHorizontal(),

                            //
                            //








                          ],
                        ),
                      ),
               
                    ],
                  ),),
                ],
              )
            ],
          ),
        ),
      );
    });

  }



  yourDasha(model){
    List<Widget> list = [
    ];

    model.charDashDetails.forEach((element) {
      list.add(Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        width: 95.w,
        padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1,color: Colors.grey.shade400)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element['sign_name']+' ('+element['start_date']+" - "+element['end_date'] + ")",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
            ),
            SizedBox(height: 1.h,),
            Text("The planet Mercury is in the eighth house of the Kundli. During this Dasha period, things would run positively in your life. You will attain recognition in society, and fame from your righteous deeds will come to you. As the Dasha time moves ahead, you would capably help your relatives in all manners and shall encounter peace in it. Gains from the profession as well as land and properties would be in your bag as well. Not just this, with Mercury in the eighth house in the Dasha period, happiness will find its way to you in terms of wealth and satisfying family life.",
              style: TextStyle(height: 0.17.h,color: Colors.grey.shade500),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ));
    });
    return Column(
      children: list,
    );
  }

  Widget dashaRow(context, title, start, end ,bool isHeader) {
    return Expanded(
      child: Container(
        decoration: isHeader ? BoxDecoration(
            color:   colororangeLight.withOpacity(0.4),
            borderRadius:

            BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))

        ) : BoxDecoration(),
        padding: EdgeInsets.only(right: 10,left: 15),
        width: double.maxFinite,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 19.w,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 3.w,),
            dividerVertical(),
            SizedBox(width: 3.w,),
            // sizedboxheight(3.0),
            SizedBox(
              width: 26.w,
              child: Text(
                start,

                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 3.w,),
            dividerVertical(),
            SizedBox(width: 3.w,),
            SizedBox(
              width: 24.w,
              child: Text(
                end,
                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container SwichTab( int index,String tabName) {
    return Container(
      margin: EdgeInsets.only(right: 10,bottom: 5),
      child: InkWell(
        onTap: (){

          setState(() {
            tabIndex = index;
          });

        },
        child: Container(

          padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: tabIndex == index ? colororangeLight.withOpacity(0.2) : Colors.white,
              border: Border.all(color: tabIndex == index ? colororangeLight : Colors.grey,width: 2)
          ),
          child: Text(tabName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
        ),
      ),
    );
  }

}
