// To parse this JSON data, do
//
//     final biletBilgileri = biletBilgileriFromJson(jsonString);

import 'dart:convert';

BiletBilgileri biletBilgileriFromJson(String str) =>
    BiletBilgileri.fromJson(json.decode(str));

String biletBilgileriToJson(BiletBilgileri data) => json.encode(data.toJson());

class BiletBilgileri {
  BiletBilgileri({
    this.biletId,
    this.biletNo,
    this.seansId,
    this.biletSayisi,
    this.girisYapanSayisi,
    this.status,
    required this.message,
  });

  int? biletId;
  String? biletNo;
  int? seansId;
  int? biletSayisi;
  int? girisYapanSayisi;
  bool? status;
  String message;

  factory BiletBilgileri.fromJson(Map<String, dynamic> json) => BiletBilgileri(
        biletId: json["BiletID"],
        biletNo: json["BiletNo"],
        seansId: json["SeansId"],
        biletSayisi: json["BiletSayisi"],
        girisYapanSayisi: json["GirisYapanSayisi"],
        status: json["Status"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "BiletID": biletId,
        "BiletNo": biletNo,
        "SeansId": seansId,
        "BiletSayisi": biletSayisi,
        "GirisYapanSayisi": girisYapanSayisi,
        "Status": status,
        "Message": message,
      };
}
