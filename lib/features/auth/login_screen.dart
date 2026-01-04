import 'package:flutter/material.dart';
import 'package:safari_egypt_app/core/app_images.dart';
import 'package:safari_egypt_app/core/app_colors.dart';
import 'package:safari_egypt_app/features/Home/view/custom_bottom_nav_bar.dart';
import 'package:safari_egypt_app/core/widgets/social_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _remember = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final logoHeight =
        isLandscape ? 64.0 : (size.width * 0.4).clamp(80.0, 220.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 8, top: 24, bottom: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo (full width)
                Image.asset(
                  AppImages.splash,
                  width: double.infinity,
                  height: logoHeight,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 18),

                // Padded Left-Aligned Group (Title → Login)
                Builder(
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title (centered)
                          Center(
                            child: Text(
                              'Welcome Back!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            validator: (value) {
                              final v = value?.trim() ?? '';
                              if (v.isEmpty) return 'Email is required';
                              if (!RegExp(
                                r'^[^\s@]+@[^\s@]+\.com$',
                              ).hasMatch(v)) {
                                return 'Enter a valid email ending with .com';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          // Password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed:
                                    () => setState(() => _obscure = !_obscure),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            validator: (value) {
                              final v = value ?? '';
                              if (v.isEmpty) return 'Password is required';
                              if (v.trim().length <= 5) {
                                return 'Password must be more than 5 characters';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Checkbox(
                                value: _remember,
                                onChanged:
                                    (v) =>
                                        setState(() => _remember = v ?? false),
                              ),

                              const Text(
                                'Remember me',
                                style: TextStyle(fontSize: 16),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Login Button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                // Navigate to main app (bottom nav)
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CustomBottomNavBar(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have Account?"),
                    TextButton(
                      onPressed:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpScreen(),
                            ),
                          ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                // Padded group for Divider / Socials / Version
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Social Buttons (column)
                      SocialButton(
                        label: 'Continue with Facebook',
                        color: const Color.fromARGB(255, 216, 216, 221),
                        icon: Icons.facebook,
                        iconColor: const Color(0xFF1877F2),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8),
                      SocialButton(
                        label: 'Continue with Google',
                        color: const Color.fromARGB(255, 216, 216, 221),
                        icon: Icons.g_translate,
                        leading: Image.asset(
                          AppImages.google,
                          width: 28,
                          height: 28,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 8),
                      SocialButton(
                        label: 'Continue with Apple',
                        color: const Color.fromARGB(255, 216, 216, 221),
                        icon: Icons.apple,
                        iconColor: Colors.black,
                        onPressed: () {},
                      ),

                      const SizedBox(height: 12),

                      // version (left aligned)
                      Center(
                        child: Text(
                          'version 9.1',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
