import 'package:astrologyapp/common/commonwidgets/commonWidget.dart';
import 'package:astrologyapp/common/styles/const.dart';
import 'package:astrologyapp/edit%20profile/editprofilemodel.dart';
import 'package:astrologyapp/generate%20kundli/generatekundaliModelPage.dart';
import 'package:astrologyapp/signup/SignUpPageModel.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';

class GoogleSearchScreen extends StatefulWidget {
  const GoogleSearchScreen({super.key});

  @override
  _GoogleSearchScreenState createState() => _GoogleSearchScreenState();
}

class _GoogleSearchScreenState extends State<GoogleSearchScreen> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    // googlePlace = GooglePlace('AIzaSyDUJQc9RLnJreksMp5OOXTOtsIX7G4bZw8');
    // googlePlace = GooglePlace('AIzaSyAjl5eerbUVzq98s8Jxh3ENx4omeIpxOwI');
    googlePlace = GooglePlace('AIzaSyAXdZsci8RH_GLRp3UVPDuhHRLDUzopgH0');
    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(borderRadius: borderRadiuscircular(25.0)),
                    width: MediaQuery.of(context).size.width * 0.77,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Search here",
                        prefixIcon: const IconButton(
                          icon: Icon(
                            Icons.location_on_outlined,
                            size: 20,
                          ),
                          onPressed: null,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: borderRadiuscircular(15.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: borderRadiuscircular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.black54,
                            width: 1.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {
                          if (predictions.isNotEmpty && mounted) {
                            setState(() {
                              predictions = [];
                            });
                          }
                        }
                      },
                    ),
                  ),
                  sizedboxwidth(5.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colororangeLight,
                        child: const Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Text(predictions[index].description!),
                      onTap: () {
                        getDetails(predictions[index].placeId!);
                        Provider.of<SignUpPageModel>(context, listen: false).updateAddress(predictions[index].description!);
                        Provider.of<GenratekundliModelPage>(context, listen: false).togglselectaddres(predictions[index].description!);
                        Provider.of<EditProfileModel>(context, listen: false).updateAddress(predictions[index].description!);
                        Navigator.pop(context, predictions[index].description!);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getDetails(String placeId) async {
    DetailsResponse? result = await googlePlace.details.get(placeId);
    if (result != null && result.result != null && mounted) {
      setState(() {
        Navigator.of(context).pop(result.result);
      });
    }
  }

  void autoCompleteSearch(String value) async {
    AutocompleteResponse? result = await googlePlace.autocomplete.get(value);
    debugPrint("autoCompleteSearch result ========> $result");
    if (result != null && result.predictions != null && mounted) {
      debugPrint("autoCompleteSearch result ========> $result");
      debugPrint("autoCompleteSearch result status ========> ${result.status}");
      debugPrint("autoCompleteSearch result error ========> ${result}");
      debugPrint("autoCompleteSearch result prediction ========> ${result.predictions}");

      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}
