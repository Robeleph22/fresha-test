import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:fresha/widgets/review_and_confirm_widget.dart';
  import 'package:fresha/widgets/select_professional_screen.dart';
  import 'package:get/get.dart';
  import 'package:intl/intl.dart';
  import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

  class SelectTimeScreen extends StatefulWidget {
    const SelectTimeScreen({super.key});

    @override
    State<SelectTimeScreen> createState() => _SelectTimeScreenState();
  }

  class _SelectTimeScreenState extends State<SelectTimeScreen> {
    DateTime selectedDate = DateTime.now();
    String selectedProfessional = "Any professional";
    late final List<DateTime> allDates;
    late final ScrollController _scrollController;
    String _currentMonthHeader = '';

    double _dateItemWidth = 0;
    final double _separatorWidth = 16.0;

    final List<String> timeSlots = [
      "12:00 PM",
      "12:15 PM",
      "12:30 PM",
      "12:45 PM",
      "1:00 PM",
      "1:15 PM",
      "1:30 PM",
      "1:45 PM",
      "1:45 PM",
      "1:45 PM",
      "1:45 PM",
      "1:45 PM",
      "1:45 PM",
    ];

    @override
    void initState() {
      super.initState();
      allDates = _generateNext90Days();
      _scrollController = ScrollController()..addListener(_scrollListener);

      if (allDates.isNotEmpty) {
        _currentMonthHeader = DateFormat.yMMMM().format(allDates.first);
      }
    }

    @override
    void dispose() {
      _scrollController.removeListener(_scrollListener);
      _scrollController.dispose();
      super.dispose();
    }

    void _showSelectProfessionalSheet() {
      showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        builder: (context) => SelectProfessionalScreen(
          scrollController: ModalScrollController.of(context),
          isBottomSheet: true,
        ),
      );
    }

    void _showCalendarSheet() {
      showCupertinoModalBottomSheet(
        context: context,
        expand: true,
        builder: (context) => _CalendarSheet(
          initialDate: selectedDate,
          onDateChanged: (newDate) {
            setState(() {
              selectedDate = newDate;
            });

            final index = allDates.indexWhere((d) => _isSameDay(d, newDate));
            if (index != -1) {
              final offset = index * (_dateItemWidth + _separatorWidth);
              _scrollController.animateTo(
                offset,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
            Navigator.pop(context);
          },
        ),
      );
    }

    void _scrollListener() {
      if (_dateItemWidth <= 0) return;
      int firstVisibleItemIndex =
          (_scrollController.offset / (_dateItemWidth + _separatorWidth)).round();
      if (firstVisibleItemIndex < 0) firstVisibleItemIndex = 0;

      if (firstVisibleItemIndex < allDates.length) {
        final newMonthHeader = DateFormat.yMMMM().format(
          allDates[firstVisibleItemIndex],
        );
        if (_currentMonthHeader != newMonthHeader) {
          setState(() {
            _currentMonthHeader = newMonthHeader;
          });
        }
      }
    }

    List<DateTime> _generateNext90Days() {
      DateTime today = DateTime.now();
      return List.generate(90, (index) => today.add(Duration(days: index)));
    }

    bool _isSameDay(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    @override
    Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final contentPadding = 16.0;
      final availableWidth = screenWidth - (contentPadding * 2);
      _dateItemWidth = (availableWidth - (_separatorWidth * 4)) / 5;

      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              pinned: true,
              elevation: 0,
              leading: const BackButton(color: Colors.black),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
              expandedHeight: 180.0,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final top = constraints.biggest.height;
                  final isCollapsed = top <= kToolbarHeight + 25;
                  return FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                      left: 60,
                      bottom: 16,
                      right: 60,
                    ),
                    centerTitle: false,
                    title: isCollapsed
                        ? const Text(
                            'Select time',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : null,
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 30),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'Select time',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: _showSelectProfessionalSheet,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  height: 40,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.deepPurple.withOpacity(
                                            0.3,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.person_4_outlined,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                      const Text(
                                        'Any professional',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: _showCalendarSheet,
                                child: Container(
                                  height: 40,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _DatePickerHeaderDelegate(
                height: 150,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        child: Text(
                          _currentMonthHeader,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          clipBehavior: Clip.none,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: allDates.length,
                          separatorBuilder: (_, __) =>
                              SizedBox(width: _separatorWidth),
                          itemBuilder: (context, index) {
                            final date = allDates[index];
                            final isSelected = _isSameDay(date, selectedDate);
                            final isDisabled = false; // Add logic if needed

                            return GestureDetector(
                              onTap: () {
                                if (!isDisabled) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                }
                              },
                              child: SizedBox(
                                width: _dateItemWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        gradient: isSelected && !isDisabled
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(
                                                    0xFF9C6ADE,
                                                  ), // Left side - light purple
                                                  Color(
                                                    0xFFB359D4,
                                                  ), // Middle - vibrant purple
                                                  Color(0xFFD160BF),
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              )
                                            : null,
                                        color: isDisabled
                                            ? Colors.grey.shade300
                                            : isSelected
                                                ? null
                                                : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.transparent
                                              : Colors.grey.shade400,
                                          width: 1,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          color: isDisabled
                                              ? Colors.grey
                                              : isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat.E().format(
                                        date,
                                      ), // Short day name
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isDisabled
                                            ? Colors.grey
                                            : Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final time = timeSlots[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => ReviewAndConfirmPage(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(time, style: const TextStyle(fontSize: 16)),
                    ),
                  );
                }, childCount: timeSlots.length),
              ),
            ),
          ],
        ),
      );
    }
  }

  class _DatePickerHeaderDelegate extends SliverPersistentHeaderDelegate {
    final double height;
    final Widget child;

    _DatePickerHeaderDelegate({required this.height, required this.child});

    @override
    Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
    ) {
      return SizedBox.expand(child: child);
    }

    @override
    double get maxExtent => height;

    @override
    double get minExtent => height;

    @override
    bool shouldRebuild(covariant _DatePickerHeaderDelegate oldDelegate) {
      return height != oldDelegate.height || child != oldDelegate.child;
    }
  }

  class _CalendarSheet extends StatefulWidget {
    final DateTime initialDate;
    final ValueChanged<DateTime> onDateChanged;

    const _CalendarSheet({
      required this.initialDate,
      required this.onDateChanged,
    });

    @override
    State<_CalendarSheet> createState() => _CalendarSheetState();
  }

  class _CalendarSheetState extends State<_CalendarSheet> {
    late DateTime _selectedDate;
    DateTime _currentMonth = DateTime.now();

    @override
    void initState() {
      super.initState();
      _selectedDate = widget.initialDate;
      _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
    }

    bool _isSameDay(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    @override
    Widget build(BuildContext context) {
      return Material(
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select date',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildMonthHeader(),
                const SizedBox(height: 12),
                _buildWeekdayHeader(),
                const SizedBox(height: 8),
                Expanded(child: _buildDayGrid()),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildMonthHeader() {
      final now = DateTime.now();
      final isCurrentMonth =
          _currentMonth.year == now.year && _currentMonth.month == now.month;

      return Row(
        children: [
          if (!isCurrentMonth)
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  _currentMonth = DateTime(
                    _currentMonth.year,
                    _currentMonth.month - 1,
                  );
                });
              },
            )
          else
            // Placeholder to balance the row
            const IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.transparent),
              onPressed: null,
            ),
          Expanded(
            child: Text(
              DateFormat.yMMMM().format(_currentMonth),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _currentMonth = DateTime(
                  _currentMonth.year,
                  _currentMonth.month + 1,
                );
              });
            },
          ),
        ],
      );
    }

    Widget _buildWeekdayHeader() {
      final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.map((d) {
          return Expanded(
            child: Center(
              child: Text(
                d,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    Widget _buildDayGrid() {
      final firstDayOfMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month,
        1,
      );
      final daysInMonth = DateUtils.getDaysInMonth(
        _currentMonth.year,
        _currentMonth.month,
      );
      final firstWeekday = firstDayOfMonth.weekday % 7;

      final List<Widget> dayWidgets = [];

      for (int i = 0; i < firstWeekday; i++) {
        dayWidgets.add(const SizedBox());
      }

      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(_currentMonth.year, _currentMonth.month, day);
        final isSelected = _isSameDay(date, _selectedDate);
        final isToday = _isSameDay(date, DateTime.now());

        dayWidgets.add(
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateChanged(date);
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF9C6ADE), // Left side - light purple
                          Color(0xFFB359D4), // Middle - vibrant purple
                          Color(0xFFD160BF),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
                color: isSelected ? null : Colors.transparent,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '$day',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  if (isToday && !isSelected)
                    Positioned(
                      bottom: 4,
                      child: Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }

      return GridView.count(
        crossAxisCount: 7,
        children: dayWidgets,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      );
    }
  }