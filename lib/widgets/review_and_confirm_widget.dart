import 'package:flutter/material.dart';

                                class ReviewAndConfirmPage extends StatelessWidget {
                                  @override
                                  Widget build(BuildContext context) {
                                    return Scaffold(
                                      backgroundColor: Colors.white,
                                      body: CustomScrollView(
                                        slivers: [
                                          SliverAppBar(
                                            backgroundColor: Colors.white,
                                            expandedHeight: 120,
                                            pinned: true,
                                            elevation: 0,
                                            surfaceTintColor: Colors.white,
                                            automaticallyImplyLeading: true,
                                            foregroundColor: Colors.black,
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
                                                    constraints.biggest.height <= kToolbarHeight + 25;

                                                return FlexibleSpaceBar(
                                                  titlePadding: const EdgeInsets.only(
                                                    left: 60,
                                                    bottom: 16,
                                                    right: 60,
                                                  ),
                                                  centerTitle: false,
                                                  title: isCollapsed
                                                      ? const Text(
                                                          'Review and confirm',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )
                                                      : null,
                                                  background: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: const [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 16, bottom: 20),
                                                        child: Text(
                                                          'Review and confirm',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SliverToBoxAdapter(
                                            child: SingleChildScrollView(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 25),
                                                  ListTile(
                                                    contentPadding: EdgeInsets.zero,
                                                    leading: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.network(
                                                        'https://images.pexels.com/photos/705255/pexels-photo-705255.jpeg',
                                                        // Replace with your image asset
                                                        width: 60,
                                                        height: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    title: const Text(
                                                      'Style H Gents Salon',
                                                      style:
                                                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    ),
                                                    subtitle: Column(
                                                      children: [
                                                        Row(
                                                          children: const [
                                                            Text('5.0'),
                                                            SizedBox(width: 4),
                                                            Icon(Icons.star, size: 16, color: Colors.black),
                                                            Icon(Icons.star, size: 16, color: Colors.black),
                                                            Icon(Icons.star, size: 16, color: Colors.black),
                                                            Icon(Icons.star, size: 16, color: Colors.black),
                                                            Icon(Icons.star, size: 16, color: Colors.black),
                                                            SizedBox(width: 4),
                                                            Text('(349)'),
                                                          ],
                                                        ),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            'Inside Marina view Hotel Appartments, Dubai Marina, Dubai',
                                                            style: TextStyle(
                                                              color: Colors.grey[600],
                                                              fontSize: 14,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_today_outlined,
                                                        size: 16,
                                                        color: Colors.grey.shade500,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Thu, Jul 3, 2025',
                                                        style: TextStyle(
                                                          color: Colors.grey.shade500,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.access_time,
                                                          size: 16, color: Colors.grey.shade500),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        '4:30 PM–5:30 PM (1 hr duration)',
                                                        style: TextStyle(
                                                          color: Colors.grey.shade500,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: const [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Style H Deal Bronze',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.normal,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          Text(
                                                            '1 hr',
                                                            style: TextStyle(color: Colors.grey, fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        'AED 350',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.normal, fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Divider(height: 32),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: const [
                                                          Text(
                                                            'Total',
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Pay now',
                                                            style: TextStyle(
                                                              color: Colors.green,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Pay at venue',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: const [
                                                          Text(
                                                            'AED 350',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            'AED 0',
                                                            style: TextStyle(
                                                              color: Colors.green,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            'AED 350',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Divider(height: 25),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Discount code',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.normal, fontSize: 16),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {},
                                                        style: TextButton.styleFrom(
                                                          backgroundColor: Colors.transparent,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(30),
                                                            side: BorderSide(color: Colors.grey.shade300),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 4,
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Add',
                                                          style: TextStyle(color: Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),
                                                  const Text(
                                                    'Payment method',
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(color: Colors.grey.shade300),
                                                        ),
                                                        child: Center(child: Icon(Icons.storefront_outlined)),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Pay at venue',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black.withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 24),
                                                  const Text(
                                                    'Important info',
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const Text(
                                                    'Welcome to style h barber shop 💈 we have 20% discount',
                                                  ),
                                                  const SizedBox(height: 24),
                                                  const Text(
                                                    'Notes',
                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  TextField(
                                                    maxLines: 3,
                                                    textAlignVertical: TextAlignVertical.top,
                                                    decoration: InputDecoration(
                                                      hintText: 'Add any notes or special requests',
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(color: Colors.grey.shade300),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: BorderSide(
                                                            color: Colors.deepPurple.shade500), // dark purple
                                                      ),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 50),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 60),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      bottomNavigationBar: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(top: BorderSide(color: Colors.grey.shade300)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('AED 350\n1 service • 1 hr'),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 32,
                                                  vertical: 14,
                                                ),
                                              ),
                                              child: const Text(
                                                'Confirm',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                }