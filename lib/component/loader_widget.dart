import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/widgets/spin_kit_chasing_dots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> with TickerProviderStateMixin {
  late AnimationController controller;
  late final Animation<double> _animation = CurvedAnimation(
    parent: controller,
    curve: Curves.linearToEaseOut,
  );

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(color: primaryColor);
  }
}
