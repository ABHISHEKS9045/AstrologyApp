import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../common/commonwidgets/commonWidget.dart';
import '../../common/shimmereffect.dart';
import '../../common/styles/const.dart';
import '../openkundlimodelpage.dart';
import 'kundlidetailswidgetPage.dart';

class AshtakVargTabScreen extends StatefulWidget {
  final kundaliList;
  const AshtakVargTabScreen({Key? key,this.kundaliList}) : super(key: key);

  @override
  _AshtakVargTabScreenState createState() => _AshtakVargTabScreenState();
}

class _AshtakVargTabScreenState extends State<AshtakVargTabScreen> {

  @override
  void initState() {
    super.initState();
  }

  int chartIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<Openkundlimodelpage>(builder: (context, model, _) {
      return SizedBox(
        height: 73.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ashtakvarga Chart',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 2.h,),
              SizedBox(width: 90.w,
                  child: Text(
                      'Ashtakvarga is used to assess the strength and patterns that are present in a birth chart. The Ashtakvarga or Ashtakavarga is a numerical quantification or score of each planet placed in the chart with reference to the other 7 planets and the Lagna. In Sarva Ashtaka Varga the total scores of all the BAVS are overlaid and then totalled. This makes the SAV of the chart. The total of all the scores should be 337.',
                    style: TextStyle(height: 0.2.h,color: Colors.grey.shade500),
                    textAlign: TextAlign.justify,

                  )
              ),
              SizedBox(height: 2.h,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SwichTab(
                      0,'Sav'
                    ),
                    SwichTab(
                      1,'Asc'
                    ),
                    SwichTab(
                      2,'Jupiter'
                    ),
                    SwichTab(
                      3,'Mars'
                    ),
                    SwichTab(
                      4,'Mercury'
                    ),
                    SwichTab(
                        5,'Moon'
                    ),
                    SwichTab(
                        6,'Saturn'
                    ),
                    SwichTab(
                        7,'Sun'
                    ),
                    SwichTab(
                        8,'Venus'
                    ),

                  ],
                ),
              ),
              
             IndexedStack(
               index: chartIndex,
               children: [
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
                 SvgPicture.string(model.chartImage),
               ],
             )
            ],
          ),
        ),
      );
    });


  }

  Container SwichTab( int index,String tabName) {
    return Container(
      margin: EdgeInsets.only(right: 10,bottom: 5),
      child: InkWell(
        onTap: (){
          setState(() {
            chartIndex = index;
          });

        },
        child: Container(

          padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: chartIndex == index ? colororangeLight.withOpacity(0.2) : Colors.white,
              border: Border.all(color: chartIndex == index ? colororangeLight : Colors.grey,width: 2)
          ),
          child: Text(tabName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
        ),
      ),
    );
  }
}
