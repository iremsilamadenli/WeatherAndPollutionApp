import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/air_quality.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/my_data.dart';

Future <AirQuality?> fetchData() async {
  try {
    Position position = await Geolocator.getCurrentPosition();
  var url = Uri.parse('https://api.waqi.info/feed/geo:${position.latitude};${position.longitude}/?token=$API_KEY_AIR');
	var response = await http.get(url);
if(response.statusCode == 200) {
			AirQuality airQuality = AirQuality.fromJson(jsonDecode(response.body));
			if(airQuality.aqi >= 0 && airQuality.aqi <= 50) {
				airQuality.message = "Air quality is considered satisfactory, and air pollution poses little or no risk	";
				airQuality.emojiRef = "air1.png";
			} else if(airQuality.aqi >= 51 && airQuality.aqi <= 100) {
				airQuality.message = "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution.";
				airQuality.emojiRef = "air2.png";
			} else if(airQuality.aqi >= 101 && airQuality.aqi <= 150) {
				airQuality.message = "Members of sensitive groups may experience health effects. The general public is not likely to be affected.";
				airQuality.emojiRef = "air3.png";
			} else if(airQuality.aqi >= 151 && airQuality.aqi <= 200) {
				airQuality.message = "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects";
				airQuality.emojiRef = "air4.png";
			} else if(airQuality.aqi >= 201 && airQuality.aqi < 300) {
				airQuality.message = "Health warnings of emergency conditions. The entire population is more likely to be affected.";
				airQuality.emojiRef = "air5.png";
			} else if(airQuality.aqi >= 300) {
				airQuality.message = "Health alert: everyone may experience more serious health effects";
				airQuality.emojiRef = "air6.png";
			}

			print(airQuality);
			return airQuality;
		}
		return null;
  	  } catch (e) {
    log(e.toString());
    rethrow;
    
  }
}