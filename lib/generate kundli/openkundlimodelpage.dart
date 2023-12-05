import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/styles/const.dart';

class Openkundlimodelpage extends ChangeNotifier {
  String TAG = "Openkundlimodelpage";

  String _appbartitle = 'KUNDLI';

  String get appbartitle => _appbartitle;
  var chartImage;
  var charDashDetails;

  toggelappbartitle(value) {
    value == 0 ? _appbartitle = 'KUNDLI' : _appbartitle = 'GENERATE KUNDLI';
    notifyListeners();
  }

  bool _isShimmer = false;

  bool get isShimmer => _isShimmer;

  toggleshemmerShow() {
    _isShimmer = true;
    notifyListeners();
  }

  toggleshemmerdismis() {
    _isShimmer = false;
    notifyListeners();
  }

  List? _kundlilist = [];

  List? get kundlilist => _kundlilist;
  var panchangDetails;
  var planetSignDetails;
  var astroDetails;
  var kpPlanetDetails;
  var rudrashRecc;
  var gemRecc;
  var kalpasaraDetails;
  var manglikDetails;
  var sadesatiDetails;
  var currentSadesatiDetails;
  var kpCuspDetails;
  var planetNakhatra1Details;
  var yoginiDashaDetails;

  kundlilistview(context) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('login_user_id');

    Dio dio = Dio();
    FormData formData = FormData.fromMap({
      "user_id": userid,
    });

    var response = await dio.post("${baseURL}view_kundli", data: formData);

    final responseData = json.decode(response.toString());
    try {
      if (responseData['status'] == true) {
        _kundlilist = responseData["data"];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  Future kudaliPanchangDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG kudali Panchang Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/basic_panchang", data: map);
    debugPrint("$TAG kudali Panchang Details response ========> ${response.statusCode}");
    debugPrint("$TAG kudali Panchang Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        panchangDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
        return panchangDetails;
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadAstroDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Astro Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/astro_details", data: map);
    debugPrint("$TAG load Astro Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Astro Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        astroDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadPlanetSignDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Planet Sign Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/planets", data: map);
    debugPrint("$TAG load Planet Sign Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Planet Sign Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        planetSignDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadPlanetNakshatraDetails1(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Planet Nakshatra Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/planets/extended", data: map);
    debugPrint("$TAG load Planet Nakshatra Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Planet Nakshatra Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        planetNakhatra1Details = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadKPPlanetDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load KP Planet Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/kp_planets", data: map);
    debugPrint("$TAG load KP Planet Details response ========> ${response.statusCode}");
    debugPrint("$TAG load KP Planet Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        kpPlanetDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadRudrakshaRecc(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Rudraksha Recc Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/rudraksha_suggestion", data: map);
    debugPrint("$TAG load Rudraksha Recc Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Rudraksha Recc Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        rudrashRecc = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadGemstoneRecc(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Gemstone Recc Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/basic_gem_suggestion", data: map);
    debugPrint("$TAG load Gemstone Recc Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Gemstone Recc Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        gemRecc = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadKalpasaraDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Kalpasara Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/kalsarpa_details", data: map);
    debugPrint("$TAG load Kalpasara Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Kalpasara Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        kalpasaraDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadManglikDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Manglik Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/manglik", data: map);
    debugPrint("$TAG load Manglik Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Manglik Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        manglikDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadSadesatiDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Sadesati Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/sadhesati_life_details", data: map);
    debugPrint("$TAG load Sadesati Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Sadesati Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        sadesatiDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadCurrentSadesatiDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load Current Sadesati Details response ========> ");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/sadhesati_current_status", data: map);
    debugPrint("$TAG load Current Sadesati Details response ========> ${response.statusCode}");
    debugPrint("$TAG load Current Sadesati Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        currentSadesatiDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future loadKPCuspDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();
    debugPrint("$TAG load KP Cusp Details response ========>");
    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    var response = await dio.post("https://json.astrologyapi.com/v1/kp_house_cusps", data: map);
    debugPrint("$TAG load KP Cusp Details response ========> ${response.statusCode}");
    debugPrint("$TAG load KP Cusp Details response ========> ${response.statusMessage}");
    try {
      if (response.statusCode == 200) {
        kpCuspDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }

  Future kudaliChardashaDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();

    debugPrint("$TAG kudali Chardasha Details list ========> $list");

    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/major_vdasha", data: map);
      debugPrint("$TAG kudali Yogindasha Details response ========> ${response.statusCode}");
      debugPrint("$TAG kudali Yogindasha Details response ========> ${response.statusMessage}");
      if (response.statusCode == 200) {
        charDashDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  Future kudaliYogindashaDetails(list) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();

    debugPrint("$TAG kudali Yogindasha Details list ========> $list");

    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    dio.options.headers["authorization"] = "Basic $encodedKey";

    try {
      var response = await dio.post("https://json.astrologyapi.com/v1/major_yogini_dasha", data: map);
      debugPrint("$TAG kudali Yogindasha Details response ========> ${response.statusCode}");
      debugPrint("$TAG kudali Yogindasha Details response ========> ${response.statusMessage}");

      if (response.statusCode == 200) {
        yoginiDashaDetails = response.data;
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
    }
  }

  Future kudaliChart(list, chartId) async {
    toggleshemmerShow();
    await Future.delayed(const Duration(seconds: 1));
    toggleshemmerShow();

    debugPrint("$TAG kudali Chart Details list ========> $list");

    Dio dio = Dio();
    double timeZone;
    if (list['time_zone'].toString().contains(":")) {
      timeZone = double.parse(list['time_zone'].split(':')[0] + '.' + list['time_zone'].split(':')[1]);
    } else {
      timeZone = double.parse(list['time_zone']);
    }
    dio.options.headers["authorization"] = "Basic $encodedKey";
    Map map = {
      'day': list['birth_day'],
      'month': list['birth_month'],
      'year': list['birthday_year'],
      'lat': double.parse(list['lat']),
      'lon': double.parse(list['long']),
      'tzone': timeZone,
      'hour': list['birth_time_hrs'],
      'min': list['birth_time_mintus'],
    };

    try {
      var response = await dio.post('https://json.astrologyapi.com/v1/horo_chart_image/' + chartId, data: map);
      debugPrint("$TAG kudali Yogindasha Details response ========> ${response.statusCode}");
      debugPrint("$TAG kudali Yogindasha Details response ========> ${response.statusMessage}");
      if (response.statusCode == 200) {
        chartImage = response.data['svg'];
        toggleshemmerdismis();
        notifyListeners();
      } else {
        toggleshemmerdismis();
      }
    } catch (e) {
      toggleshemmerdismis();
      return "";
    }
  }
}
