import 'dart:async';

import 'package:MechGesture/currentstate/currentState.dart';
import 'package:MechGesture/models/ourUser.dart';
import 'package:MechGesture/services/database.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  final TextEditingController _houseNo = TextEditingController();
  final TextEditingController _street = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _pincode = TextEditingController();
  //TextEditingController selectedDate = TextEditingController();

  FocusNode _nameFocus;
  FocusNode _phoneFocus;
  FocusNode _emailFocus;
  FocusNode _dobFocus;
  FocusNode _houseFocus;
  FocusNode _streetFocus;
  FocusNode _cityFocus;
  FocusNode _stateFocus;
  FocusNode _pincodeFocus;


  String gender = "female";

  DateTime selectedDate = DateTime.now();
  var d = 0;
  var m = 0;
  var y = 0;
  var ismale = false;
  var checkbox = [false, false, false];
  bool buttonNotActive = false;
  String buttonValue = "SAVE";
  void _updateCheckbox(int position) {
    setState(() {
      checkbox[position] = !checkbox[position];
    });
  }


  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        d = selectedDate.day;
        m = selectedDate.month;
        y = selectedDate.year;
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameFocus = FocusNode();
    _phoneFocus = FocusNode();
    _emailFocus = FocusNode();
    _dobFocus = FocusNode();
    _houseFocus = FocusNode();
    _streetFocus = FocusNode();
    _cityFocus = FocusNode();
    _stateFocus = FocusNode();
    _pincodeFocus = FocusNode();
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);


    if(_instance.currentUser.fullName!=null){
      _name.text = _instance.currentUser.fullName;
    }
    if(_instance.currentUser.phone!=null){
      _phone.text = _instance.currentUser.phone;
    }
    if(_instance.currentUser.email!=null){
      _email.text = _instance.currentUser.email;
    }
    if(_instance.currentUser.houseNo!=null){
      _houseNo.text = _instance.currentUser.houseNo;
    }
    if(_instance.currentUser.street!=null){
      _street.text = _instance.currentUser.street;
    }
    if(_instance.currentUser.city!=null){
      _city.text = _instance.currentUser.city;
    }
    if(_instance.currentUser.state!=null){
      _state.text = _instance.currentUser.state;
    }
    if(_instance.currentUser.pincode!=null){
      _pincode.text = _instance.currentUser.pincode;
    }

    if(_instance.currentUser.gender != null) {
      gender = _instance.currentUser.gender;
      if(gender == "male") {
        ismale = true;
      } else{
        ismale = false;
      }
      setState(() {

      });
    }


    //TODO : Make the same for a birthday
    if(_instance.currentUser.fullName!=null){
      _name.text = _instance.currentUser.fullName;
    }

    if(_instance.currentUser.dob != null){
      d = _instance.currentUser.dob.day;
      m = _instance.currentUser.dob.month;
      y = _instance.currentUser.dob.year;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _dobFocus.dispose();
    _houseFocus.dispose();
    _streetFocus.dispose();
    _cityFocus.dispose();
    _stateFocus.dispose();
    _pincodeFocus.dispose();
  }
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen:false);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: MyColors.blue_ribbon,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'My Profile',
          style: MyTextStyle.text3,
        ),
      ),
      bottomNavigationBar: AbsorbPointer(
        absorbing: buttonNotActive,
        child: GestureDetector(
          onTap: () async{
            bool allow = true;
            int changes = 0;
            // OurUser user = OurUser();
            //
            //
            // user.uid = _instance.currentUser.uid;
            // user.email = _email.text;
            // user.dob = selectedDate;
            // user.phone = _phone.text;
            // user.gender = gender;
            Map<String,dynamic> local = {};

            if(_name.text.isEmpty) {
              allow = false;
              Fluttertoast.showToast(msg: "Enter your name");
            }

            else if(_phone.text.isEmpty) {
              allow = false;
              Fluttertoast.showToast(msg: "Enter a phone number");
              _phoneFocus.requestFocus();
            }
            else if(_phone.text.isNotEmpty && _phone.text.length != 10) {
              allow = false;
              Fluttertoast.showToast(msg: "Enter a valid phone number");
              _phoneFocus.requestFocus();
            }

            else if(_email.text.isNotEmpty && !EmailValidator.validate(_email.text)) {
              allow = false;
              Fluttertoast.showToast(msg: "Enter a valid email");
              _emailFocus.requestFocus();
            }
            else if(_houseNo.text.isNotEmpty || _street.text.isNotEmpty || _city.text.isNotEmpty || _state.text.isNotEmpty || _pincode.text.isNotEmpty) {
              allow = false;
              if(_houseNo.text.isEmpty) {

                _houseFocus.requestFocus();
                Fluttertoast.showToast(msg: "Enter house number");
              } else if(_street.text.isEmpty) {
                Fluttertoast.showToast(msg: "Enter street details");
                _streetFocus.requestFocus();
              } else if(_city.text.isEmpty) {
                Fluttertoast.showToast(msg: "Enter city name");
                _cityFocus.requestFocus();
              } else if(_state.text.isEmpty) {
                Fluttertoast.showToast(msg: "Enter state name");
                _stateFocus.requestFocus();
              } else if(_pincode.text.isEmpty || _pincode.text.length != 6) {
                _pincodeFocus.requestFocus();
                Fluttertoast.showToast(msg: "Enter a valid pincode");
              } else {
                allow = true;
              }
            }
            else {

              if(_instance.currentUser.fullName != _name.text) {
                local["fullName"] = _name.text;
                changes++;
              }
              if(_instance.currentUser.email != _email.text) {
                local["email"] = _email.text;
                changes++;

              }
              if(_instance.currentUser.phone != _phone.text) {
                local["phone"] = _phone.text;

                changes++;

              }
              if(_instance.currentUser.gender != gender) {
                local["gender"] = gender;
                changes++;
              }

              // local = {
              //   "fullName":_name.text,
              //   "phone":_phone.text,
              //   "email": _email.text,
              //   "gender": gender,
              //   "uid":_instance.currentUser.uid,
              // };
            }
            if(allow) {

              if(DateTime.now() != selectedDate) {
                if(_instance.currentUser.dob != selectedDate) {
                  local["dob"] = selectedDate;
                  changes++;
                }
              }
              if(_instance.currentUser.fullName != _name.text) {
                local["fullName"] = _name.text;
                changes++;
              }
              if(_instance.currentUser.email != _email.text) {
                local["email"] = _email.text;
                changes++;

              }
              if(_instance.currentUser.phone != _phone.text) {
                //local["phone"] = _phone.text;

                // here i have to first verify the phone number of the user then update it in the database
                //changes++;
                // first check if the phone number does not already exists with some other user or not
                String _retVal = await _instance.checkPhone();
              }
              if(_instance.currentUser.gender != gender) {
                local["gender"] = gender;
                changes++;
              }
              if(_instance.currentUser.houseNo != _houseNo.text) {
                local["houseNo"] = _houseNo.text;
                changes++;

              }
              if(_instance.currentUser.street != _street.text) {
                local["street"] = _street.text;
                changes++;
              }
              if(_instance.currentUser.city != _city.text) {
                local["city"] = _city.text;
                changes++;
              }
              if(_instance.currentUser.state != _state.text) {
                local["state"] = _state.text;
                changes++;
              }
              if(_instance.currentUser.pincode != _pincode.text) {
                local["pincode"] = _pincode.text;
                changes++;
              }

              print(changes);
              if(changes > 0) {
                print("going in all the way up now");
                String _retval = await _instance.updateUserData(local);
                //_instance.currentUser = await OurDatabase().getUserInfo(_instance.currentUser.uid);

                if(_retval == "success") {
                  Fluttertoast.showToast(msg: "Changes saved successfully");
                  _instance.currentUser.gender = gender;
                  _instance.currentUser.phone = _phone.text;
                  _instance.currentUser.email = _email.text;
                  _instance.currentUser.fullName = _name.text;
                  _instance.currentUser.houseNo = _houseNo.text;
                  _instance.currentUser.street = _street.text;
                  _instance.currentUser.city = _city.text;
                  _instance.currentUser.state = _state.text;
                  _instance.currentUser.pincode = _pincode.text;
                  _instance.currentUser.dob = selectedDate;
                  await _instance.saveAllData();

                }
                else {
                  Fluttertoast.showToast(msg: "Something went wrong try again later");
                }
              } else {
                Fluttertoast.showToast(msg: "No changes to be saved");
              }

            }
          },
          child: Container(
            height: height * 0.08,
            color: MyColors.blue_ribbon,
            child: Center(
              child: Text(
                buttonValue,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 10, left: 45, right: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 115,
                    width: 115,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: MyColors.blue_ribbon),
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: MyColors.blue_ribbon,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 15),
              //       child: Text(
              //         'USERNAME',
              //         style: MyTextStyle.referEarnText,
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 7, bottom: 28),
              //       child: TextField(
              //         decoration: InputDecoration(
              //           border: OutlineInputBorder(),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'NAME',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: TextField(
                      focusNode: _nameFocus,
                      controller: _name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'PHONE',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColors.text2,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    topLeft: Radius.circular(5)),
                              ),
                              child: Center(child: Text('+91')),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: TextField(
                              focusNode: _phoneFocus,
                              controller: _phone,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'EMAIL ADDRESS',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: TextField(
                      focusNode:_emailFocus,

                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'DATE OF BIRTH',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 2, color: Colors.black38)),
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: d != 0
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.end,
                            children: [
                              if (d != 0) Center(child: Text('$d - $m - $y')),
                              Icon(
                                Icons.calendar_today_rounded,
                                color: MyColors.blue_ribbon,
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'GENDER',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 28),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ismale = true;
                                gender = "male";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ismale ? MyColors.blue_ribbon : null,
                                border: !ismale
                                    ? Border.all(width: 2, color: Colors.grey)
                                    : null,
                              ),
                              child: Center(
                                  child: Text(
                                'Male',
                                style: ismale
                                    ? MyTextStyle.text4
                                    : MyTextStyle.text3,
                              )),
                              height: 50,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ismale = false;
                                gender = "female";
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: !ismale ? MyColors.blue_ribbon : null,
                                border: ismale
                                    ? Border.all(width: 2, color: Colors.grey)
                                    : null,
                              ),
                              height: 50,
                              child: Center(
                                  child: Text(
                                'Female',
                                style: !ismale
                                    ? MyTextStyle.text4
                                    : MyTextStyle.text3,
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'ADDRESS',
                      style: MyTextStyle.referEarnText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: TextField(
                      focusNode: _houseFocus,
                      controller: _houseNo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'House no./ Flat no.',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      focusNode:_streetFocus,
                      controller: _street,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Street/town',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode:_cityFocus,
                            controller: _city,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'City',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _stateFocus,
                            controller: _state,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'State',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6),
                        // ignore: deprecated_member_use
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      focusNode: _pincodeFocus,
                      controller: _pincode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Pincode',
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 15),
              //       child: Text('CHOOSE VECHICLE'),
              //     ),
              //     Padding(
              //         padding:
              //             const EdgeInsets.only(top: 13, bottom: 28, left: 25),
              //         child: Column(
              //           children: [
              //             CheckBox(
              //               pos: 0,
              //               text: 'Bike',
              //               update: _updateCheckbox,
              //               boxStatus: checkbox,
              //             ),
              //             SizedBox(
              //               height: 7,
              //             ),
              //             CheckBox(
              //               pos: 1,
              //               text: 'Car',
              //               update: _updateCheckbox,
              //               boxStatus: checkbox,
              //             ),
              //             SizedBox(
              //               height: 7,
              //             ),
              //             CheckBox(
              //               pos: 2,
              //               text: 'Truck',
              //               update: _updateCheckbox,
              //               boxStatus: checkbox,
              //             ),
              //           ],
              //         )),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CheckBox extends StatelessWidget {
//   CheckBox({this.update, this.pos, this.text, this.boxStatus});
//   var update, boxStatus;
//   int pos;
//   String text;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => update(pos),
//       child: Row(
//         children: [
//           Container(
//             height: 20,
//             width: 20,
//             decoration: BoxDecoration(
//               color: !boxStatus[pos] ? Colors.white : Colors.black,
//               border: Border.all(width: 1, color: Colors.grey),
//             ),
//           ),
//           SizedBox(
//             width: 13,
//           ),
//           Text(
//             '$text',
//             style: MyTextStyle.text3,
//           )
//         ],
//       ),
//     );
//   }
// }
