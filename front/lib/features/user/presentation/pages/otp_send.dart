import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/otp_providers.dart';
import 'package:front/features/user/presentation/pages/otp_verify.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class EmailOTPscreen extends ConsumerWidget {
  const EmailOTPscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpNotifierProvider);
    final TextEditingController _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 237, 243),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(otpNotifierProvider.notifier)
                        .loginOtp(_emailController.text);
                    AutoRouter.of(context).push(
                      VerifyOtpRoute(email: _emailController.text),
                    );
                  },
                  child: otpState.when(
                    initial: () => const Text(
                      "Send OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                    loading: () => const Text("its loading"),
                    received: () => const Column(
                      // Use Column to display multiple widgets if needed
                      children: [
                        Text("OTP sent!"), // Your message here
                        SizedBox(height: 8), // Add spacing if needed
                      ],
                    ),
                    verified: () {
                      return const SizedBox();
                    },
                    failure: (_) => const Text(
                      "Send",
                    ),
                    success: () => const SizedBox(),
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
