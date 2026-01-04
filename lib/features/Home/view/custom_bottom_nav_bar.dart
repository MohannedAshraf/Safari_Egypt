// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:safari_egypt_app/core/theme/app_theme.dart';
import 'package:safari_egypt_app/features/Home/view/home_screen.dart';
import 'package:safari_egypt_app/features/trips/trips_screen.dart';
import 'package:safari_egypt_app/features/booking/booking_screen.dart';
import 'package:safari_egypt_app/features/profile/profile_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int initialIndex; // قيمة البداية للـ BottomNavBar
  const CustomBottomNavBar({super.key, this.initialIndex = 0});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _currentIndex; // هنا هنسند القيمة من initialIndex

  final List<Widget> _pages = const [
    HomeScreen(),
    TripsScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // استخدام القيمة اللي جت من بره
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 16),
        unselectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined, size: 30),
            activeIcon: Icon(Icons.map, size: 30),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined, size: 30),
            activeIcon: Icon(Icons.book, size: 30),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 30),
            activeIcon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
