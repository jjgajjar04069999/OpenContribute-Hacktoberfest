import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/provider/selectServices.dart';
import 'package:MechGesture/values/MyColors.dart';
import 'package:MechGesture/values/MyTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescribePage extends StatefulWidget {
  @override
  _DescribePageState createState() => _DescribePageState();
}

class _DescribePageState extends State<DescribePage> {
  String selected_payment = 'On cash';
  double totalPrice = 0.0;
  double h = 0;
  var selectedVehicle = [true, false, false]; //bike, car, truck respectively
  int selectedModel = 0;
  int selectedLocation = 0; // 0 is user current location
  void update_payment(String k) {
    setState(() {
      selected_payment = k;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MechanicServices> _selectedServices =
        Provider.of<SelectServices>(context, listen: false).selectedServices;
    totalPrice = 0.0;
    for (int i = 0; i < _selectedServices.length; i++) {
      totalPrice += _selectedServices[i].price;
    }
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Image.asset("assets/images/icons/backArrow.png"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //decribe text field
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Describe (optional)',
                      style: MyTextStyle.text1,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Describe your problem or\nLeave it blank'),
                      maxLines: 7,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //selected servies display
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Repairment &\nServices',
                      style: MyTextStyle.text1,
                    ),
                    Text(
                      'Price rate',
                      style: MyTextStyle.text1,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Positioned.fill(
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (h == 0) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            // Here you can write your code for open new view
                            h = constraints.maxHeight + 55;
                          });
                        });
                      }
                      return Container();
                    }),
                  ),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    // Provide an optional curve to make the animation feel smoother.
                    curve: Curves.fastOutSlowIn,
                    height: h,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL',
                                style: MyTextStyle.text1,
                              ),
                              Text(
                                'Rs.$totalPrice',
                                style: MyTextStyle.text2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 10, right: 30, bottom: 10, top: 10),
                      child: Column(
                        children: [
                          for (int i = 0; i < _selectedServices.length; i++)
                            TextRateDisplay(
                              text: '${_selectedServices[i].name}',
                              rate: '${_selectedServices[i].price}',
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Select Vehicle',
                style: MyTextStyle.text1,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVehicle[0] = true;
                          selectedVehicle[1] = false;
                          selectedVehicle[2] = false;
                        });
                      },
                      child: SelectVehicle(
                        selected: selectedVehicle[0],
                        img: 'assets/images/icons/bike.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVehicle[0] = false;
                          selectedVehicle[1] = true;
                          selectedVehicle[2] = false;
                        });
                      },
                      child: SelectVehicle(
                        selected: selectedVehicle[1],
                        img: 'assets/images/icons/car.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVehicle[0] = false;
                          selectedVehicle[1] = false;
                          selectedVehicle[2] = true;
                        });
                      },
                      child: SelectVehicle(
                        selected: selectedVehicle[2],
                        img: 'assets/images/icons/truck.png',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Pick One',
                style: MyTextStyle.text1,
              ),
              Container(
                height: 120,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      2, // change this lenght based on users bikes which will be in database
                  itemBuilder: (ctx, i) {
                    var brandDemo = ["Honda", "Yamaha"];
                    var modelDemo = ["CB350", "MT-15"];
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedModel = i;
                            });
                          },
                          child: SelectVehicle(
                            selected: selectedModel == i ? true : false,
                            brand: brandDemo[i],
                            model: modelDemo[i],
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(
                height: 35,
              ),
              Text(
                'Select Address',
                style: MyTextStyle.text1,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLocation = 0;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selectedLocation == 0
                          ? SelectedCheckBox()
                          : UnSelectedCheckBox(),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          'Lane 2, Santipur High Way, Guwahati',
                          style: MyTextStyle.text3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLocation = 1;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      selectedLocation == 1
                          ? SelectedCheckBox()
                          : UnSelectedCheckBox(),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          'Lane 2, Santipur High Way, Guwahati',
                          style: MyTextStyle.text3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Select payment method',
                style: MyTextStyle.text1,
              ),
              SizedBox(
                height: 15,
              ),
              selected_payment == 'On cash'
                  ? SelectedPayment('On cash')
                  : PaymentOption(
                      text: 'On cash',
                      func: update_payment,
                    ),
              selected_payment == 'ATM/ Debit / Credit card'
                  ? SelectedPayment('ATM/ Debit / Credit card')
                  : PaymentOption(
                      text: 'ATM/ Debit / Credit card',
                      func: update_payment,
                    ),
              selected_payment == 'Through UPI payment'
                  ? SelectedPayment('Through UPI payment')
                  : PaymentOption(
                      text: 'Through UPI payment',
                      func: update_payment,
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'CANCEL',
                  style: MyTextStyle.text3,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Navigator.popAndPushNamed(context, "/trackPage",
                    arguments: {
                      'isGarage': false,
                      'isMechanic': true,
                    }),
                child: Container(
                  color: MyColors.service_card_border,
                  child: Center(
                    child: Text(
                      'CONFIRM',
                      style: MyTextStyle.text4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextRateDisplay extends StatelessWidget {
  TextRateDisplay({this.text, this.rate});
  String text, rate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SelectedCheckBox(),
              SizedBox(
                width: 10,
              ),
              Text(
                '$text',
                style: MyTextStyle.text7,
              ),
            ],
          ),
          Text(
            'Rs.$rate',
            style: MyTextStyle.text7,
          ),
        ],
      ),
    );
  }
}

class SelectedPayment extends StatelessWidget {
  SelectedPayment(this.text);
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.greenAccent[100],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$text',
            style: TextStyle(
                color: MyColors.parrotGreen,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          FittedBox(
            child: Icon(
              Icons.check,
              color: MyColors.parrotGreen,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  PaymentOption({this.text, this.func});
  String text;
  var func;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        func('$text');
      },
      child: Container(
        height: 65,
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          '$text',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class SelectVehicle extends StatelessWidget {
  SelectVehicle({this.selected, this.img, this.brand, this.model});
  bool selected;
  String img, brand, model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 100,
      width: img != null
          ? 100
          : MediaQuery.of(context).size.width / 2 -
              40, // if text==null means it isselecte vechicle option otherwise it is pick vechicle brand option
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 2, color: selected ? MyColors.darkishBlue : Colors.grey)),
      child: Stack(
        children: [
          if (img != null)
            Align(
              alignment: Alignment.center,
              child: Image.asset('$img'),
            ),
          if (img == null)
            Align(
              alignment: Alignment.center,
              child: Text(
                '$brand\n$model',
                style: MyTextStyle.text3,
              ),
            ),
          if (selected)
            Positioned(
              bottom: 5,
              right: 5,
              child: Icon(
                Icons.check,
                color: MyColors.darkishBlue,
              ),
            ),
        ],
      ),
    );
  }
}

class SelectedCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          width: 2,
          color: Colors.blue[300],
        ),
      ),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2), color: Colors.blue[300]),
      ),
    );
  }
}

class UnSelectedCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(width: 2, color: Colors.grey),
      ),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2), color: Colors.white),
      ),
    );
  }
}
