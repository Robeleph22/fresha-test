// lib/widgets/booking_type_selctions_widget.dart
    // lib/widgets/booking_type_selection_widget.dart

    import 'package:flutter/material.dart';
    import 'package:fresha/widgets/service_detail_widget.dart';
    import 'package:get/get.dart';

    import '../controllers/service_details_controller.dart';
    import '../homePage.dart';
    import 'multi_select_service_detail_widget.dart';

    class BookingTypeSelectionWidget extends StatelessWidget {
      const BookingTypeSelectionWidget({super.key});

      @override
      Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Booking Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _buildBookingOptionCard(
                context: context,
                icon: Icons.person_outline,
                title: 'Book an Appointment',
                subtitle: 'For a single person service',
                onTap: () {
                  Get.back(); // Close this sheet first
                  Get.bottomSheet(
                    const ServiceDetailWidget(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildBookingOptionCard(
                context: context,
                icon: Icons.group_outlined,
                title: 'Group Booking',
                subtitle: 'For multiple services or people',
                onTap: () {
                  Get.back(); // Close this sheet first
                  final controller = Get.find<ServiceDetailController>();
                  controller.selectedOptionsIndices.clear();
                  controller.scrollToCategory(0); // Reset to the first category
                  Get.bottomSheet(
                    const MultiSelectServiceDetailWidget(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }

      Widget _buildBookingOptionCard({
        required BuildContext context,
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(icon, size: 32, color: Theme.of(context).primaryColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        );
      }
    }