// To parse this JSON data, do
//
//     final astrologerModel = astrologerModelFromJson(jsonString);

import 'dart:convert';

AstrologerModel astrologerModelFromJson(String str) => AstrologerModel.fromJson(json.decode(str));

String astrologerModelToJson(AstrologerModel data) => json.encode(data.toJson());

class AstrologerModel {

  AstrologerModel({
    this.id,
    this.name,
    this.userType,
    this.categoryId,
    this.address,
    this.email,
    this.phoneNo,
    this.dob,
    this.birthTime,
    this.birthPlace,
    this.otpVerifiedAt,
    this.password,
    this.rememberToken,
    this.deviceId,
    this.userExpertise,
    this.userExperience,
    this.userLanguage,
    this.userRating,
    this.userAboutus,
    this.userAvability,
    this.userEducation,
    this.profileImage,
    this.imageUrl,
    this.otp,
    this.otpVerify,
    this.amount,
    this.perMinute,
    this.bloodGroup,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.country,
    this.zipcode,
    this.city,
    this.liveAstrologerPrefrence,
    this.status,
    this.isLogin,
    this.token,
    this.connectionId,
    this.userStatus,
    this.webDeviceId,
    this.isBusy,
    this.kundliId,
  });

  int? id;
  String? name;
  int? userType;
  String? categoryId;
  String? address;
  String? email;
  String? phoneNo;
  String? dob;
  String? birthTime;
  String? birthPlace;
  dynamic otpVerifiedAt;
  String? password;
  String? rememberToken;
  String? deviceId;
  String? userExpertise;
  String? userExperience;
  String? userLanguage;
  dynamic userRating;
  String? userAboutus;
  String? userAvability;
  String? userEducation;
  String? profileImage;
  String? imageUrl;
  dynamic otp;
  dynamic otpVerify;
  dynamic amount;
  String? perMinute;
  dynamic bloodGroup;
  String? gender;
  String? createdAt;
  String? updatedAt;
  dynamic country;
  dynamic zipcode;
  dynamic city;
  String? liveAstrologerPrefrence;
  int? status;
  int? isLogin;
  String? token;
  String? connectionId;
  String? userStatus;
  String? webDeviceId;
  int? isBusy;
  dynamic kundliId;

  factory AstrologerModel.fromJson(Map<String, dynamic> json) => AstrologerModel(
    id: json["id"],
    name: json["name"],
    userType: json["user_type"],
    categoryId: json["category_id"],
    address: json["address"],
    email: json["email"],
    phoneNo: json["phone_no"],
    dob: json["dob"],
    birthTime: json["birth_time"],
    birthPlace: json["birth_place"],
    otpVerifiedAt: json["otp_verified_at"],
    password: json["password"],
    rememberToken: json["remember_token"],
    deviceId: json["device_id"],
    userExpertise: json["user_expertise"],
    userExperience: json["user_experience"],
    userLanguage: json["user_language"],
    userRating: json["user_rating"],
    userAboutus: json["user_aboutus"],
    userAvability: json["user_avability"],
    userEducation: json["user_education"],
    profileImage: json["profile_image"],
    imageUrl: json["image_url"],
    otp: json["otp"],
    otpVerify: json["otp_verify"],
    amount: json["amount"],
    perMinute: json["per_minute"],
    bloodGroup: json["blood_group"],
    gender: json["gender"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    country: json["country"],
    zipcode: json["zipcode"],
    city: json["city"],
    liveAstrologerPrefrence: json["live_astrologer_prefrence"],
    status: json["status"],
    isLogin: json["is_login"],
    token: json["token"],
    connectionId: json["connection_id"],
    userStatus: json["user_status"],
    webDeviceId: json["web_device_id"],
    isBusy: json["is_busy"],
    kundliId: json["kundli_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_type": userType,
    "category_id": categoryId,
    "address": address,
    "email": email,
    "phone_no": phoneNo,
    "dob": dob,
    "birth_time": birthTime,
    "birth_place": birthPlace,
    "otp_verified_at": otpVerifiedAt,
    "password": password,
    "remember_token": rememberToken,
    "device_id": deviceId,
    "user_expertise": userExpertise,
    "user_experience": userExperience,
    "user_language": userLanguage,
    "user_rating": userRating,
    "user_aboutus": userAboutus,
    "user_avability": userAvability,
    "user_education": userEducation,
    "profile_image": profileImage,
    "image_url": imageUrl,
    "otp": otp,
    "otp_verify": otpVerify,
    "amount": amount,
    "per_minute": perMinute,
    "blood_group": bloodGroup,
    "gender": gender,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "country": country,
    "zipcode": zipcode,
    "city": city,
    "live_astrologer_prefrence": liveAstrologerPrefrence,
    "status": status,
    "is_login": isLogin,
    "token": token,
    "connection_id": connectionId,
    "user_status": userStatus,
    "web_device_id": webDeviceId,
    "is_busy": isBusy,
    "kundli_id": kundliId,
  };
}
