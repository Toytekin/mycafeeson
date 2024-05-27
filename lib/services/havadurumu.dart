import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycofeekahve/models/havamodel.dart';

class LocationHelper {
  double latitude = 41.008240;
  double longitude = 28.978359;

  Future<HavaModel> getLocation() async {
    var link =
        'https://api.openweathermap.org/data/2.5/weather?lat=41.008240&lon=28.978359&appid=3871b09cc82a788b7bd9871aba398a71&units=metric';

    var response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return HavaModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
