import 'package:MechGesture/models/garage/sub_models/MechanicServies.dart';
import 'package:MechGesture/models/mechanicModel.dart';

import 'package:MechGesture/models/vehiclesModel.dart';

final mechanicList = [
  OurMechanic(
      name: "Suresh Singh",
      type: "mechanic",
      distanceAway: "1.3 km away",
      vehiclesServices: ["cars", "Bike", "truck"],
      status: Status.Available,
      age: 24,
      gender: "Male",
      services: [
        MechanicServices(name: "Oiling", price: 40),
        MechanicServices(name: "Replace Tire", price: 100),
        MechanicServices(name: "Battery", price: 70),
        MechanicServices(name: "headlight", price: 120),
      ]),
  OurMechanic(
      name: "Rakesh sharma",
      type: "mechanic",
      distanceAway: "1.5 km away",
      vehiclesServices: ["cars", "truck"],
      status: Status.Available,
      gender: "Male",
      age: 30,
      services: [
        MechanicServices(name: "Oiling", price: 40),
        MechanicServices(name: "Replace Tire", price: 100),
        MechanicServices(name: "Battery", price: 70),
        MechanicServices(name: "headlight", price: 120),
      ]),
  OurMechanic(
      name: "Rahul Singh",
      type: "mechanic",
      distanceAway: "3.3 km away",
      vehiclesServices: ["cars", "bike", "truck"],
      status: Status.Available,
      gender: "Male",
      age: 39,
      services: [
        MechanicServices(name: "Oiling", price: 40),
        MechanicServices(name: "Replace Tire", price: 100),
        MechanicServices(name: "Battery", price: 70),
        MechanicServices(name: "headlight", price: 120),
      ]),
  OurMechanic(
      name: "Raj Singh",
      type: "mechanic",
      distanceAway: "4.3 km away",
      vehiclesServices: ["cars", "truck"],
      status: Status.Available,
      gender: "Male",
      age: 36,
      services: [
        MechanicServices(name: "Oiling", price: 39),
        MechanicServices(name: "Replace Tire", price: 100),
        MechanicServices(name: "Battery", price: 70),
        MechanicServices(name: "headlight", price: 120),
      ]),
  OurMechanic(
      name: "Raj Singh",
      type: "mechanic",
      distanceAway: "4.3 km away",
      vehiclesServices: ["cars", "truck"],
      status: Status.Available,
      gender: "Male",
      age: 36,
      services: [
        MechanicServices(name: "Oiling", price: 39),
        MechanicServices(name: "Replace Tire", price: 100),
        MechanicServices(name: "Battery", price: 70),
        MechanicServices(name: "headlight", price: 120),
      ]),
];


