import 'package:astrologyapp/chat/chat%20room/chatroomHistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

import '../../common/formtextfield/myTextField.dart';
import '../../common/styles/const.dart';

class ChatListScreenAstroWidget extends StatefulWidget {
  final model;
  final isCall;

  ChatListScreenAstroWidget({this.model, this.isCall});

  @override
  _ChatListScreenAstroWidgetState createState() => _ChatListScreenAstroWidgetState();
}

class _ChatListScreenAstroWidgetState extends State<ChatListScreenAstroWidget> {
  TextEditingController controller = TextEditingController();
  List astrologerList = [];

  List<FilterModel> sortList = [
    FilterModel(name: 'Experience: High to Low', isSelected: false),
    FilterModel(name: 'Experience: Low to High', isSelected: false),
    FilterModel(name: 'Price: Low to High', isSelected: false),
    FilterModel(name: 'Price: High to Low', isSelected: false),
    FilterModel(name: 'Rating: High to Low', isSelected: false),
  ];

  List<FilterModel> languageList = [
    FilterModel(name: 'Bengali', isSelected: false),
    FilterModel(name: 'English', isSelected: false),
    FilterModel(name: 'Gujarati', isSelected: false),
    FilterModel(name: 'Hindi', isSelected: false),
    FilterModel(name: 'Marathi', isSelected: false),
    FilterModel(name: 'Kannada', isSelected: false),
    FilterModel(name: 'Punjabi', isSelected: false),
    FilterModel(name: 'Tamil', isSelected: false),
  ];

  List<FilterModel> genderList = [
    FilterModel(name: 'Male', isSelected: false),
    FilterModel(name: 'Female', isSelected: false),
  ];

  List<FilterModel> offerList = [
    FilterModel(name: 'Active', isSelected: false),
    FilterModel(name: 'Not Active', isSelected: false),
  ];

  List<FilterModel> skillList = [
    FilterModel(name: 'Face Reading', isSelected: false),
    FilterModel(name: 'KP', isSelected: false),
    FilterModel(name: 'Life Coach', isSelected: false),
    FilterModel(name: 'Nadi', isSelected: false),
    FilterModel(name: 'Numerology', isSelected: false),
    FilterModel(name: 'Prashana', isSelected: false),
    FilterModel(name: 'Palmistry', isSelected: false),
    FilterModel(name: 'Psychic', isSelected: false),
    FilterModel(name: 'Tarot', isSelected: false),
    FilterModel(name: 'Vastu', isSelected: false),
    FilterModel(name: 'Vedic', isSelected: false),
  ];

  int selectedSkillCount = 0;
  int selectedLanguageCount = 0;
  int selectedGenderCount = 0;
  int selectedOfferCount = 0;
  FilterModel? selectedSort;

  bool isCalling = false;

  int selectedParameterIndex = 0;

