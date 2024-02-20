// To parse this JSON data, do
//
//     final homeResponseModel = homeResponseModelFromJson(jsonString);

import 'dart:convert';

HomeResponseModel homeResponseModelFromJson(String str) => HomeResponseModel.fromJson(json.decode(str));

String homeResponseModelToJson(HomeResponseModel data) => json.encode(data.toJson());

class HomeResponseModel {
    Absen absen;
    int totalAbsen;

    HomeResponseModel({
        required this.absen,
        required this.totalAbsen,
    });

    factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
        absen: Absen.fromJson(json["absen"]),
        totalAbsen: json["totalAbsen"],
    );

    Map<String, dynamic> toJson() => {
        "absen": absen.toJson(),
        "totalAbsen": totalAbsen,
    };
}

class Absen {
    int currentPage;
    List<Datum> data;
    String firstPageUrl;
    int from;
    int lastPage;
    String lastPageUrl;
    List<Link> links;
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    Absen({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    factory Absen.fromJson(Map<String, dynamic> json) => Absen(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int id;
    int userId;
    DateTime date;
    String imageMasuk;
    String imageKeluar;
    String lokasiMasuk;
    String lokasiKeluar;
    String absenMasuk;
    String keterangan;
    String absenKeluar;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    Datum({
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
        required this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        user: User.fromJson(json["user"]),
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
        "user": user.toJson(),
    };
}

class User {
    int id;
    String firstName;
    String lastName;
    String email;
    dynamic emailVerifiedAt;
    String phone;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.emailVerifiedAt,
        required this.phone,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Link {
    String? url;
    String label;
    bool active;

    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
