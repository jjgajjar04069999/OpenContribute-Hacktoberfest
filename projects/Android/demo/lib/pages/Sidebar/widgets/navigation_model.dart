import 'package:flutter/material.dart';

// ignore: camel_case_types
class Navigation_model {
  String title;
  IconData icon;
  String path;
  Function onTapF;
  Navigation_model({this.title, this.icon, this.path});
}

// ignore: non_constant_identifier_names
List<Navigation_model> navigation_item = [
  Navigation_model(
    title: "Home",
    icon: Icons.home_outlined,
    path: "/homescreen",

  ),
  Navigation_model(
    title: "Your usage",
    icon: Icons.data_usage_outlined,
    path: '/usagePage',
  ),
  Navigation_model(
    title: "My Vehicles",
    icon: Icons.directions_car_sharp,
    path: '/myVehicles',
  ),
  Navigation_model(
    title: "Booking Status",
    icon: Icons.room_service,
    path: "/bookingStatus",
  ),
  Navigation_model(
    title: "Specialized Mechanics",
    icon: Icons.handyman_outlined,
  ),
  Navigation_model(
    title: "ShopPage",
    icon: Icons.shop_outlined,
    path: '/shopPage',
  ),
  Navigation_model(
    title: "Settings",
    icon: Icons.settings,
    path: '/loading',
  ),
  Navigation_model(
    title: "Sign Out",
    icon: Icons.logout,
    path: "/register",
  ),
  Navigation_model(
    title: "Refer & Invite",
    icon: Icons.share_outlined,
    path: '/referEarnPage',
  ),
  Navigation_model(
    title: "About Us",
    icon: Icons.people,
    path: '/aboutUs',
  ),
];
