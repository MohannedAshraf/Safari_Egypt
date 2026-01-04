import 'package:flutter/material.dart';
import 'package:safari_egypt_app/core/app_images.dart';
import 'package:safari_egypt_app/features/Home/view/about_us_screen.dart';
import 'package:safari_egypt_app/features/Home/view/custom_bottom_nav_bar.dart';
import 'package:safari_egypt_app/features/Home/view/help_screen.dart';
import 'package:safari_egypt_app/features/Setting/View/settings_screen.dart';
import 'package:safari_egypt_app/features/auth/login_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1570EE),
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.72,
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Profile section
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomBottomNavBar(initialIndex: 3),
                        ),
                        (route) => false,
                      );
                    },
                    borderRadius: BorderRadius.circular(60),
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage(AppImages.splash),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ahmed Adel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              _drawerItem(
                icon: Icons.settings_outlined,
                title: 'Setting',
                onTap: () {
                  _navigate(context, const SettingsScreen());
                },
              ),
              const SizedBox(height: 20),

              _drawerItem(
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  _navigate(context, const AboutScreen());
                },
              ),
              const SizedBox(height: 20),

              _drawerItem(
                icon: Icons.help_outline,
                title: 'Help',
                onTap: () {
                  _navigate(context, const HelpScreen());
                },
              ),

              const SizedBox(height: 20),

              _drawerItem(
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      horizontalTitleGap: 20,
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
      onTap: onTap,
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