final garageList = [
  // OurGarage(
  //     name: "Moto Pvt. Ltd",
  //     type: "garage",
  //     est: "2005",
  //     satisfaction: 80,
  //     aboutus: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
  //         "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
  //         "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore "
  //         "eu fugiat nulla pariatur. ",
  //
  //     openingTime: "09:00",
  //     closingTime: "09:00",
  //     distanceAway: "1.3 km away",
  //
  //     vehiclesServices: ["cars","truck"],
  //     status: GarageStatus.Available,
  //     age: 24,
  //     gender: "Male",
  //     services: [
  //       MechanicServices(name: "Denting & Painting", price: 40),
  //       MechanicServices(name: "Batteries", price: 200),
  //       MechanicServices(name: "Spa & Cleaning", price: 500),
  //       MechanicServices(name: "AC Services & repair", price: 250),
  //       MechanicServices(name: "Tyres & wheel repair", price: 70),
  //       MechanicServices(name: "Custom Service", price: 500),
  //       MechanicServices(name: "Detailing Service", price: 1000),
  //       MechanicServices(name: "Windshields & Glass", price: 70),
  //       MechanicServices(name: "Lights & Fitments", price: 120),
  //     ]
  // ),
  // OurGarage(
  //     name: "Surender Service Center",
  //     type: "garage",
  //     est: "1998",
  //     satisfaction: 70,
  //     aboutus: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
  //         "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
  //         "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore "
  //         "eu fugiat nulla pariatur. ",
  //
  //     openingTime: "08:00",
  //     closingTime: "11:00",
  //     distanceAway: "1.5 km away",
  //     vehiclesServices: ["cars"],
  //     status: GarageStatus.Available,
  //     gender: "Male",
  //     age: 30,
  //     services: [
  //       MechanicServices(name: "Denting & Painting", price: 40),
  //       MechanicServices(name: "Batteries", price: 200),
  //       MechanicServices(name: "Spa & Cleaning", price: 500),
  //       MechanicServices(name: "AC Services & repair", price: 250),
  //       MechanicServices(name: "Tyres & wheel repair", price: 70),
  //       MechanicServices(name: "Custom Service", price: 500),
  //       MechanicServices(name: "Detailing Service", price: 1000),
  //       MechanicServices(name: "Windshields & Glass", price: 70),
  //       MechanicServices(name: "Lights & Fitments", price: 120),
  //     ]
  // ),
  // OurGarage(
  //     name: "Rahul Singh",
  //     type: "mechanic",
  //     est: "2001",
  //     satisfaction: 60,
  //     aboutus: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
  //         "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
  //         "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore "
  //         "eu fugiat nulla pariatur. ",
  //
  //     openingTime: "09:00",
  //     closingTime: "09:00",
  //     distanceAway: "3.3 km away",
  //     vehiclesServices: ["cars", "bike","truck"],
  //     status: GarageStatus.Available,
  //     gender: "Male",
  //     age: 39,
  //     services: [
  //       MechanicServices(name: "Denting & Painting", price: 40),
  //       MechanicServices(name: "Batteries", price: 200),
  //       MechanicServices(name: "Spa & Cleaning", price: 500),
  //       MechanicServices(name: "AC Services & repair", price: 250),
  //       MechanicServices(name: "Tyres & wheel repair", price: 70),
  //       MechanicServices(name: "Custom Service", price: 500),
  //       MechanicServices(name: "Detailing Service", price: 1000),
  //       MechanicServices(name: "Windshields & Glass", price: 70),
  //       MechanicServices(name: "Lights & Fitments", price: 120),
  //     ]
  // ),
  // OurGarage(
  //     name: "Raj Singh",
  //     type: "mechanic",
  //     est: "2018",
  //     satisfaction: 80,
  //     aboutus: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
  //         "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
  //         "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore "
  //         "eu fugiat nulla pariatur. ",
  //
  //     openingTime: "09:00",
  //     closingTime: "09:00",
  //     distanceAway: "4.3 km away",
  //     vehiclesServices: ["cars", "truck"],
  //     status: GarageStatus.Available,
  //     gender: "Male",
  //     age: 36,
  //     services: [
  //       MechanicServices(name: "Denting & Painting", price: 40),
  //       MechanicServices(name: "Batteries", price: 200),
  //       MechanicServices(name: "Spa & Cleaning", price: 500),
  //       MechanicServices(name: "AC Services & repair", price: 250),
  //       MechanicServices(name: "Tyres & wheel repair", price: 70),
  //       MechanicServices(name: "Custom Service", price: 500),
  //       MechanicServices(name: "Detailing Service", price: 1000),
  //       MechanicServices(name: "Windshields & Glass", price: 70),
  //       MechanicServices(name: "Lights & Fitments", price: 120),
  //     ]
  // ),
  // OurGarage(
  //     name: "Raj Singh",
  //     type: "mechanic",
  //     est: "2021",
  //     satisfaction: 80,
  //     aboutus: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
  //         "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
  //         "aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore "
  //         "eu fugiat nulla pariatur. ",
  //
  //     openingTime: "09:00",
  //     closingTime: "09:00",
  //     distanceAway: "4.3 km away",
  //     vehiclesServices: ["cars", "truck"],
  //     status: GarageStatus.Available,
  //     gender: "Male",
  //     age: 36,
  //     services: [
  //       MechanicServices(name: "Denting & Painting", price: 40),
  //       MechanicServices(name: "Batteries", price: 200),
  //       MechanicServices(name: "Spa & Cleaning", price: 500),
  //       MechanicServices(name: "AC Services & repair", price: 250),
  //       MechanicServices(name: "Tyres & wheel repair", price: 70),
  //       MechanicServices(name: "Custom Service", price: 500),
  //       MechanicServices(name: "Detailing Service", price: 1000),
  //       MechanicServices(name: "Windshields & Glass", price: 70),
  //       MechanicServices(name: "Lights & Fitments", price: 120),
  //     ]
  // ),
];

