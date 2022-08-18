import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/apilistener.dart';
import '../model/Seanslar.dart';

import '../services/webservices.dart';
import '../model/biletbilgileri.dart';
import '../constants/Sabitler.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan2/barcode_scan2.dart';

class TiyatroSeanslar extends StatefulWidget {
  const TiyatroSeanslar({Key? key}) : super(key: key);

  @override
  _DropdownExampleState createState() {
    return _DropdownExampleState();
  }
}

class _DropdownExampleState extends State<TiyatroSeanslar>
    implements ApiListener {
  String barcode = "";
  List<SeansList> seansList = [];
  List<BiletBilgileri> biletlist = [];
  //String barkodcuk;
  //String giren = "";
  //String biletim;
  //String biletimiz;
  String ificinBilet = "";
  //var _oyunadi = TextEditingController();
  //String listRoute3;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  final _oyunTarihi = TextEditingController();
  final _oyunSaati = TextEditingController();
  final _toplamSatis = TextEditingController();

  final _biletSayisi = TextEditingController();
  final _kalanBilet = TextEditingController();

  final _giren = TextEditingController();

  //String get selectedSeans => null;
  final _formKey = GlobalKey<FormState>();
  late SeansList _seansList;
  @override
  void initState() {
    super.initState();
    _seansList = SeansList();
    _seansList.adi = "Seçiniz*";
    //_biletBilgileri = new BiletBilgileri();

    WebServices(this).getSeansList(context, _keyLoader, _scaffoldKey);
    WebServices(this).getBiletBilgileri(context, _keyLoader, _scaffoldKey);
  }

  @override
  void onApiFailure(Exception exception) {
    // TODO: implement onApiFailure
  }

  @override
  void onApiSuccess(Object mObject) {
    // TODO: implement onApiSuccess
    if (mObject is List<SeansList>) {
      debugPrint('Seanslar başarılı ikinci access');
      seansList = mObject;
    }
  }

  @override
  void onNoInternetConnection() {
    // TODO: implement onNoInternetConnection
  }

  @override
  void dispose() {
    _biletSayisi.clear();
    _kalanBilet.clear();
    super.dispose();
  }

  void textSil() {
    _biletSayisi.clear();
    _kalanBilet.clear();
    _giren.clear();
  }

  String gelenId = "";
  String gelenSeans = "";

  @override
  Widget build(BuildContext context) {
    var children2 = [
      DropdownButton(
        items: seansList.map((item) {
          return DropdownMenuItem(
            value: item.seansNo,
            child: Text(
              "${item.id}  ${item.oyunAdi}",
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            gelenSeans = value.toString();
            textSil();
            barcode = "";

            var selectedSeans = seansList.firstWhere(
              (seans) => seans.seansNo == value,
              //       orElse: () {

              //  return selectedSeans;
              // }
            );

            _toplamSatis.text = selectedSeans.toplamBiletSayisi.toString();
            _oyunTarihi.text = selectedSeans.seansTarihi.toString();
            _oyunSaati.text = selectedSeans.seansSaati.toString();
            gelenId = selectedSeans.id.toString();
          });
        },
        onTap: () async {},
        hint: const Text('Oyun Seçiniz'),
        value: gelenSeans,
      ),
      // Text("id" + gelenId.toString()),

      // _toplamSatis.tex,
      TextField(
          enabled: false,
          controller: _toplamSatis,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          decoration: const InputDecoration(
              icon: Icon(Icons.group),
              labelText: "Toplam Satılan Bilet ",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.lightBlueAccent))),
      TextField(
          enabled: false,
          controller: _oyunTarihi,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          decoration: const InputDecoration(
              icon: Icon(Icons.extension),
              labelText: "Oyun Tarihi",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.lightBlueAccent))),
      TextField(
          enabled: false,
          controller: _oyunSaati,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          decoration: const InputDecoration(
              icon: Icon(Icons.av_timer),
              labelText: "Oyun Saati ",
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.lightBlueAccent))),
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: children2,
              ),
            ),
          ),

          Container(
            // width: 380,
            // height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RaisedButton.icon(
                    onPressed: barcodeScanning,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: const Text(
                      'Barkod Oku',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      // Icons.account_balance,
                      Icons.camera_enhance,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.yellow,
                    color: Colors.lightBlueAccent[700],
                  ),
                  Container(
                    width: 380,
                    height: 130,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 5,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                              enabled: false,
                              controller: _biletSayisi,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.group_add),
                                  labelText: "Bilet Sayısı ",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.lightBlueAccent))),
                        ),
                        Expanded(
                          child: TextField(
                              enabled: false,
                              controller: _kalanBilet,
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.group_add),
                                  labelText: "Kalan Bilet",
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //-------------------------------Giriş yapan sayısı ve buton ------------------------------------

          SingleChildScrollView(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 3,
                    // initialValue: "1",
                    controller: _giren,
                    // autofocus: true,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w600),
                    onChanged: (abidik) {
                      _giren.value = TextEditingValue(
                          text: abidik,
                          selection: TextSelection(
                              baseOffset: abidik.length,
                              extentOffset: abidik.length));
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.group),
                        // hintText: 'What do people call you?',
                        labelText: 'Giriş  Yapan Sayısı',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.lightBlueAccent)),
                  ),
                ),
                Expanded(
                  child: RaisedButton.icon(
                    onPressed: () async {
                      if (_giren.text == "") {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title:
                                    Text("Giriş Yapan Kişi Sayısını Giriniz."),
                              );
                            });
                      } else {
                        if (barcode == "") {
                          //burayı doldur
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Bilet Bulunamadı!"),
                                );
                              });
                        } else {
                          await pushData();

                          Future<BiletBilgileri> biletdetay;
                          setState(() => {
                                barcode = barcode,
                                biletdetay = getBiletDetay(),
                                biletdetay.then((value) {
                                  ificinBilet = value.biletSayisi.toString();
                                  _biletSayisi.text =
                                      value.biletSayisi.toString();
                                  _kalanBilet.text = (value.biletSayisi! -
                                          value.girisYapanSayisi!)
                                      .toString();
                                  debugPrint(_giren.toString());
                                  if (ificinBilet == "1") {
                                    if (_giren.text == "1") {
                                      barcodeScanning();
                                    }
                                  }
                                })
                              });
                          debugPrint(ificinBilet);
                        }
                      }
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: const Text(
                      'Kaydet',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.playlist_add_check,
                      color: Colors.white,
                    ),
                    textColor: Colors.white,
                    splashColor: Colors.yellow,
                    color: Colors.lightBlueAccent[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future barcodeScanning() async {
    try {
      String barcode = BarcodeScanner.scan().toString();
      Future<BiletBilgileri> biletdetay;
      setState(() => {
            textSil(),
            // _giren.text = "1",
            this.barcode = barcode,
            biletdetay = getBiletDetay(),
            biletdetay.then((value) {
              debugPrint("gelen id $gelenId");
              debugPrint("value daki id ${value.seansId}");
              if (gelenId != value.seansId.toString()) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: const Text("Seçilen Oyun ile Bilet Uyumsuz"),
                          actions: [
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Tamam"),
                            ),
                          ],
                        ));

                this.barcode = "";
              } else {
                _biletSayisi.text = value.biletSayisi.toString();
                _kalanBilet.text =
                    (value.biletSayisi! - value.girisYapanSayisi!).toString();
                if (value.biletSayisi == 1) {
                  _giren.text = '1';
                }
              }
            }),
          });
      debugPrint(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcode = 'Kameraya İzin Yok!';
        });
      } else {
        setState(() => barcode = 'Bilinmeyen Hata: $e');
      }
    } on FormatException {
      setState(() => barcode = 'Görüntülenecek veri bulunamadı');
    } catch (e) {
      setState(() => barcode = 'Bilinmeyen Hata : $e');
    }
  }

  Future<BiletBilgileri> getBiletDetay() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull("${sabitler.urlBiletNo}$barcode")),
        headers: {
          'Authorization': sabitler.authorization,
          "Accept": "application/json"
        });
    Map<String, dynamic> jsonBilet = jsonDecode(response.body);
    return BiletBilgileri.fromJson(jsonBilet);
  }

  String urlSalonGiris =
      "http://api.kocaeli.bel.tr/TiyatroApi/api/BiletSalonGiris";
  var listRoute2 = [];
  // ignore: missing_return
  Future<BiletBilgileri?> pushData() async {
    http.Response parse = await http.post(
        Uri.parse(Uri.encodeFull(urlSalonGiris)),
        // Uri.encodeFull(sabitler.urlSalonGiris),
        body:
            json.encode({"BiletNo": barcode, "GirisYapanSayisi": _giren.text}),
        headers: {
          'Authorization': sabitler.authorization,
          //  "Accept": "application/json"
          "Content-Type": "application/json"
        });

    Map mapRes = json.decode(parse.body);
    debugPrint('Response from server: $mapRes');
    setState(() {
      String listRoute2 = mapRes['Message'];
      debugPrint(listRoute2);
      debugPrint("giren ${_giren.text}");
      debugPrint(_giren.text);
      debugPrint(_giren.value.toString());

      if (listRoute2 != "") {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(listRoute2),
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Tamam"),
                    ),
                  ],
                ));
      }
    });

    debugPrint(parse.body);
    return null;
  }
}
