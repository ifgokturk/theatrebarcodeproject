import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter

import 'package:theatrebarcodeproject/model/Seanslar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theatrebarcodeproject/constants/Sabitler.dart';
import 'package:theatrebarcodeproject/model/biletbilgileri.dart';

import '../model/biletbilgileri.dart';
import 'apilistener.dart';

class WebServices {
  late ApiListener mApiListener;
  late GlobalKey keyCurrent;
  WebServices(this.mApiListener);

  void getSeansList(BuildContext context, GlobalKey<State> keyLoader,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    http.post(Uri.https(sabitler.url, sabitler.urlGetSeans), headers: {
      'Authorization': sabitler.authorization,
      'Content-Type': 'app.mobil'
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        // final parsed = json.decode(res).cast<Map<String, dynamic>>();

        Map<String, dynamic> result = json.decode(res);
        Seanslar data = Seanslar.fromJson(result);

        debugPrint(data.seansList.length.toString());
        _onSuccessResponse(data.seansList);
      }
    });
  }

  void getBiletBilgileri(BuildContext context, GlobalKey<State> keyLoader,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    http.get(
      Uri.https(sabitler.url, sabitler.urlBiletNo),
      headers: {'Authorization': sabitler.authorization, 'state': "app.mobil"},
    ).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        // final parsed = json.decode(res).cast<Map<String, dynamic>>();

        Map<String, dynamic> result = json.decode(res);
        BiletBilgileri data = BiletBilgileri.fromJson(result);

        debugPrint(data.biletId.toString());
        _onSuccessResponse(data.biletNo.toString());
      }
    });
  }

  //This Function executed after any Success call of API
  void _onSuccessResponse(Object mObject) {
    mApiListener.onApiSuccess(mObject);
  }
}
