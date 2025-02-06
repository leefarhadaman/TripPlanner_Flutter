import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trip_planner/iteneryPage.dart';  // Make sure this import is correct

class TravelController extends GetxController {
  var destination = ''.obs;
  var checkinDate = ''.obs;
  var checkoutDate = ''.obs;
  var category = ''.obs;
  var guestType = ''.obs;
  var includeBreakfast = false.obs;

  // Method to submit form data and get itinerary
  Future<void> submitForm() async {
    if (destination.isEmpty ||
        checkinDate.isEmpty ||
        checkoutDate.isEmpty ||
        category.isEmpty ||
        guestType.isEmpty) {
      Get.snackbar("Error", "Please complete all steps before submitting.");
      return;
    }

    // Prepare request data
    Map<String, dynamic> requestData = {
      "destination": destination.value,
      "checkInDate": checkinDate.value,
      "checkOutDate": checkoutDate.value,
      "category": category.value,
      "guests": guestType.value,
      "breakfast": includeBreakfast.value,
    };

    // Make the HTTP POST request to generate itinerary
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/generate-itinerary'), // Replace with your actual backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // Parse the response data
        final itineraryData = jsonDecode(response.body);

        // Navigate to Itinerary Page and pass the response data
        Get.to(() => ItineraryPage(itineraryData: itineraryData));
      } else {
        // Handle the error response
        Get.snackbar("Error", "Failed to generate itinerary. Please try again.");
      }
    } catch (e) {
      // Handle network or other errors
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
