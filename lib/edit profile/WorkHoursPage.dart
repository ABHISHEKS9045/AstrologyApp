import 'package:flutter/Material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/commonwidgets/commonWidget.dart';
import '../common/styles/const.dart';
import 'WorkingHoursModel.dart';
import 'editprofilemodel.dart';

class WorkHoursPage extends StatefulWidget {
  const WorkHoursPage({Key? key}) : super(key: key);

  @override
  State<WorkHoursPage> createState() => _WorkHoursPageState();
}

class _WorkHoursPageState extends State<WorkHoursPage> {

  String TAG = "_WorkHoursPageState";
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> availableDays = [];

  @override
  void initState() {
    var model = Provider.of<EditProfileModel>(context, listen: false);
    debugPrint("$TAG model working Hours =========> ${model.workingHours.length}");
    if(model.workingHours.isEmpty) {
      model.workingHours = [
        WorkingHoursModel(day: 'Monday', timeslot: []),
        WorkingHoursModel(day: 'Tuesday', timeslot: []),
        WorkingHoursModel(day: 'Wednesday', timeslot: []),
        WorkingHoursModel(day: 'Thursday', timeslot: []),
        WorkingHoursModel(day: 'Friday', timeslot: []),
        WorkingHoursModel(day: 'Saturday', timeslot: []),
        WorkingHoursModel(day: 'Sunday', timeslot: [])
      ];
    } else {
      availableDays.clear();
      for(int i = 0; i < days.length; i++) {
        for(int j = 0; j < model.workingHours.length; j++) {
          if(days[i] == model.workingHours[j].day) {
            availableDays.add(days[i]);
          }
        }
      }

      List<String> result = days.where((item) => !availableDays.contains(item)).toList();
      debugPrint("$TAG remaining week days =======> $result");

      for(int i = 0; i < result.length; i++) {
        model.workingHours.add(WorkingHoursModel(day: result[i], timeslot: []));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileModel>(builder: (BuildContext context, EditProfileModel model, _) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colororangeLight,
          title: appbarbackbtnnotification(
            context,
            'Availability',
          ),
        ),
        body: SizedBox(
          width: deviceWidth(context, 1.0),
          height: deviceheight(context, 1.0),
          child: Stack(
            children: [
              Container(
                height: deviceheight(context, 0.3),
                width: deviceWidth(context, 1.0),
                color: colororangeLight,
              ),
              Container(
                margin: const EdgeInsets.only(top: 38),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: decorationtoprounded(),
                child: ListView.builder(
                  itemCount: model.workingHours.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2.0,
                      ),
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.workingHours[index].day.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if(model.workingHours[index].timeslot!.isEmpty)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          model.workingHours[index].timeslot!.add(
                                            Timeslot(
                                              start: '',
                                              end: '',
                                            ),
                                          );
                                        });
                                      },
                                      child: Icon(
                                        Icons.add_circle_sharp,
                                        color: Color(COLOR_PRIMARY),
                                        size: 36,
                                      ),
                                    )
                                ],
                              ),
                              ListView.builder(
                                itemCount: model.workingHours[index].timeslot!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index1) {
                                  return Form(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () async {
                                                    TimeOfDay? startTime = await _selectTime();
                                                    setState(() {
                                                      model.workingHours[index].timeslot![index1].start = DateFormat('hh:mm a').format(
                                                        DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day,
                                                          startTime!.hour,
                                                          startTime.minute,
                                                        ),
                                                      );
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(4),
                                                      ),
                                                      border: Border.all(
                                                        color: const Color(0XFFB1BCCA),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(
                                                          model.workingHours[index].timeslot![index1].start!.isEmpty ? 'Start Time' : model.workingHours[index].timeslot![index1].start.toString(),
                                                          style: TextStyle(color: model.workingHours[index].timeslot![index1].start!.isEmpty ? Colors.grey : Colors.black, fontSize: 16,),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      TimeOfDay? startTime = await _selectTime();
                                                      if (startTime!.format(context).toString() == "12:00 AM") {
                                                        model.workingHours[index].timeslot![index1].end = DateFormat('hh:mm a').format(
                                                          DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now().month,
                                                            DateTime.now().day,
                                                            23,
                                                            59,
                                                          ),
                                                        );
                                                      } else {
                                                        setState(() {
                                                          model.workingHours[index].timeslot![index1].end = DateFormat('hh:mm a').format(
                                                            DateTime(
                                                              DateTime.now().year,
                                                              DateTime.now().month,
                                                              DateTime.now().day,
                                                              startTime.hour,
                                                              startTime.minute,
                                                            ),
                                                          );
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(
                                                          Radius.circular(4),
                                                        ),
                                                        border: Border.all(
                                                          color: const Color(0XFFB1BCCA),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            model.workingHours[index].timeslot![index1].end!.isEmpty ? 'End Time' : model.workingHours[index].timeslot![index1].end.toString(),
                                                            style: TextStyle(color: model.workingHours[index].timeslot![index1].end!.isEmpty ? Colors.grey : Colors.black, fontSize: 16,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    model.workingHours[index].timeslot!.removeAt(index1);
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              backgroundColor: Color(COLOR_PRIMARY),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Color(COLOR_PRIMARY),
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                model.weekDay.clear();
                model.weekStartTime.clear();
                model.weekEndTime.clear();
                for(int i = 0; i < model.workingHours.length; i++) {
                  if(model.workingHours[i].timeslot != null && model.workingHours[i].timeslot!.isNotEmpty) {
                    if(model.workingHours[i].day != null) {
                      model.weekDay.add(model.workingHours[i].day.toString());
                    }
                    for (int j = 0; j < model.workingHours[i].timeslot!.length; j++) {
                      model.weekStartTime.add(model.workingHours[i].timeslot![j].start.toString());
                      model.weekEndTime.add(model.workingHours[i].timeslot![j].end.toString());
                    }
                  }
                }
                model.workingHours.clear();
                Navigator.of(context).pop();
                debugPrint("$TAG weekDay ======> ${model.weekDay}");
                debugPrint("$TAG weekStartTime ======> ${model.weekStartTime}");
                debugPrint("$TAG weekEndTime ======> ${model.weekEndTime}");
              });
            },
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<TimeOfDay?> _selectTime() async {
    FocusScope.of(context).requestFocus(FocusNode()); //remove focus
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: colororangeLight, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colororangeLight, //
              ),
            ),
          ),
          child: child!,
        );
      }
    );
    if (newTime != null) {

      debugPrint("$TAG newTime =====> $newTime");

      return newTime;
    }
    return null;
  }
}