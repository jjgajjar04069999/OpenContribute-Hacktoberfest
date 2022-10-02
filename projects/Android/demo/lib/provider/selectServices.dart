import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:flutter/cupertino.dart';

class SelectServices extends ChangeNotifier {
  int selectedDrawerIndex = 0;
  List<int> selectedDrawerIndexHistory = [0];
  List<MechanicServices> selectedServices = [];

  selectDeselectServices(
      {@required MechanicServices addData, @required bool local}) {
    //print(addData.name);
    // this means add the service to the list
    if (local == true) {
      //print(addData.price);
      selectedServices.add(addData);
    }

    // this means remove from the list
    else if (local == false) {
      if (selectedServices.contains(addData)) {
        selectedServices.remove(addData);
      }
    }

    List<MechanicServices> sendSelectedServices() {
      return selectedServices;
    }
  }
}
