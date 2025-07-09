// lib/homePage.dart

        import 'package:flutter/material.dart';
        import 'package:fresha/widgets/booking_type_selctions_widget.dart';
        import 'package:get/get.dart';
        import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          expand: true,
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: const Text('Cupertino Modal'),
                            ),
                            body: const Center(
                              child: Text('This is an expanded Cupertino modal.'),
                            ),
                          ),
                        );
                      },
                      child: const Text('Show Cupertino Modal'),
                    ),
                  ],
                ),
              ),
            );
          }
        }