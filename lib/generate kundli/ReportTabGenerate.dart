import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../common/MaterialDesignIndicator.dart';
import '../common/commonwidgets/commonWidget.dart';
import '../common/shimmereffect.dart';
import '../common/styles/const.dart';
import 'generatekundaliModelPage.dart';

class ReportTabGenerate extends StatefulWidget {
  final kundaliList;
  const ReportTabGenerate({Key? key,this.kundaliList}) : super(key: key);

  @override
  _ReportTabGenerateState createState() => _ReportTabGenerateState();
}

class _ReportTabGenerateState extends State<ReportTabGenerate>with TickerProviderStateMixin {
  var chartTypes = [
    Tab(text: 'General',),
    Tab(text: 'Remedies',),
    Tab(text: 'Dasha',),
  ];
  late TabController _chartTypeTabController;
  @override
  void initState() {
    _chartTypeTabController = TabController(length: 3, vsync: this);
    super.initState();
  }
  int buttonIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<GenratekundliModelPage>(builder: (context, model, _) {
      return SizedBox(
        height: 71.h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                onTap: (index){
                  setState(() {
                    _chartTypeTabController.index = index;
                  });
                },
                controller: _chartTypeTabController,
                isScrollable: true,
                labelColor: colororangeLight,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialDesignIndicator(
                    indicatorHeight: 4, indicatorColor: colororangeLight),
                tabs: chartTypes,
                labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 2.h,),
              Builder(builder: (_){
                if(_chartTypeTabController.index==0){
                  return generalWidget();
                }if(_chartTypeTabController.index==1){
                  return remediesWidget(model);
                }else{
                  return dashaWidget(model);
                }
              },),
              SizedBox(height: 2.h,),
            ],
          ),
        ),
      );
    });

  }
  String selectedRem = 'Rudraksha';
  String selectedDasha = 'Manglik';

  dashaWidget(model){
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    selectedDasha = 'Manglik';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: selectedDasha == 'Manglik' ? colororangeLight.withOpacity(0.2) : Colors.white,
                      border: Border.all(color: selectedDasha == 'Manglik' ? colororangeLight : Colors.grey,width: 2)
                  ),
                  child: Text('Manglik',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                ),
              ),
              SizedBox(width: 3.w,),
              InkWell(
                onTap: (){
                  setState(() {
                    selectedDasha = 'Kalpasarpa';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: selectedDasha == 'Kalpasarpa' ? colororangeLight.withOpacity(0.2) : Colors.white,
                      border: Border.all(color: selectedDasha == 'Kalpasarpa' ? colororangeLight : Colors.grey,width: 2)
                  ),
                  child: Text('Kalpasarpa',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                ),
              ),
              SizedBox(width: 3.w,),
              InkWell(
                onTap: (){
                  setState(() {
                    selectedDasha = 'Sadhesati';
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: selectedDasha == 'Sadhesati' ? colororangeLight.withOpacity(0.2) : Colors.white,
                      border: Border.all(color: selectedDasha == 'Sadesati' ? colororangeLight : Colors.grey,width: 2)
                  ),
                  child: Text('Sadhesati',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        if(selectedDasha == 'Manglik')
          manglikWidget(model)
        else if(selectedDasha == 'Kalpasarpa')
          kalpasarpaWidget(model)
        else if(selectedDasha == 'Sadhesati')
          sadeSatiWidget(model)


      ],
    );
  }
  kalpasarpaWidget(model){
    bool isKalpasarpa = model.kalpasaraDetails['present'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kalpasarpa Analysis',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: isKalpasarpa ? Colors.red : Colors.green,width: 2)
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: isKalpasarpa ? Colors.red : Colors.green),
                    color: isKalpasarpa ? Colors.red : Colors.green
                ),
                child: Text(isKalpasarpa ? 'Yes' : 'No',style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
              SizedBox(width: 3.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.kundligenratedetailslist['name'].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                    SizedBox(height: 1.h,),
                    Text(model.kalpasaraDetails['one_line'],style: TextStyle(fontSize: 14),)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h,),
        Center(
          child: SizedBox(width: 90.w,
            child: Text("Kaalsarp dosh in astrology is considered as one of the most concerning doshas. According to astrology, Kaalsarp dosh is often a result of one's past deeds or karma. The presence of this dosh in your kundli may create hurdles or delays across different aspects of your life such as career, love, marriage, health and more. The Kaalsarp dosh is formed when Rahu and Ketu are present on one side in the horoscope and all other planets are in their midst.",
                style: TextStyle(height: 0.16.h,fontSize: 15,),textAlign: TextAlign.justify,
            ),
          ),
        ),
        SizedBox(height: 2.h,),
        Center(
          child: SizedBox(width: 90.w,
            child: Text("As per astrology, there are seven main planets (excluding Rahu and Ketu), each of them ruling various aspects such as Lagna, wealth, happiness, children, disease, household, age, fortune, karma, profit, love, expenditure, etc. As Kaalsarp dosh veils the planets, the aspects they represent may get hampered, which may lead to problems in the life of the native. In astrology, there are as many as 12 Kaalsarp doshas. Each of these form as per the placement of Rahu and Ketu in the native's chart. Your kundli has Padam Kaalsarp dosh.",
              style: TextStyle(height: 0.16.h,fontSize: 15,),textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
  sadeSatiWidget(model){
    bool isSadesati = model.currentSadesatiDetails['sadhesati_status'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sadhesati Analysis',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: isSadesati ? Colors.red : Colors.green,width: 2)
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: isSadesati ? Colors.red : Colors.green),
                    color: isSadesati ? Colors.red : Colors.green
                ),
                child: Text(isSadesati ? 'Yes' : 'No',style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
              SizedBox(width: 3.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Sadhesati Status',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                    SizedBox(height: 1.h,),
                    Text(model.currentSadesatiDetails['is_undergoing_sadhesati'],style: TextStyle(fontSize: 14),)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h,),
        signPlanetView(model)
      ],
    );
  }
  signPlanetView(model){
    List<Widget> list = [
      signRow('Moon Sign','Saturn Sign','Type','Date',true)
    ];

    model.sadesatiDetails.forEach((element) {
      list.add(signRow(element['moon_sign'],element['saturn_sign'],element['type'].toString().split('_')[0],element['date'],false));
    });
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),
      child: Column(
        children: list,
      ),
    );
  }
  signRow(name,sign,signLord,house,isHeader){
    return Expanded(
      child: Container(
        decoration: isHeader ? BoxDecoration(
            color:   colororangeLight.withOpacity(0.4),
            borderRadius:

            BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))

        ) : BoxDecoration(),
        padding: EdgeInsets.only(right: 5,left: 5),
        width: double.maxFinite,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 20.w,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            // sizedboxheight(3.0),
            SizedBox(
              width: 22.w,
              child: Text(
                sign,
                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(width: 3.w,),
            dividerVertical(),
            // SizedBox(width: 3.w,),
            SizedBox(
              width: 23.w,
              child: Text(
                signLord,
                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
            dividerVertical(),
            SizedBox(
              width: 20.w,
              child: Text(
                house.toString(),
                style: textstylesubtitle1(context)!
                    .copyWith(fontWeight: isHeader ? fontWeight900 : fontWeight500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  manglikWidget(model){
    bool isManglik = model.manglikDetails['is_present'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Manglik Analysis',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: isManglik ? Colors.red : Colors.green,width: 2)
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: isManglik ? Colors.red : Colors.green),
                    color: isManglik ? Colors.red : Colors.green
                ),
                child: Text(isManglik ? 'Yes' : 'No',style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
              SizedBox(width: 3.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.kundligenratedetailslist['name'].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                    SizedBox(height: 1.h,),
                    Text(model.manglikDetails['manglik_report'],style: TextStyle(fontSize: 14),)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3.h,),
        SizedBox(width: 90.w,
          child: Text('This is computer generated result. Please consult an Astrologer to confirm & understand this is details.',
            style: TextStyle(height: 0.18.h,color: Colors.grey,fontSize: 14)
          ),
        )
      ],
    );
  }
  remediesWidget(model){
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  selectedRem = 'Rudraksha';
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: selectedRem == 'Rudraksha' ? colororangeLight.withOpacity(0.2) : Colors.white,
                    border: Border.all(color: selectedRem == 'Rudraksha' ? colororangeLight : Colors.grey,width: 2)
                ),
                child: Text('Rudraksha',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              ),
            ),
            SizedBox(width: 3.w,),
            InkWell(
              onTap: (){
                setState(() {
                  selectedRem = 'Nakshatra';
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: selectedRem != 'Rudraksha' ? colororangeLight.withOpacity(0.2) : Colors.white,
                    border: Border.all(color: selectedRem != 'Rudraksha' ? colororangeLight : Colors.grey,width: 2)
                ),
                child: Text('Gemstones',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
              ),
            )
          ],
        ),
        SizedBox(height: 2.h),
        selectedRem == 'Rudraksha' ?
        rudrakshaView(model) : gemstonesView(model),

      ],
    );
  }
  rudrakshaView(model){
    return Column(
      children: [
        Container(
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
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
              SizedBox(height: 1.h,),
              Text("This Rudraksha suggestion report aims to help you choose the most suitable Rudraksha that you can wear to have the blessings of Lord Shiva. This report considers the Nakshatra that you were born in to suggest the most appropriate Rudraksha for you. Wearing the recommended Rudraksha shall shield you against the negative energies and help retain positivity.",
                style: TextStyle(height: 0.17.h,color: Colors.grey.shade500),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
        SizedBox(height: 2.h,),
        Container(
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
                "Recommendation",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
              ),
              SizedBox(height: 1.h,),
              Text(model.rudrashRecc['detail'],
                style: TextStyle(height: 0.17.h,color: Colors.grey.shade500),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ],
    );
  }
  gemstonesView(model){
    String rashi = model.astroDetails['ascendant'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Life Stone',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        Container(
          width: 90.w,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade300,width: 2)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Life Stone for '+rashi,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 2.h,),
              Text("A life stone is a gem for the Lagna lord, which the native can wear throughout his or her life. A life stone collectively influences everything that makes your self-image, i.e. your wealth, education, health, business, spouse, intellect, etc",
                style: TextStyle(fontSize: 15,height: 0.16.h),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 2.h,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300,width: 2)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 1.h,),
                    Container(
                      height: 5.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        children: [
                          SizedBox(width: 40.w,child: Text('Life stone',style: TextStyle(fontSize: 18),)),
                          SizedBox(width: 30.w,child: Text(model.gemRecc['LIFE']['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      alignment: Alignment.center,
                      color: colororangeLight.withOpacity(0.2),
                      child: Row(
                        children: [
                          SizedBox(width: 40.w,child: Text('Wear metal',style: TextStyle(fontSize: 18),)),
                          SizedBox(width: 30.w,child: Text(model.gemRecc['LIFE']['wear_metal'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 40.w,child: Text('Wear finger',style: TextStyle(fontSize: 18),)),
                          SizedBox(width: 30.w,child: Text(model.gemRecc['LIFE']['wear_finger'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,),

                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 3.h,),

        Text('Lucky Stone',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(height: 2.h,),
        Container(
          width: 90.w,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.grey.shade300,width: 2)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Luck Gemstone for '+rashi,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 2.h,),
              Text("A lucky gemstone is worn to enhance the native's luck and open new doors to success for him. An individual's lucky stone is one that keeps luck ticking for him while ensuring the blessing of favourable planets upon him.",
                style: TextStyle(fontSize: 15,height: 0.16.h),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 2.h,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300,width: 2)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 1.h,),
                    Container(
                      height: 5.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        children: [
                          SizedBox(width: 40.w,child: Text('Lucky stone',style: TextStyle(fontSize: 18),)),
                          SizedBox(width: 30.w,child: Text(model.gemRecc['LUCKY']['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      alignment: Alignment.center,
                      color: colororangeLight.withOpacity(0.2),
                      child: Row(
                        children: [
                          SizedBox(width: 40.w,child: Text('Wear metal',style: TextStyle(fontSize: 18),)),
                          SizedBox(width: 30.w,child: Text(model.gemRecc['LUCKY']['wear_metal'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    Container(
                      height: 5.h,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(width: 40.w,child: Text('Wear finger',style: TextStyle(fontSize: 18),)),
                          SizedBox(width: 30.w,child: Text(model.gemRecc['LUCKY']['wear_finger'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,),

                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 3.h,),

      ],
    );
  }
  understandKundali(heading,content){
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),

      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: borderCustom(),
        borderRadius: borderRadiuscircular(15.0),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,


        children: [
          Text(heading,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 1.h),
          Text(content,style: TextStyle(
              fontSize: 14,
              height: 0.17.h,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600
          ),),




        ],
      ),

    );
  }
  Container SwichTab( int index,String tabName) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: (){
          setState(() {
            buttonIndex = index;
          });
        },
        child: Container(

          padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 5.w),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: buttonIndex == index ? colororangeLight.withOpacity(0.2) : Colors.white,
              border: Border.all(color: buttonIndex == index ? colororangeLight : Colors.grey,width: 2)
          ),
          child: Text(tabName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
        ),
      ),
    );
  }
  generalWidget(){
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SwichTab(
                  0,'General'
              ),
              SwichTab(
                  1,'Planetary'
              ),
              SwichTab(
                  2,'Yoga'
              ),
              SwichTab(
                  3,'Vimshottari Dasha'
              ),


            ],
          ),
        ),
        SizedBox(height: 2.h,),
        IndexedStack(

          index: buttonIndex,
          children: [
            Container(
              child: Column(children: [
                understandKundali('Description',sighDescription),
                understandKundali('Personality',signPersonality,),
                understandKundali('Health',signPersonality,),
                understandKundali('Career',signCareer,),
                understandKundali('Relationship',signPersonality,),
              ],),
            ),
            Container(
              child: Column(children: [
                understandKundali('Sun Consideration',signSunConsi),
                understandKundali('Moon Consideration',signmoonConsi,),
                understandKundali('Mercury Consideration',signMercuryConsi,),
                understandKundali('Venus Consideration',signVenusConsi,),
                understandKundali('Mars Consideration',signMarsConsi,),
                understandKundali('Jupiter Consideration',signJupiterConsi,),

                understandKundali('Saturn Consideration',signsaturnConsi,),
                understandKundali('Rahu Consideration',signRahuConsi,),
                understandKundali('Ketu Consideration',signKetuConsi,),
              ],),
            ),
            Container(
              child: Column(children: [
                understandKundali('Vesi Yoga',signVesiYoga),
                understandKundali('Lakshmi Yoga',signmoonConsi,),
                understandKundali('Kemadruma Yoga',signMercuryConsi,),
                understandKundali('Sakata Yoga',signVenusConsi,),

              ],),
            ),
            Container(
              child: Column(children: [
                understandKundali('Venus Mahadasha',VenusMahadasha),
                understandKundali('Sun Mahadasha',sumMahadash,),
                understandKundali('Moon Mahadasha',moonMahadasha,),


              ],),
            ),

          ],

        )


        // Container(
        //   width: 95.w,
        //   padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15),
        //       border: Border.all(width: 1,color: Colors.grey.shade400)
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //
        //
        //       Text(
        //         "Description",
        //         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        //       ),
        //       SizedBox(height: 1.h,),
        //       Text("Ascendant is one of the most sought concepts in astrology when it comes to predicting the minute events in your life. At the time of birth, the sign that rises in the sky is the person's ascendant. It helps in making predictions about the minute events, unlike your Moon or Sun sign that help in making weekly, monthly or yearly predictions for you. Your ascendant is Taurus.",
        //         style: TextStyle(height: 0.17.h,color: Colors.grey.shade500),
        //         textAlign: TextAlign.justify,
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(height: 2.h,),
        // Container(
        //   width: 95.w,
        //   padding: EdgeInsets.symmetric(vertical: 1.5.h,horizontal: 3.w),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15),
        //       border: Border.all(width: 1,color: Colors.grey.shade400)
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         "Personality",
        //         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        //       ),
        //       SizedBox(height: 1.h,),
        //       Text("Those born with the Taurus sign are relatively introverted, despite the fact they represent the animal bull. These people like to create their own little world stud with luxuries and comfort. However, they are also aware of the fact that having these luxuries will require hard work and commitment and thus always try to achieve greater and better things in life. Despite being an introvert, Taurus ascendants are really friendly and fun-loving. These people also have a great sense of humor, and you could never get bored when around them. However, one should know that these people never reveal all of them to anybody. They have their secrets which they try to deal with personally.",
        //         style: TextStyle(height: 0.17.h,color: Colors.grey.shade500),
        //         textAlign: TextAlign.justify,
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }

}
