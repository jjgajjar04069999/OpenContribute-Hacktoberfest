// this is used to find if the story will be a image or a video
import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';

enum Status {
  Available,
  Not,
}

class OurMechanic {
  final String name;
  final String type;
  final String distanceAway;
  final Status status;
  final List vehiclesServices;
  final String image;
  final int age;
  final String gender;
  final List<MechanicServices> services;

  OurMechanic(
      {this.status,
        this.name,
        this.image,
        this.distanceAway,
        this.vehiclesServices,
        this.type,
        this.gender,
        this.age,
        this.services});
}
