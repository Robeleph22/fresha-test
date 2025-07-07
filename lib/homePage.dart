// lib/homePage.dart

import 'package:flutter/material.dart';
import 'package:fresha/widgets/booking_type_selctions_widget.dart';
import 'package:get/get.dart';

import 'controllers/service_details_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller.
    Get.put(ServiceDetailController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Booking'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Get.bottomSheet(
              const BookingTypeSelectionWidget(),
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            );
          },
          child: const Text('Book Now'),
        ),
      ),
    );
  }
}
