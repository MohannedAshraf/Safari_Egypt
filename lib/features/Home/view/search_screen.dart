// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:safari_egypt_app/core/app_colors.dart';
import 'package:safari_egypt_app/core/app_images.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required String query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  // بيانات مؤقتة للرحلات
  final List<Map<String, String>> trips = [
    {
      'image': AppImages.onboarding1,
      'title': 'Trip Cairo',
      'description': 'Explore the ancient pyramids and city life',
      'price': '120',
    },
    {
      'image': AppImages.onboarding2,
      'title': 'Trip Alexandria',
      'description': 'Relax by the Mediterranean sea',
      'price': '150',
    },
    {
      'image': AppImages.onboarding3,
      'title': 'Trip Luxor',
      'description': 'Discover temples and the Nile',
      'price': '200',
    },
    {
      'image': AppImages.onboarding4,
      'title': 'Trip Aswan',
      'description': 'Enjoy a serene Nile experience',
      'price': '180',
    },
    {
      'image': AppImages.onboarding1,
      'title': 'Trip Giza',
      'description': 'Visit the iconic Sphinx',
      'price': '130',
    },
    {
      'image': AppImages.onboarding2,
      'title': 'Trip Sharm',
      'description': 'Dive into the Red Sea adventures',
      'price': '210',
    },
  ];

  List<Map<String, String>> filteredTrips = [];

  @override
  void initState() {
    super.initState();
    filteredTrips = trips;
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredTrips =
          trips
              .where((trip) => trip['title']!.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search trips...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                isDense: true,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child:
                  filteredTrips.isEmpty
                      ? const Center(child: Text('No results found'))
                      : ListView.builder(
                        itemCount: 5000,
                        itemBuilder: (context, index) {
                          final trip =
                              filteredTrips[index % filteredTrips.length];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Card(
                              color: Colors.white, // شفاف
                              elevation: 0,
                              clipBehavior: Clip.hardEdge,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(
                                      trip['image']!,
                                      width: 150,
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trip['title']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          trip['description']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${trip['price']} EGP',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
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
    );
  }
}
