// To parse this JSON data, do
//
//     final absensiResponseModel = absensiResponseModelFromJson(jsonString);

import 'dart:convert';

AbsensiResponseModel absensiResponseModelFromJson(String str) => AbsensiResponseModel.fromJson(json.decode(str));

String absensiResponseModelToJson(AbsensiResponseModel data) => json.encode(data.toJson());

class AbsensiResponseModel {
    List<Absen> absen;
    int totalAbsen;

    AbsensiResponseModel({
        required this.absen,
        required this.totalAbsen,
    });

    factory AbsensiResponseModel.fromJson(Map<String, dynamic> json) => AbsensiResponseModel(
        absen: List<Absen>.from(json["absen"].map((x) => Absen.fromJson(x))),
        totalAbsen: json["totalAbsen"],
    );

    Map<String, dynamic> toJson() => {
        "absen": List<dynamic>.from(absen.map((x) => x.toJson())),
        "totalAbsen": totalAbsen,
    };
}

class Absen {
    int id;
    int userId;
    DateTime date;
    String imageMasuk;
    dynamic imageKeluar;
    String lokasiMasuk;
    dynamic lokasiKeluar;
    String absenMasuk;
    String keterangan;
    dynamic absenKeluar;
    DateTime createdAt;
    DateTime updatedAt;

    Absen({
        required this.id,
        required this.userId,
        required this.date,
        required this.imageMasuk,
        required this.imageKeluar,
        required this.lokasiMasuk,
        required this.lokasiKeluar,
        required this.absenMasuk,
        required this.keterangan,
        required this.absenKeluar,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Absen.fromJson(Map<String, dynamic> json) => Absen(
        id: json["id"],
        userId: json["user_id"],
        date: DateTime.parse(json["date"]),
        imageMasuk: json["image_masuk"],
        imageKeluar: json["image_keluar"],
        lokasiMasuk: json["lokasi_masuk"],
        lokasiKeluar: json["lokasi_keluar"],
        absenMasuk: json["absen_masuk"],
        keterangan: json["keterangan"],
        absenKeluar: json["absen_keluar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "date": date.toIso8601String(),
        "image_masuk": imageMasuk,
        "image_keluar": imageKeluar,
        "lokasi_masuk": lokasiMasuk,
        "lokasi_keluar": lokasiKeluar,
        "absen_masuk": absenMasuk,
        "keterangan": keterangan,
        "absen_keluar": absenKeluar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
