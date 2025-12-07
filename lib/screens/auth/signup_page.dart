import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class SignupPage extends ConsumerWidget {
  final name = TextEditingController();
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
                Text("Create Account",
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(height: 10),

                AppTextField(label: "Name", controller: name),
                SizedBox(height: 15),

                AppTextField(label: "Email", controller: email),
                SizedBox(height: 15),

                AppTextField(
                  label: "Password",
                  controller: password,
                  obscure: true,
                ),

                SizedBox(height: 20),

                ValueListenableBuilder(
                  valueListenable: role,
                  builder: (ctx, value, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: Text("Job Seeker"),
                        selected: value == "job_seeker",
                        onSelected: (v) => role.value = "job_seeker",
                      ),
                      ChoiceChip(
                        label: Text("Employer"),
                        selected: value == "employer",
                        onSelected: (v) => role.value = "employer",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                NeuButton(
                  text: loading ? "Signing Up..." : "Sign Up",
                  onTap: () {
                    ref.read(authControllerProvider.notifier)
                        .signup({
                      "name": name.text,
                      "email": email.text,
                      "password": password.text,
                      "role": role.value,
                    }, context);
                  },
                ),

                SizedBox(height: 20),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text("Already have an account? Login",
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
