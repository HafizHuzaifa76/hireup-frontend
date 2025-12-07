import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class LoginPage extends ConsumerWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  final role = ValueNotifier<String>("job_seeker");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          width: 450,
          child: GlassCard(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Login to your Account",
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(height: 10),

                AppTextField(label: "Email", controller: email),
                SizedBox(height: 15),

                AppTextField(
                  label: "Password",
                  controller: password,
                  obscure: true,
                ),

                SizedBox(height: 20),

                NeuButton(
                  text: loading ? "Logging In..." : "Login",
                  onTap: () {
                    ref.read(authControllerProvider.notifier)
                        .login({
                      "email": email.text,
                      "password": password.text,
                    }, context);
                  },
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: Text("Don't have an account? SignUp",
                      style: TextStyle(color: Colors.blueAccent)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