  @override
  void initState() {
    astrologerList.addAll(widget.model.astrologerListdb);

    controller.addListener(() {
      String searchText = controller.text.toLowerCase();
      astrologerList = [];
      if (searchText.isNotEmpty) {
        for (int i = 0; i < widget.model.astrologerListdb.length; i++) {
          if (widget.model.astrologerListdb[i]['name'].toLowerCase().contains(searchText)) astrologerList.add(widget.model.astrologerListdb[i]);
        }
      } else {
        astrologerList.addAll(widget.model.astrologerListdb);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxheight(10.0),
        Row(
          children: [
            Expanded(
              child: AllInputDesign(
                controller: controller,
                fillColor: colorWhite,
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: colororangeLight,
                ),
                focusedBorderColor: colorblack.withOpacity(0.1),
                enabledOutlineInputBorderColor: colorblack.withOpacity(0.1),
                keyBoardType: TextInputType.text,
                validatorFieldValue: 'Phone',
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     showFilterView();
            //   },
            //   icon: Icon(
            //     Icons.sort,
            //     size: 36,
            //     color: colororangeLight,
            //   ),
            // ),
          ],
        ),
        sizedboxheight(10.0),
        Expanded(

          child: Container(
            // width: deviceWidth(context, 1.0),
            // height: deviceheight(context, 0.62),
            child: ListView.builder(
              itemCount: astrologerList.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: deviceWidth(context, 1.0),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: colorgreyblack.withOpacity(0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 9.h,
                              height: 9.h,
                              child: ClipOval(
                                child: astrologerList[index]['profile_image'] != null
                                    ? Image.network(
                                        "$imageURL${astrologerList[index]['profile_image']}",
                                        errorBuilder: (context, url, error) => const Image(
                                          image: AssetImage('assets/images/user.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : const Image(
                                        image: AssetImage('assets/images/user.png'),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                width: 50.w,
                                child: Text(
                                  astrologerList[index]['name'].toString(),
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.headline6!.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#000000'),
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 42.w,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (astrologerList[index]['dob'].toString() == 'null') ? '' : 'DOB: ' + astrologerList[index]['dob'],
                                          style: TextStyle(fontSize: 15, color: HexColor('#979797')),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          astrologerList[index]['birth_time'].toString() == 'null' ? '' : 'Birth Time: ' + astrologerList[index]['birth_time'],
                                          style: TextStyle(fontSize: 15, color: HexColor('#979797')),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                          astrologerList[index]['birth_place'].toString() == 'null' ? '' : 'Birth Place: ' + astrologerList[index]['birth_place'],
                                          style: TextStyle(fontSize: 15, color: HexColor('#979797')),
                                          maxLines: 1,
                                        ),
                                        // Text('Exp: 1-2 Year',style: TextStyle(fontSize: 15),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (widget.isCall) {
                            //call
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatRoomHistoryPage(
                                  userName: astrologerList[index]['name'],
                                  astroId: astrologerList[index]['id'].toString(),
                                  userId: astrologerList[index]['id'].toString(),
                                ),
                              ),
                            );
                            await model.toggelreseverid(astrologerList[index]['id']);
                            await model.toggelreseverSocketToken(astrologerList[index]['token']);
                            await model.toggelresevername(astrologerList[index]['name']);
                            await model.toggelreseverImage(astrologerList[index]['image_url']);
                            await model.toggelreseverdiveiceid(astrologerList[index]['device_id']);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: HexColor('#EFEFEF'),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 0.3), // changes position of shadow
                              )
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: HexColor('#EFEFEF'), width: 1),
                            ),
                            child: Icon(
                              widget.isCall ? Icons.call : Icons.chat_outlined,
                              color: colororangeLight,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  showFilterView() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.only(top: 2.h),
              child: Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sort & Filter',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  ),
                  Container(
                    height: 1.h,
                  ),
                  dividerHorizontal(),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                        child: Column(
                          children: [
                            filterParam('Sort by', 0, setState),
                            filterParam('Skill', 1, setState),
                            filterParam('Language', 2, setState),
                            filterParam('Gender', 3, setState),
                            filterParam('Offer', 4, setState),
                            Container(
                              height: 25.h,
                            )
                          ],
                        ),
                      ),
                      showDataOfFilterParameter(setState)
                    ],
                  ),
                  dividerHorizontal(),
                  Container(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              resetFilter();
                            },
                            child: Container(
                                width: 40.w,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 18),
                                ))),
                        InkWell(
                          onTap: () {
                            applyFilter();
                          },
                          child: Container(
                            height: 6.h,
                            width: 40.w,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colororangeLight),
                            child: const Text(
                              'Apply',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 2.h,
                  ),
                ],
              ),
            );
          });
        });
  }

  resetFilter() {
    astrologerList.addAll(widget.model.astrologerListdb);
    setState(() {});
    Navigator.pop(context);
  }

  applyFilter() {
    List filterList = [];
    astrologerList = [];
    astrologerList.addAll(widget.model.astrologerListdb);
    if (selectedSort != null) {
      sortListData(astrologerList);
    }

    for (var item in astrologerList) {
      if (checkItemExist(languageList, item['user_language'])) {
        filterList.add(item);
        continue;
      }
      if (checkItemExist(skillList, item['user_expertise'])) {
        filterList.add(item);
        continue;
      }
      if (checkItemExist(genderList, item['gender'])) {
        filterList.add(item);
        continue;
      }
    }

    if (filterList.isNotEmpty) {
      astrologerList = [];
      astrologerList.addAll(filterList);
    }

    setState(() {});
    Navigator.pop(context);
  }

  sortListData(filterList) {
    if (selectedSort != null) {
      if (selectedSort!.name == 'Experience: Low to High') {
        filterList.sort((a, b) {
          return a['user_experience'].toString().toLowerCase().compareTo(b['user_experience'].toString().toLowerCase());
        });
      } else if (selectedSort!.name == 'Experience: High to Low') {
        filterList.sort((a, b) {
          return b['user_experience'].toString().toLowerCase().compareTo(a['user_experience'].toString().toLowerCase());
        });
      } else if (selectedSort!.name == 'Price: Low to High') {
        filterList.sort((a, b) {
          return a['per_minute'].toString().toLowerCase().compareTo(b['per_minute'].toString().toLowerCase());
        });
      } else if (selectedSort!.name == 'Price: High to Low') {
        filterList.sort((a, b) {
          return b['per_minute'].toString().toLowerCase().compareTo(a['per_minute'].toString().toLowerCase());
        });
      } else if (selectedSort!.name == 'Rating: High to Low') {
        filterList.sort((a, b) {
          return b['user_rating'].toString().toLowerCase().compareTo(a['user_rating'].toString().toLowerCase());
        });
      }
    }
  }

  checkItemExist(List<FilterModel> list, item) {
    for (FilterModel model in list) {
      if (model.isSelected) {
        if (item != null) {
          if (item.toLowerCase().contains(model.name.toLowerCase())) return true;
        }
      }
    }
    return false;
  }

  Widget showDataOfFilterParameter(setState) {
    if (selectedParameterIndex == 0) {
      return buildSortList(sortList, setState);
    } else if (selectedParameterIndex == 1) {
      return buildParameterList(1, skillList, setState);
    } else if (selectedParameterIndex == 2) {
      return buildParameterList(2, languageList, setState);
    } else if (selectedParameterIndex == 3) {
      return buildParameterList(3, genderList, setState);
    } else if (selectedParameterIndex == 4) {
      return buildParameterList(4, offerList, setState);
    }
    return Container(
      height: 20.h,
    );
  }

  Widget buildSortList(list, setState) {
    return Container(
      height: 50.h,
      width: 55.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                setState(() {
                  selectedSort = null;
                });
              },
              child: Container(
                  width: 50.w,
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ))),
          SizedBox(
            height: 4.h,
          ),
          ListView.builder(
              // physics: ScrollPhysics(),
              itemCount: list.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedSort = list[index];
                    });
                  },
                  child: Row(
                    children: [
                      Radio<FilterModel>(
                        value: list[index],
                        groupValue: selectedSort,
                        onChanged: (value) {
                          setState(() {
                            selectedSort = list[index];
                          });
                        },
                        fillColor: MaterialStateProperty.all<Color>(colororangeLight),
                      ),
                      SizedBox(
                          width: 41.w,
                          child: Text(
                            list[index].name,
                            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                          ))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget buildParameterList(type, list, setState) {
    return Container(
      height: 50.h,
      width: 50.w,
      // margin: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
          // physics: ScrollPhysics(),
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (!list[index].isSelected) {
                  if (type == 1)
                    selectedSkillCount += 1;
                  else if (type == 2)
                    selectedLanguageCount += 1;
                  else if (type == 3)
                    selectedGenderCount += 1;
                  else if (type == 4) selectedOfferCount += 1;
                } else {
                  if (type == 1)
                    selectedSkillCount -= 1;
                  else if (type == 2)
                    selectedLanguageCount -= 1;
                  else if (type == 3)
                    selectedGenderCount -= 1;
                  else if (type == 4) selectedOfferCount -= 1;
                }
                setState(() {
                  list[index].isSelected = !list[index].isSelected;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      list[index].isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: colororangeLight,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      list[index].name,
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget filterParam(String name, int index, setState) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedParameterIndex = index;
        });
      },
      child: Container(
        height: 6.h,
        width: 160,
        decoration: BoxDecoration(
          color: selectedParameterIndex == index ? Colors.white : Colors.grey.shade200,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(
                width: 30.w,
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                )),
            if ((index == 0 && selectedSort != null) || (index == 1 && selectedSkillCount > 0) || (index == 2 && selectedLanguageCount > 0) || (index == 3 && selectedGenderCount > 0) || (index == 4 && selectedOfferCount > 0))
              Container(
                height: 1.h,
                width: 1.h,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colororangeLight),
              )
          ],
        ),
      ),
    );
  }
}

class FilterModel {
  String name;
  bool isSelected;

  FilterModel({required this.name, required this.isSelected});
}
