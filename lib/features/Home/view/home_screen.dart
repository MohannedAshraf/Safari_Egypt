// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safari_egypt_app/core/app_colors.dart';
import 'package:safari_egypt_app/core/app_images.dart';
import 'package:safari_egypt_app/features/Home/view/home_drawer.dart';
import 'package:safari_egypt_app/features/Home/view/search_screen.dart';
import 'package:safari_egypt_app/features/Notification/view/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;
  late PageController _pageController;
  Timer? _carouselTimer;

  final List<String> carousel = [
    AppImages.onboarding1,
    AppImages.onboarding2,
    AppImages.onboarding3,
    AppImages.onboarding4,
  ];

  final List<Map<String, String>> categories = [
    {'title': 'Tours', 'icon': '🦁'},
    {'title': 'Hotels', 'icon': '🏨'},
    {'title': 'Flights', 'icon': '✈️'},
    {'title': 'Cars', 'icon': '🚗'},
  ];

  final List<Map<String, String>> trips = List.generate(
    6,
    (i) => {
      'image': AppImages.onboarding1,
      'title': 'Trip ${i + 1}',
      'location': 'Cairo',
      'price': '\$${100 + i * 20}',
      'discount': '${10 + i}%',
    },
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _carouselIndex);

    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_carouselIndex < carousel.length - 1) {
        _carouselIndex++;
      } else {
        _carouselIndex = 0;
      }
      _pageController.animateToPage(
        _carouselIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLarge = width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(query: value),
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search destinations, hotels...',
                  suffixIcon: const Icon(Icons.search),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Carousel
            SizedBox(
              height: isLarge ? 260 : 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: carousel.length,
                onPageChanged: (i) => setState(() => _carouselIndex = i),
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          carousel[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 8),

            // Carousel indicators
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  carousel.length,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _carouselIndex == i ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color:
                          _carouselIndex == i
                              ? AppColors.primaryColor
                              : Colors.grey[400],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Categories
            SizedBox(
              height: 78,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return Container(
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${c['icon']}\n${c['title']}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: categories.length,
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Best Trip',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            SizedBox(
              height: 220,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => _TripCard(
                      data: trips[index],
                      width: isLarge ? 260 : 180,
                    ),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: trips.length,
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Recommendation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            SizedBox(
              height: 220,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => _TripCard(
                      data: trips[index],
                      width: isLarge ? 260 : 180,
                      compact: true,
                    ),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: trips.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final Map<String, String> data;
  final double width;
  final bool compact;

  const _TripCard({
    required this.data,
    required this.width,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(data['image']!, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '-${data['discount']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.redAccent,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data['location']!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${data['price']!}/day',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
