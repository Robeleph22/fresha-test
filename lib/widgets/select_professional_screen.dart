import 'package:flutter/material.dart';
  import 'package:fresha/widgets/select_time_screen.dart';
  import 'package:get/get.dart';

  class SelectProfessionalScreen extends StatefulWidget {
    final ScrollController? scrollController;
    final bool isBottomSheet;

    const SelectProfessionalScreen({
      Key? key,
      this.scrollController,
      this.isBottomSheet = false,
    }) : super(key: key);

    @override
    State<SelectProfessionalScreen> createState() =>
        _SelectProfessionalScreenState();
  }

  class _SelectProfessionalScreenState extends State<SelectProfessionalScreen> {
    int selectedIndex = 0;

    final List<Map<String, String>> professionals = [
      {"name": "Abdul 🇱🇧", "initial": "A", "role": "Barber", "rating": "4.7"},
      {"name": "Taheer 🇾🇪", "initial": "T", "role": "Barber", "rating": "4.8"},
      {"name": "Nerlin 🇵🇭", "initial": "N", "role": "Manicurist", "rating": "5.0"},
      {"name": "John 🇺🇸", "initial": "J", "role": "Stylist", "rating": "4.9"},
      {"name": "Maria 🇪🇸", "initial": "M", "role": "Esthetician", "rating": "4.6"},
      {"name": "Chen 🇨🇳", "initial": "C", "role": "Barber", "rating": "4.8"},
      {"name": "Fatima 🇪🇬", "initial": "F", "role": "Manicurist", "rating": "4.9"},
      {"name": "Ivan 🇷🇺", "initial": "I", "role": "Stylist", "rating": "4.5"},
      {"name": "Yuki 🇯🇵", "initial": "Y", "role": "Barber", "rating": "5.0"},
      {"name": "Sofia 🇮🇹", "initial": "S", "role": "Esthetician", "rating": "4.7"},
      {"name": "Liam 🇮🇪", "initial": "L", "role": "Manicurist", "rating": "4.8"},
      {"name": "Chloe 🇫🇷", "initial": "C", "role": "Stylist", "rating": "4.9"},
      {"name": "Mohammed 🇸🇦", "initial": "M", "role": "Barber", "rating": "4.6"},
    ];

    void navigateToSelectTimeScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelectTimeScreen()),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 120,
              pinned: true,
              elevation: 0,
              surfaceTintColor: Colors.white,
              automaticallyImplyLeading: !widget.isBottomSheet,
              leading: widget.isBottomSheet
                  ? null
                  : const BackButton(color: Colors.black),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final bool isCollapsed =
                      constraints.biggest.height <= kToolbarHeight + 10;

                  return FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(
                        left: isCollapsed ? (widget.isBottomSheet ? 16 : 48) : 16,
                        bottom: isCollapsed ? 16 : 20),
                    centerTitle: false,
                    title: Text(
                      'Select professional',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isCollapsed ? 18 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final isSelected = selectedIndex == index;

                    Widget content;
                    if (index == 0) {
                      content = const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group, size: 28),
                          SizedBox(height: 8),
                          Text(
                            "Any team member",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Maximum availability",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else {
                      final proIndex = index - 1;
                      final pro = professionals[proIndex];
                      content = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey.shade200,
                            child: Text(
                              pro["initial"]!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pro["rating"]!,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.star, size: 16),
                            ],
                          ),
                          Text(
                            pro["name"]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            pro["role"]!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        if (widget.isBottomSheet) {
                          Navigator.pop(context);
                        } else {
                          setState(() => selectedIndex = index);
                          Get.to(() => const SelectTimeScreen(),
                              transition: Transition.rightToLeft);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(isSelected ? 2 : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: isSelected
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF9C6ADE),
                                    Color(0xFFB359D4),
                                    Color(0xFFD160BF),
                                  ],
                                )
                              : null,
                        ),
                        child: Container(
                          padding: index == 0
                              ? const EdgeInsets.all(10)
                              : const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: Colors.grey.shade300,
                                    width: 2,
                                  ),
                          ),
                          child: content,
                        ),
                      ),
                    );
                  },
                  childCount: professionals.length + 1,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 160,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }