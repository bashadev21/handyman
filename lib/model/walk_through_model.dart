import 'package:booking_system_flutter/utils/images.dart';

class WalkThroughModel {
  String? url;
  double? percent;
  String? title;

  WalkThroughModel({this.url, this.percent, this.title});
}

List pages = [
  WalkThroughModel(url: walk_Img1, percent: 0.25, title: 'Browse the menu and order directly from the application'),
  WalkThroughModel(url: walk_Img2, percent: 0.50, title: 'Browse the menu and order directly from the application'),
  WalkThroughModel(url: walk_Img3, percent: 0.75, title: 'Browse the menu and order directly from the application'),
];
