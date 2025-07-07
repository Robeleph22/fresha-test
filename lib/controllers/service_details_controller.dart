// lib/controllers/service_details_controller.dart

    import 'package:flutter/material.dart';
    import 'package:get/get.dart';
    import 'dart:async';

    import '../model/service_options.dart';

    class ServiceDetailController extends GetxController {
      // --- UI State ---
      var currentImageIndex = 0.obs;
      var selectedOptionIndex = Rxn<int>(); // For single service selection
      var selectedOptionsIndices = <int>[].obs; // For multi-service selection
      var selectedCategoryIndex = 0.obs;
      var isScrolling =
          false.obs; // To prevent scroll listener from firing during programmatic scroll

      // --- Scroll Management ---
      late ScrollController scrollController;
      final List<GlobalKey> categoryKeys = [];

      @override
      void onInit() {
        super.onInit();
        // Initialize a GlobalKey for each category
        for (int i = 0; i < categories.length; i++) {
          categoryKeys.add(GlobalKey());
        }
        scrollController = ScrollController();
        scrollController.addListener(_onScroll);
      }

      @override
      void onClose() {
        scrollController.removeListener(_onScroll);
        scrollController.dispose();
        super.onClose();
      }

      // --- Methods ---

      void updateImageIndex(int index) {
        currentImageIndex.value = index;
      }

      // For the single-select view (`ServiceDetailWidget`)
      void selectOption(int index) {
        if (selectedOptionIndex.value == index) {
          selectedOptionIndex.value = null; // Deselect if tapped again
        } else {
          selectedOptionIndex.value = index;
        }
      }

      // For the multi-select view (`MultiSelectServiceDetailWidget`)
      void toggleMultiSelectOption(int originalIndex) {
        if (selectedOptionsIndices.contains(originalIndex)) {
          selectedOptionsIndices.remove(originalIndex);
        } else {
          selectedOptionsIndices.add(originalIndex);
        }
      }

      // Called when a user taps a category chip in the multi-select view
      void scrollToCategory(int index) async {
        if (isScrolling.value) return; // Prevent multiple scrolls at once

        isScrolling.value = true;
        selectedCategoryIndex.value = index;

        final key = categoryKeys[index];
        final context = key.currentContext;

        if (context != null) {
          await Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            alignment: 0, // Align to the top
          );
        }

        // Use a timer to reset the flag after the scroll animation is likely complete
        Timer(const Duration(milliseconds: 650), () {
          isScrolling.value = false;
        });
      }

      // Listener to update category chip based on scroll position
      void _onScroll() {
        if (isScrolling.value)
          return; // Don't update if we are programmatically scrolling

        // The offset of the pinned header (approximated)
        const headerOffset = 125.0;

        // Find the last category that is visible on screen
        for (int i = categoryKeys.length - 1; i >= 0; i--) {
          final key = categoryKeys[i];
          final context = key.currentContext;

          if (context != null) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final position = box.localToGlobal(Offset.zero);

            // If the top of the category section is at or above the pinned header
            if (position.dy <= headerOffset) {
              if (selectedCategoryIndex.value != i) {
                selectedCategoryIndex.value = i;
              }
              break; // Found the current category, no need to check further
            }
          }
        }
      }

      // --- MOCK DATA ---

      final List<String> categories = ['Manicure', 'Pedicure', 'Add-ons'];

      Map<String, List<ServiceOption>> get groupedServiceOptions {
        final map = <String, List<ServiceOption>>{};
        for (var option in serviceOptions) {
          (map[option.category] ??= []).add(option);
        }
        return map;
      }

      final List<String> images = [
        'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
        'https://images.unsplash.com/photo-1622288432454-24154e79aee2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80',
        'https://images.unsplash.com/photo-1599351431202-173d8332839a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
      ];

      final List<ServiceOption> serviceOptions = [
        // Manicures
        ServiceOption(
          category: 'Manicure',
          optionName: 'Classic Manicure',
          description:
              'A standard manicure including nail shaping, cuticle care, and a polish of your choice.',
          price: '500 Br',
          duration: '45 min',
          depositInfo: 'No deposit',
          inventory: ['Nail Polish(1)', 'Cuticle Oil(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'Gel Manicure',
          description:
              'A long-lasting manicure with gel polish that stays chip-free for weeks.',
          price: '800 Br',
          duration: '60 min',
          depositInfo: '100 Br deposit',
          inventory: ['Gel Polish(1)', 'UV Lamp(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'French Manicure',
          description:
              'A classic look with a natural pink or nude base and white tips.',
          price: '600 Br',
          duration: '55 min',
          depositInfo: 'No deposit',
          inventory: ['White Polish(1)', 'Nude Polish(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'Dip Powder Manicure',
          description:
              'A durable manicure where nails are dipped into colored powder.',
          price: '900 Br',
          duration: '70 min',
          depositInfo: '150 Br deposit',
          inventory: ['Dip Powder(1)', 'Activator(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'Vinylux Manicure',
          description:
              'A long-wear polish that hardens with natural light and lasts for a week.',
          price: '550 Br',
          duration: '50 min',
          depositInfo: 'No deposit',
          inventory: ['Vinylux Polish(1)', 'Vinylux Top Coat(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'Shellac Manicure',
          description:
              'A hybrid of gel and traditional polish, cured with a UV lamp for a glossy finish.',
          price: '850 Br',
          duration: '60 min',
          depositInfo: '100 Br deposit',
          inventory: ['Shellac Polish(1)', 'UV Lamp(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'Acrylic Overlay',
          description:
              'Application of acrylic directly onto the natural nail to add strength and durability.',
          price: '1000 Br',
          duration: '80 min',
          depositInfo: '200 Br deposit',
          inventory: ['Acrylic Powder(1)', 'Monomer Liquid(1)'],
        ),
        ServiceOption(
          category: 'Manicure',
          optionName: 'Paraffin Wax Manicure',
          description:
              'A classic manicure followed by a warm paraffin wax treatment to deeply moisturize the skin.',
          price: '700 Br',
          duration: '65 min',
          depositInfo: '50 Br deposit',
          inventory: ['Paraffin Wax(1)', 'Lotion(1)'],
        ),

        // Pedicures
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Spa Pedicure',
          description:
              'An indulgent treatment with an exfoliating scrub, hydrating mask, and relaxing massage for your feet.',
          price: '1200 Br',
          duration: '75 min',
          depositInfo: '200 Br deposit',
          inventory: ['Scrub(1)', 'Mask(1)', 'Lotion(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Classic Pedicure',
          description: 'A standard pedicure including nail shaping and polish.',
          price: '600 Br',
          duration: '50 min',
          depositInfo: 'No deposit',
          inventory: ['Nail Polish(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Gel Pedicure',
          description:
              'A long-lasting pedicure with gel polish that resists chipping.',
          price: '950 Br',
          duration: '65 min',
          depositInfo: '150 Br deposit',
          inventory: ['Gel Polish(1)', 'UV Lamp(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Hot Stone Pedicure',
          description:
              'A relaxing pedicure that includes a massage with hot stones.',
          price: '1500 Br',
          duration: '90 min',
          depositInfo: '300 Br deposit',
          inventory: ['Hot Stones(1)', 'Massage Oil(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'French Pedicure',
          description:
              'A classic look with a natural base and white tips for toes.',
          price: '700 Br',
          duration: '60 min',
          depositInfo: 'No deposit',
          inventory: ['White Polish(1)', 'Nude Polish(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Athletic Pedicure',
          description:
              'Designed for active feet, focusing on callus removal and a cooling massage.',
          price: '1100 Br',
          duration: '70 min',
          depositInfo: '150 Br deposit',
          inventory: ['Callus Remover(1)', 'Cooling Gel(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Paraffin Wax Pedicure',
          description:
              'A classic pedicure followed by a warm paraffin wax treatment for feet.',
          price: '850 Br',
          duration: '70 min',
          depositInfo: '100 Br deposit',
          inventory: ['Paraffin Wax(1)', 'Lotion(1)'],
        ),
        ServiceOption(
          category: 'Pedicure',
          optionName: 'Deluxe Pedicure',
          description:
              'The ultimate foot treatment including scrub, mask, massage, and paraffin wax.',
          price: '1800 Br',
          duration: '100 min',
          depositInfo: '400 Br deposit',
          inventory: ['Scrub(1)', 'Mask(1)', 'Paraffin Wax(1)'],
        ),

        // Add-ons
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Nail Art (per nail)',
          description: 'Add a custom design to one or more nails.',
          price: '150 Br',
          duration: '15 min',
          depositInfo: 'No deposit',
          inventory: ['Art Brush(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Paraffin Wax Treatment',
          description: 'A soothing and softening treatment for hands or feet.',
          price: '400 Br',
          duration: '20 min',
          depositInfo: 'No deposit',
          inventory: ['Paraffin Wax(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'French Tip Add-on',
          description: 'Add classic white tips to any manicure or pedicure.',
          price: '200 Br',
          duration: '15 min',
          depositInfo: 'No deposit',
          inventory: ['White Polish(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Gel Polish Removal',
          description: 'Safe and gentle removal of old gel polish.',
          price: '250 Br',
          duration: '20 min',
          depositInfo: 'No deposit',
          inventory: ['Acetone(1)', 'Nail Foils(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Hand Massage (10 min)',
          description: 'A relaxing 10-minute massage for your hands.',
          price: '300 Br',
          duration: '10 min',
          depositInfo: 'No deposit',
          inventory: ['Lotion(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Callus Removal',
          description: 'Effective removal of tough calluses for smoother feet.',
          price: '350 Br',
          duration: '15 min',
          depositInfo: 'No deposit',
          inventory: ['Callus Remover(1)', 'Pumice Stone(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Nail Repair',
          description: 'Fix a broken or chipped nail.',
          price: '100 Br',
          duration: '10 min',
          depositInfo: 'No deposit',
          inventory: ['Nail Glue(1)', 'Nail File(1)'],
        ),
        ServiceOption(
          category: 'Add-ons',
          optionName: 'Foot Massage (10 min)',
          description: 'A relaxing 10-minute massage for your feet.',
          price: '350 Br',
          duration: '10 min',
          depositInfo: 'No deposit',
          inventory: ['Massage Oil(1)'],
        ),
      ];
    }