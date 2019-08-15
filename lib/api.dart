import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/video.dart';

const API_KEY = "AIzaSyDeW15xoaWwTohOZDoko6Sle1kOh-dOW5I";

class Api {
  search(String search) async {
    http.Response response = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decode = json.decode(response.body);

      List<Video> videos = decode["items"]
      .map<Video>((map) {
        return Video.fromJson(map);
      }).toList();
      return videos;
    } else {
      throw Exception("Falied to load video!");
    }
  }
}
