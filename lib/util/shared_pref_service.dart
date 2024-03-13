import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/university_info.dart';

class Promo extends StatelessWidget {
  final String promox;

  const Promo({Key? key, required this.promox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(promox)),
        ),
      ),
    );
  }
}
class UniversityPreferences {
  static const _keyUniversity = 'university';
  static const _keyUniversities = 'universities';

  Future<void> saveUniversity(UniversityInfo universityInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String universityJson = jsonEncode(universityInfo.toJson());
    await prefs.setString(_keyUniversity, universityJson);
  }

  Future<UniversityInfo?> loadUniversity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? universityJson = prefs.getString(_keyUniversity);
    if (universityJson == null) return null;
    return UniversityInfo.fromJson(jsonDecode(universityJson));
  }

  Future<void> saveUniversityList(List<UniversityInfo> universities) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> universityJsonList =
        universities.map((uni) => jsonEncode(uni.toJson())).toList();
    await prefs.setStringList(_keyUniversities, universityJsonList);
  }

  Future<List<UniversityInfo>> loadUniversityList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? universityJsonList = prefs.getStringList(_keyUniversities);
    if (universityJsonList == null) return [];
    return universityJsonList
        .map((uniJson) => UniversityInfo.fromJson(jsonDecode(uniJson)))
        .toList();
  }
}