final List<VehiclesModel> motorCycleList = [
  VehiclesModel(brand: "Honda", model: "CBZ"),
  VehiclesModel(brand: "Yamaha", model: "MT-15"),
];

final List<VehiclesModel> carsList = [
  VehiclesModel(brand: "Tesla", model: "Model 3"),
  VehiclesModel(brand: "Audi", model: "A3"),
];

final List<VehiclesModel> trucksList = [
  VehiclesModel(brand: "Tata", model: "H13A"),
  VehiclesModel(brand: "Ashok Leyland", model: "KI-0"),
];


final   List carBrands = [

  {"imageL": "assets/images/cars/ashok.png", "text": "Ashok"},
  {"imageL": "assets/images/cars/audi.png", "text": "Audi"},
  {"imageL": "assets/images/cars/chevrolet.png", "text": "Chevrolet"},
  {"imageL": "assets/images/cars/datsun.png", "text": "Datsun"},
  {"imageL": "assets/images/cars/fiat.png", "text": "Fiat"},
  {"imageL": "assets/images/cars/forcce.png", "text": "Forcce"},
  {"imageL": "assets/images/cars/ford.png", "text": "Ford"},
  {"imageL": "assets/images/cars/honda.png", "text": "Honda"},
  {"imageL": "assets/images/cars/hyundai.png", "text": "Hyundai"},
  {"imageL": "assets/images/cars/jeep.png", "text": "Jeep"},
  {"imageL": "assets/images/cars/kia.png", "text": "Kia"},
  {"imageL": "assets/images/cars/land.png", "text": "LandRover"},
  {"imageL": "assets/images/cars/mahindra.png", "text": "Mahindra"},
  {"imageL": "assets/images/cars/maruti-suzuki.png", "text": "Maruti"},
  {"imageL": "assets/images/cars/mercedes.png", "text": "Mercedes"},
  {"imageL": "assets/images/cars/mg.png", "text": "MG"},
  {"imageL": "assets/images/cars/nissan.png", "text": "Nissan"},
  {"imageL": "assets/images/cars/range.png", "text": "Range"},
  {"imageL": "assets/images/cars/renault.png", "text": "Renault"},
  {"imageL": "assets/images/cars/skoda.png", "text": "Skoda"},
  {"imageL": "assets/images/cars/tata.png", "text": "Tata"},
  {"imageL": "assets/images/cars/toyota.png", "text": "Toyota"},
  {"imageL": "assets/images/cars/volkswagen.png", "text": "Volkswagen"},
  {"imageL": "assets/images/cars/volvo.png", "text": "Volvo"},
  {"imageL": "none", "text": "Others"},
];


