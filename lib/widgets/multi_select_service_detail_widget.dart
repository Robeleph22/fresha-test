import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/service_details_controller.dart';
import '../model/service_options.dart';
import 'select_professional_screen.dart';

class MultiSelectServiceDetailWidget extends StatefulWidget {
  const MultiSelectServiceDetailWidget({super.key});

  @override
  State<MultiSelectServiceDetailWidget> createState() =>
      _MultiSelectServiceDetailWidgetState();
}

class _MultiSelectServiceDetailWidgetState
    extends State<MultiSelectServiceDetailWidget> {
  final DraggableScrollableController _scrollableController =
  DraggableScrollableController();
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _scrollableController.addListener(_onScroll);
  }

  void _onScroll() {
    final isFull = _scrollableController.size >= 1.0;
    if (isFull != _isFullScreen) {
      setState(() {
        _isFullScreen = isFull;
      });
    }
  }

  @override
  void dispose() {
    _scrollableController.removeListener(_onScroll);
    _scrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceDetailController>();
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.only(top: _isFullScreen ? 0 : topPadding + 30),
      child: DraggableScrollableSheet(
        controller: _scrollableController,
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: _isFullScreen ? Radius.zero : const Radius.circular(24),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: _isFullScreen ? Radius.zero : const Radius.circular(24),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      top: _isFullScreen,
                      bottom: false,
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 550.0,
                            pinned: true,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            automaticallyImplyLeading: false,
                            title: _isFullScreen ? const Text('') : null,
                            toolbarHeight: _isFullScreen ? 70 : kToolbarHeight,
                            leading: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(-1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                              child: _isFullScreen
                                  ? SafeArea(
                                key: const ValueKey('back-button'),
                                minimum: const EdgeInsets.only(
                                    left: 16, top: 15),
                                child: InkWell(
                                  onTap: () => Get.back(),
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.arrow_back,
                                        size: 20, color: Colors.black),
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink(
                                  key: ValueKey('back-button-hidden')),
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      _buildImageSlider(context, controller),
                                      _buildServiceInfo(context),
                                      _buildAboutSection(),
                                    ],
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: AnimatedSwitcher(
                                      duration:
                                      const Duration(milliseconds: 300),
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: !_isFullScreen
                                          ? InkWell(
                                        key: const ValueKey('close-icon'),
                                        onTap: () => Get.back(),
                                        child: Container(
                                          padding:
                                          const EdgeInsets.all(8),
                                          decoration:
                                          const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.close,
                                              color: Colors.black),
                                        ),
                                      )
                                          : const SizedBox.shrink(
                                          key: ValueKey(
                                              'close-icon-hidden')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverPersistentHeader(
                            delegate: _SliverCategoryHeaderDelegate(
                              child: _buildCategorySelector(controller),
                            ),
                            pinned: true,
                          ),
                          ..._buildServiceLists(controller),
                        ],
                      ),
                    ),
                  ),
                  _buildBookButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildServiceLists(ServiceDetailController controller) {
    final groupedOptions = controller.groupedServiceOptions;
    final List<Widget> slivers = [];

    for (int i = 0; i < controller.categories.length; i++) {
      final category = controller.categories[i];
      final options = groupedOptions[category] ?? [];

      slivers.add(
        SliverToBoxAdapter(
          child: Container(
            key: controller.categoryKeys[i],
            padding: const EdgeInsets.only(left: 16, top: 24, bottom: 8),
            child: Text(
              category,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final option = options[index];
            return _buildServiceListItem(controller, option);
          }, childCount: options.length),
        ),
      );
    }
    return slivers;
  }

  Widget _buildServiceListItem(
      ServiceDetailController controller,
      ServiceOption option,
      ) {
    final originalIndex = controller.serviceOptions.indexOf(option);

    return Obx(() {
      final isSelected = controller.selectedOptionsIndices.contains(
        originalIndex,
      );
      return ListTile(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          option.optionName,
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                option.duration,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(width: 8),
              Text(
                option.price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: isSelected
              ? Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF9C6ADE),
                  Color(0xFFB359D4),
                  Color(0xFFD160BF),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
            child:
            const Icon(Icons.check, color: Colors.white, size: 20),
          )
              : Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.add, color: Colors.black, size: 20),
          ),
          onPressed: () => controller.toggleMultiSelectOption(originalIndex),
        ),
        onTap: () => controller.toggleMultiSelectOption(originalIndex),
      );
    });
  }

  Widget _buildCategorySelector(ServiceDetailController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.4), width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              'Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected =
                      controller.selectedCategoryIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.scrollToCategory(index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                          colors: [
                            Color(0xFF9C6ADE),
                            Color(0xFFB359D4),
                            Color(0xFFD160BF),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                            : null,
                        color: isSelected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        controller.categories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
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
            'Group Booking',
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
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Select multiple services',
            style: TextStyle(
              fontSize: 18,
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
            'About Group Booking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Select all the services you need for your group. You can mix and match from different categories to create the perfect package for everyone.',
            style: TextStyle(color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
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
          Get.bottomSheet(
            const SelectProfessionalScreen(),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
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
            "Confirm Services",
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

class _SliverCategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverCategoryHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 125;

  @override
  double get minExtent => 125;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
