import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/jeolocatormodel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<JeolocatorModel?> autoComplitePlace(String placeName) async {
    try {
      var response = await http.get(Uri.parse(
          "https://geocoding-api.open-meteo.com/v1/search?name=$placeName&count=5"));
      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        JeolocatorModel jeolocatorModel =
            JeolocatorModel.fromJson(json.decode(response.body));
        return jeolocatorModel;
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return null;
  }
}