final   List bikeBrands = [

  {"imageL": "assets/images/bikes/aprillia.jpg", "text": "Aprillia"},
  {"imageL": "assets/images/bikes/bajaj.png", "text": "Bajaj"},
  {"imageL": "assets/images/bikes/benelli.png", "text": "Benelli"},
  {"imageL": "assets/images/bikes/bmw.png", "text": "BMW"},
  {"imageL": "assets/images/bikes/ducati.png", "text": "Ducati"},
  {"imageL": "assets/images/bikes/hero.png", "text": "Hero"},
  {"imageL": "assets/images/bikes/honda.png", "text": "Honda"},
  {"imageL": "assets/images/bikes/husqvarna.jpg", "text": "Husqvarna"},
  {"imageL": "assets/images/bikes/Hyosung.png", "text": "Hyosung"},
  {"imageL": "assets/images/bikes/jawa.png", "text": "Jawa"},
  {"imageL": "assets/images/bikes/kawasaki.png", "text": "Kawasaki"},
  {"imageL": "assets/images/bikes/ktm.png", "text": "KTM"},
  {"imageL": "assets/images/bikes/revolt.png", "text": "Revolt"},
  {"imageL": "assets/images/bikes/royal-enfield.png", "text": "Royal-Enfield"},
  {"imageL": "assets/images/bikes/suzuki.png", "text": "Suzuki"},
  {"imageL": "assets/images/bikes/tvs.png", "text": "TVS"},
  {"imageL": "assets/images/bikes/yamaha.png", "text": "Yamaha"},
  {"imageL": "none", "text": "Others"},
];


final List laptopBrands =  [

  {"imageL": "assets/images/laptop/acer.png", "text": "Acer"},
  {"imageL": "assets/images/laptop/dell.png", "text": "Dell"},
  {"imageL": "assets/images/laptop/hp.png", "text": "Hp"},
  {"imageL": "assets/images/laptop/iball.png", "text": "iBall"},
  {"imageL": "assets/images/laptop/lenovo.png", "text": "Lenovo"},
  {"imageL": "assets/images/laptop/msi.png", "text": "MSI"},
  {"imageL": "assets/images/laptop/toshiba.png", "text": "Toshiba"},

];


final List mobileBrands = [
  {"imageL": "assets/images/Phone-brands/apple.png", "text": "Apple"},
  {"imageL": "assets/images/Phone-brands/asus.png", "text": "Asus"},
  {"imageL": "assets/images/Phone-brands/bbm.png", "text": "Blackberrry"},
  {"imageL": "assets/images/Phone-brands/coolpad.png", "text": "Coolpad"},
  {"imageL": "assets/images/Phone-brands/google.png", "text": "Google"},
  {"imageL": "assets/images/Phone-brands/honor.png", "text": "Honor"},
  {"imageL": "assets/images/Phone-brands/htc.png", "text": "Htc"},
  {"imageL": "assets/images/Phone-brands/huawei.png", "text": "Huawei"},
  {"imageL": "assets/images/Phone-brands/intex.jpg", "text": "Intex"},
  {"imageL": "assets/images/Phone-brands/karbonn.png", "text": "Karbonn"},
  {"imageL": "assets/images/Phone-brands/lava.png", "text": "Lava"},
  {"imageL": "assets/images/Phone-brands/lg.png", "text": "LG"},
  {"imageL": "assets/images/Phone-brands/lyf.png", "text": "LYF"},
  {"imageL": "assets/images/Phone-brands/micromax.png", "text": "Micromax"},
  {"imageL": "assets/images/Phone-brands/motorola.png", "text": "Motorola"},
  {"imageL": "assets/images/Phone-brands/nokia.png", "text": "Nokia"},
  {"imageL": "assets/images/Phone-brands/oneplus.png", "text": "OnePlus"},
  {"imageL": "assets/images/Phone-brands/oppo.png", "text": "Oppo"},
  {"imageL": "assets/images/Phone-brands/poco.jpg", "text": "Poco"},
  {"imageL": "assets/images/Phone-brands/samsung.png", "text": "Samsung"},
  {"imageL": "assets/images/Phone-brands/sony.png", "text": "Sony"},
  {"imageL": "assets/images/Phone-brands/vivo.png", "text": "Vivo"},
  {"imageL": "assets/images/Phone-brands/xiaomi.png", "text": "Xiaomi"},

];

