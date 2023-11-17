import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nomad_flutter_webtoon/models/webtoon_detail_model.dart';
import 'package:nomad_flutter_webtoon/models/webtoon_episode_model.dart';
import 'package:nomad_flutter_webtoon/models/webtoon_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  //checkConnection
  static Future<bool> checkConnection() async {
    bool result = false;

    while (result == false) {
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.vpn) {
        result = true;
      }
    }

    return result;
  }

  // final connectivityResult = await Connectivity().checkConnectivity();
  static Future<bool> checkConnectivity() async {
    final Future<bool> result = checkConnection()
        .timeout(const Duration(seconds: 2), onTimeout: () => false);

    return result;
  }

  // getTodaysToons
  static Future<dynamic> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse("$baseUrl/$today");

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final webtoons = jsonDecode(response.body);

        for (var webtoon in webtoons) {
          webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        }
        return webtoonInstances;
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final webtoon = jsonDecode(response.body);
        return WebtoonDetailModel.fromJson(webtoon);
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final episodes = jsonDecode(response.body);
        for (var episode in episodes) {
          episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
        }
        return episodesInstances;
      } else {
        throw Exception();
      }
    } catch (e) {
      return e;
    }
  }
}
