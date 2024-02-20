// To parse this JSON data, do
//
//     final roleResponseModel = roleResponseModelFromJson(jsonString);

import 'dart:convert';

RoleResponseModel roleResponseModelFromJson(String str) => RoleResponseModel.fromJson(json.decode(str));

String roleResponseModelToJson(RoleResponseModel data) => json.encode(data.toJson());

class RoleResponseModel {
    List<Role> roles;

    RoleResponseModel({
        required this.roles,
    });

    factory RoleResponseModel.fromJson(Map<String, dynamic> json) => RoleResponseModel(
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    };
}

class Role {
    int id;
    String name;
    String guardName;
    DateTime? createdAt;
    DateTime? updatedAt;

    Role({
        required this.id,
        required this.name,
        required this.guardName,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
