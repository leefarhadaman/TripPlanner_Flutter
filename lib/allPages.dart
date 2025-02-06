// Step 1: Destination
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trip_planner/controller/travel_controller.dart';

class DestinationStep extends StatelessWidget {
  final PageController pageController;
  DestinationStep(this.pageController);
  final TravelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Enter Destination"),
          onChanged: (value) => controller.destination.value = value,
        ),
        ElevatedButton(
          onPressed: () => pageController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
          child: Text("Next"),
        )
      ],
    );
  }
}

// Step 2: Date Selection
class DateStep extends StatelessWidget {
  final PageController pageController;
  DateStep(this.pageController);
  final TravelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Check-in Date Picker
        ElevatedButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              controller.checkinDate.value = DateFormat('yyyy-MM-dd').format(picked);
              // Reset checkout date if it's before check-in
              if (controller.checkoutDate.value.isNotEmpty &&
                  DateTime.parse(controller.checkoutDate.value).isBefore(picked)) {
                controller.checkoutDate.value = '';
              }
            }
          },
          child: Obx(() => Text(
            controller.checkinDate.value.isEmpty
                ? "Select Check-in Date"
                : "Check-in: ${controller.checkinDate.value}",
          ),
          ),
        ),

        SizedBox(height: 16),

        // Check-out Date Picker
        ElevatedButton(
          onPressed: () async {
            if (controller.checkinDate.value.isEmpty) {
              Get.snackbar("Error", "Please select a check-in date first.");
              return;
            }

            // Parse checkinDate and ensure it is valid
            DateTime checkin = DateTime.parse(controller.checkinDate.value);
            DateTime initialCheckout = checkin.add(Duration(days: 1));

            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: initialCheckout.isBefore(DateTime.now())
                  ? DateTime.now()  // Ensure the initial date is today or later
                  : initialCheckout,  // Set to checkin + 1 day
              firstDate: initialCheckout,  // Checkout date must be after check-in
              lastDate: DateTime(2100),
            );

            if (picked != null) {
              controller.checkoutDate.value = DateFormat('yyyy-MM-dd').format(picked);
            }
          },
          child: Obx(() => Text(
            controller.checkoutDate.value.isEmpty
                ? "Select Check-out Date"
                : "Check-out: ${controller.checkoutDate.value}",
          ),
          ),
        ),

        SizedBox(height: 16),

        // Next Button
        ElevatedButton(
          onPressed: () {
            if (controller.checkinDate.value.isEmpty || controller.checkoutDate.value.isEmpty) {
              Get.snackbar("Error", "Please select both check-in and check-out dates.");
            } else {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text("Next"),
        ),
      ],
    );
  }
}

// Step 3: Category Selection
class CategoryStep extends StatelessWidget {
  final PageController pageController;
  CategoryStep(this.pageController);
  final TravelController controller = Get.find();

  final List<String> categories = ["Adventure", "Cultural", "Historical"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...categories.map((cat) => Obx(() => RadioListTile(
          title: Text(cat),
          value: cat,
          groupValue: controller.category.value,
          onChanged: (value) => controller.category.value = value!,
        ))).toList(),
        ElevatedButton(
          onPressed: () => pageController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
          child: Text("Next"),
        ),
      ],
    );
  }
}

// Step 4: Guest Type Selection
class GuestStep extends StatelessWidget {
  final PageController pageController;
  GuestStep(this.pageController);
  final TravelController controller = Get.find();

  final List<String> guests = ["Family", "Friends", "Solo", "Duo"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...guests.map((guest) => Obx(() => RadioListTile(
          title: Text(guest),
          value: guest,
          groupValue: controller.guestType.value,
          onChanged: (value) => controller.guestType.value = value!,
        ))).toList(),
        ElevatedButton(
          onPressed: () => pageController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
          child: Text("Next"),
        ),
      ],
    );
  }
}


// Step 5: Include Breakfast Option
class BreakfastStep extends StatelessWidget {
  final PageController pageController;
  BreakfastStep(this.pageController);
  final TravelController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => SwitchListTile(
          title: Text("Include Breakfast"),
          value: controller.includeBreakfast.value,
          onChanged: (value) => controller.includeBreakfast.value = value,
        )),
        ElevatedButton(
          onPressed: () => controller.submitForm(),
          child: Text("Submit"),
        )
      ],
    );
  }
}
