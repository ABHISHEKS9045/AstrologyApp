import 'package:astrologyapp/dashboard/dashboardModelPage.dart';
import 'package:astrologyapp/edit%20profile/editprofilepagewidget.dart';
import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

import '../common/appbar/chatpageAppbar.dart';
import '../common/commonwidgets/commonWidget.dart';
import '../common/shimmereffect.dart';
import '../common/styles/const.dart';
import 'editprofilemodel.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {

  static const String TAG = "_DocumentPageState";
  final formKey = GlobalKey<FormState>();
  var dashBoardModel;

  @override
  void initState() {
    dashBoardModel = Provider.of<DashboardModelPage>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var model = Provider.of<EditProfileModel>(context, listen: false);
      debugPrint("$TAG show data for bank details ======> ${dashBoardModel.astrologerBankData.toString()}");
      model.setAstrologerBankData(dashBoardModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colororangeLight,
          title: appbarbackbtnnotification(
            context,
            'Update Document',
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
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
                  child: SingleChildScrollView(
                    child: model.isShimmer
                        ? shimmer()
                        : Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedboxheight(20.0),
                          panCardWidget(context, model, dashBoardModel),
                          sizedboxheight(15.0),
                          aadharCardWidget(context, model, dashBoardModel),
                          sizedboxheight(15.0),
                          accountHolderNameWidget(context, model, dashBoardModel),
                          sizedboxheight(15.0),
                          accountNumberWidget(context, model, dashBoardModel),
                          sizedboxheight(15.0),
                          ifscCodeWidget(context, model, dashBoardModel),
                          sizedboxheight(15.0),
                          bankNameWidget(context, model, dashBoardModel),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              panCard(context,model, dashBoardModel,),
                              aadharCard(context,model, dashBoardModel,),
                              bankImage(context,model, dashBoardModel,),
                            ],
                          ),
                          sizedboxheight(20.0),
                          updateDocument(context, model, dashBoardModel),
                          sizedboxheight(20.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
