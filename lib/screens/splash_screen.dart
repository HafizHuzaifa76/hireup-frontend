import 'package:flutter/material.dart';

import '../core/secure_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

  }

  Future<void> _checkAuth(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2000));

    final token = await SecureStorage.getToken();

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/jobs');
    }

    print('token');
    print(token);

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _checkAuth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🌟 Animated Circular Logo
                    Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.work_rounded,
                        color: Colors.blue.shade600,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // 🌟 HireUp App Name
                    Text(
                      "HireUp",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Your Career Starts Here",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Small loading indicator
                    const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
