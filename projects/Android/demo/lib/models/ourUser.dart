

import 'package:hive/hive.dart';


part 'ourUser.g.dart';


@HiveType(typeId: 133, adapterName: "OurUserHiveGen")
class OurUser{

  @HiveField(0)
  String uid;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String fullName;

  @HiveField(3)
  String type; // if the user is a mechanic or a customer

  @HiveField(4)
  String email;

  @HiveField(5)
  String profileImg;

  @HiveField(6)
  String gender;


  @HiveField(7)
  String houseNo;

  @HiveField(8)
  String street;

  @HiveField(9)
  String city;

  @HiveField(10)
  String state;

  @HiveField(11)
  String pincode;


  @HiveField(12)
  List orders;

  @HiveField(13)
  DateTime dob;


  OurUser({
    this.uid,
    this.phone,
    this.fullName,
    this.email,
    this.type,
    this.profileImg,
    this.gender,
    this.state,
    this.pincode,
    this.city,
    this.street,
    this.houseNo,
    this.orders,
    this.dob,
  });


  // factory OurUser.fromJSON(Map<String, dynamic> json) {
  //   return OurUser(
  //     uid: json['uid'],
  //     phone: json['phone'],
  //     fullName: json['fullName'],
  //     email: json['email'],
  //     type: json['type'],
  //     profileImg: json['profileImg'],
  //     gender: json['gender'],
  //     state: json['state'],
  //     pincode: json['pincode'],
  //     city: json['city'],
  //     street: json['street'],
  //     houseNo: json['houseNo'],
  //     orders: json['orders'],
  //     dob: json['dob'],
  //   );
  // }


  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'phone':phone,
      'fullName':fullName,
      'email':email,
      'type':type,
      'profileImg':profileImg,
      'gender':gender,
      'state':state,
      'pincode':pincode,
      'city':city,
      'street':street,
      'houseNo':houseNo,
      'orders':orders,
      'dob':dob,
    };
  }

  OurUser toInstance(Map<String, dynamic> json) {
    return OurUser(
      uid: json['uid'],
      phone: json['phone'],
      fullName: json['fullName'],
      email: json['email'],
      type: json['type'],
      profileImg: json['profileImg'],
      gender: json['gender'],
      state: json['state'],
      pincode: json['pincode'],
      city: json['city'],
      street: json['street'],
      houseNo: json['houseNo'],
      orders: json['orders'],
      dob: json['dob'] != null ? json['dob'].toDate() : json['dob'],
    );
  }


}