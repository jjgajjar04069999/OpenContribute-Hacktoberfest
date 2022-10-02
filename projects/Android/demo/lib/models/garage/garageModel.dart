import 'package:MechGesture/models/garage/sub_models/ImagesModel.dart';
import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/models/garage/sub_models/addressModel.dart';
import 'package:MechGesture/models/garage/sub_models/contactsModel.dart';
import 'package:MechGesture/models/garage/sub_models/ownerDetailsModel.dart';
import 'package:MechGesture/models/garage/sub_models/timingModel.dart';

enum GarageStatus {
  Available,
  Not,
}

class OurGarage {
  String
      uid; // this will be the unique uid of the garage that will be used to first find the garage and then place the order to that mechanic
  String name; // name of the garage
  String type; // type of the business
  String establishedYear;
  String aboutUs;
  bool status; // is the garage taking orders at the moment or not
  TimingModel openTime; // this will contain the opening time of the garage
  TimingModel closeTime; // this will contain the closing time of the garage
  ImagesModel
      images; // this will contain all the images, the profile and the carasuel
  ContactsModel contacts;
  AddressModel address;
  OwnerDetailsModel ownerDetails;
  //List<MechanicServices> servicesOffered;  // this needs to contain the services that the particular garage offers to the user
  var vehiclesServices; // the types of vehicles that the garage can service
  double satisfaction;
  String distanceAway;
  List<MechanicServices> products;
  //List

  OurGarage({
    this.uid,
    this.name,
    this.type,
    this.establishedYear,
    this.aboutUs,
    this.status,
    this.openTime,
    this.closeTime,
    this.images,
    this.contacts,
    this.address,
    this.ownerDetails,
    this.vehiclesServices,
    this.satisfaction,
    this.distanceAway,
    this.products,
    //this.servicesOffered
  });
}
