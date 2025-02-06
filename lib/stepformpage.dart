import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_planner/allPages.dart';

import 'controller/travel_controller.dart';

class StepFormPage extends StatelessWidget {
  final TravelController controller = Get.put(TravelController());
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel Planner")),
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          DestinationStep(pageController),
          DateStep(pageController),
          CategoryStep(pageController),
          GuestStep(pageController),
          BreakfastStep(pageController),
        ],
      ),
    );
  }
}