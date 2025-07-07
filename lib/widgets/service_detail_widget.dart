// lib/widgets/service_detail_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/service_details_controller.dart';
import 'service_options_widget.dart';

class ServiceDetailWidget extends StatelessWidget {
  const ServiceDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceDetailController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSlider(context, controller),
                    _buildServiceInfo(context),
                    _buildAboutSection(),
                    _buildIncludedSection(context, controller),
                  ],
                ),
              ),
            ),
            _buildBookButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider(
    BuildContext context,
    ServiceDetailController controller,
  ) {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: PageView.builder(
            itemCount: controller.images.length,
            onPageChanged: (index) => controller.updateImageIndex(index),
            itemBuilder: (context, index) {
              return Image.network(
                controller.images[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              );
            },
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentImageIndex.value == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Luxury Manicure & Pedicure',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              const Text('4.9', style: TextStyle(fontSize: 14)),
              Text(
                ' (128 Reviews)',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(width: 10),
              Text(
                '•',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.access_time, size: 20, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '45-75 min',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '500 Br - 1200 Br',
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About the Service',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Indulge in our premium service, designed to pamper and beautify. We use only high-quality products to ensure a lasting and flawless finish. Choose from our range of options to find the perfect treatment for you.',
            style: TextStyle(color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedSection(
    BuildContext context,
    ServiceDetailController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 24, bottom: 8),
          child: Text(
            'Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: controller.serviceOptions.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.selectOption(index),
                child: Obx(
                  () => ServiceOptionsWidget(
                    option: controller.serviceOptions[index],
                    isSelected: controller.selectedOptionIndex.value == index,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(top: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.snackbar(
            'Booking',
            'Booking action goes here!',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9C6ADE), Color(0xFFB359D4), Color(0xFFD160BF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          height: 56,
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text(
            "Next",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}