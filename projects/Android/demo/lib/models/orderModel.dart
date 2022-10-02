import 'garage/sub_models/MechanicServies.dart';

class OrderModel {
  /// This class contains the model of the user that the user might have
  /// done in the past

  String orderId;
  String shopUID;
  String shopName;
  List<MechanicServices> servicesOrder;
  Map charges;
  String otp;
  bool pickup;
  String vehicleName;
  String vehicleBrand;
  String vehicleType;
  Map address;
  String userPhone;
  DateTime orderTime;
  String employeeName;
  String employeeUID;

  OrderModel({
    this.orderId,
    this.vehicleName,
    this.vehicleBrand,
    this.pickup,
    this.otp,
    this.charges,
    this.userPhone,
    this.shopName,
    this.address,
    this.vehicleType,
    this.servicesOrder,
    this.shopUID,
    this.orderTime,
    this.employeeName,
    this.employeeUID
  });
}