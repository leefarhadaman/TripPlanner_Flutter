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
    return Padding(
      padding: const EdgeInsets.all(16.0),  // Adds padding around the entire Column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Aligns text to the left
        children: [
          Text(
            'Where are you going?',  // Updated text to make it more engaging
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),  // Adds spacing between the title and TextField
          TextField(
            decoration: InputDecoration(
              labelText: 'Enter Destination',
              hintText: 'E.g., Paris, New York',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),  // Rounded borders
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),  // Adjusted padding for text inside the field
              filled: true,
              fillColor: Colors.grey[200],  // Light grey background for the text field
            ),
            onChanged: (value) => controller.destination.value = value,
          ),
          SizedBox(height: 20),  // Adds space between TextField and ElevatedButton
          ElevatedButton(
            onPressed: () => pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,  // Button color
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),  // Adjusts button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),  // Rounded corners for the button
              ),
            ),
          ),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),  // Add padding around the entire column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Align all items to the left
        children: [
          // Check-in Date Picker
          ElevatedButton.icon(
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
            icon: Icon(Icons.calendar_today, color: Colors.white),  // Added calendar icon
            label: Obx(() => Text(
              controller.checkinDate.value.isEmpty
                  ? "Select Check-in Date"
                  : "Check-in: ${controller.checkinDate.value}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,  // Button color
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),  // Increased padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),  // Rounded corners
              ),
            ),
          ),

          SizedBox(height: 16),  // Adds space between check-in and check-out date picker

          // Check-out Date Picker
          ElevatedButton.icon(
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
            icon: Icon(Icons.calendar_today, color: Colors.white),  // Added calendar icon
            label: Obx(() => Text(
              controller.checkoutDate.value.isEmpty
                  ? "Select Check-out Date"
                  : "Check-out: ${controller.checkoutDate.value}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,  // Button color
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),  // Increased padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),  // Rounded corners
              ),
            ),
          ),

          SizedBox(height: 32),  // Adds space before the 'Next' button

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
            child: Text(
              "Next",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,  // Button color
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),  // Increased padding for bigger button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),  // Rounded corners
              ),
            ),
          ),
        ],
      ),
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
