// To parse this JSON data, do
//
//     final seanslar = seanslarFromJson(jsonString);

import 'dart:convert';

Seanslar seanslarFromJson(String str) => Seanslar.fromJson(json.decode(str));

String seanslarToJson(Seanslar data) => json.encode(data.toJson());

class Seanslar {
  Seanslar({
    required this.seansList,
    this.status,
    this.message,
  });

  List<SeansList> seansList = [];
  bool? status;
  String? message;

  Seanslar copyWith({
    required List<SeansList> seansList,
    bool? status,
    String? message,
  }) =>
      Seanslar(
        seansList: this.seansList,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory Seanslar.fromJson(Map<String, dynamic> json) => Seanslar(
        seansList: List<SeansList>.from(
            json["SeansList"].map((x) => SeansList.fromJson(x))),
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "SeansList": seansList == null
            ? null
            : List<dynamic>.from(seansList.map((x) => x.toJson())),
        "Status": status,
        "Message": message,
      };
}

class SeansList {
  SeansList({
    this.id,
    this.seansNo,
    this.adi,
    this.salon,
    this.oyunAdi,
    this.seansTarihi,
    this.seansSaati,
    this.toplamBiletSayisi,
  });

  int? id;
  String? seansNo;
  String? adi;
  String? salon;
  String? oyunAdi;
  String? seansTarihi;
  String? seansSaati;
  int? toplamBiletSayisi;

  SeansList copyWith({
    int? id,
    String? seansNo,
    String? adi,
    String? salon,
    String? oyunAdi,
    String? seansTarihi,
    String? seansSaati,
    int? toplamBiletSayisi,
  }) =>
      SeansList(
        id: id ?? this.id,
        seansNo: seansNo ?? this.seansNo,
        adi: adi ?? this.adi,
        salon: salon ?? this.salon,
        oyunAdi: oyunAdi ?? this.oyunAdi,
        seansTarihi: seansTarihi ?? this.seansTarihi,
        seansSaati: seansSaati ?? this.seansSaati,
        toplamBiletSayisi: toplamBiletSayisi ?? this.toplamBiletSayisi,
      );

  factory SeansList.fromJson(Map<String, dynamic> json) => SeansList(
        id: json["Id"],
        seansNo: json["SeansNo"],
        adi: json["Adi"],
        salon: json["Salon"],
        oyunAdi: json["OyunAdi"],
        seansTarihi: json["SeansTarihi"],
        seansSaati: json["SeansSaati"],
        toplamBiletSayisi: json["ToplamBiletSayisi"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "SeansNo": seansNo,
        "Adi": adi,
        "Salon": salon,
        "OyunAdi": oyunAdi,
        "SeansTarihi": seansTarihi,
        "SeansSaati": seansSaati,
        "ToplamBiletSayisi": toplamBiletSayisi,
      };

  startsWith(String value) {}
}
