import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/otp_providers.dart';
import 'package:front/features/user/presentation/blocs/state/otp/otp_state.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

final verificationCodeProvider = StateProvider<String>((ref) => '');

@RoutePage()
class PasswordOtpScreen extends ConsumerWidget {
  const PasswordOtpScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PasswordOtpRouteArgs args =
        ModalRoute.of(context)?.settings.arguments as PasswordOtpRouteArgs;
    final otpState = ref.watch(otpNotifierProvider);
    final verificationCode = ref.watch(verificationCodeProvider);

    Timer(const Duration(milliseconds: 500), () {
      if (otpState is Verified) {
        AutoRouter.of(context).navigate(ResetPasswordRoute(email: args.email));
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 237, 243),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const SizedBox(
                width: 200,
                height: 200,
                child: Image(
                  image: AssetImage('assets/email.png'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Verification",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 66, 150),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Please enter the 4 digit code sent to $email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
              ),
              Container(
                child: otpState.when(
                  initial: () => const Text(
                    "Verify OTP",
                    style: TextStyle(color: Colors.white),
                  ),
                  loading: () => const Text("Loading..."),
                  received: () => const Text("Received..."),
                  verified: () => const Text("Verified"),
                  failure: (_) => const Text("Failed"),
                  success: () => const SizedBox(),
                ),
              ),
              const SizedBox(height: 30),
              VerificationCode(
                length: 4,
                textStyle: const TextStyle(fontSize: 20),
                underlineColor: Colors.blueAccent,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  ref
                      .read(verificationCodeProvider.notifier)
                      .update((state) => value);
                },
                onEditing: (value) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the OTP?",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(otpNotifierProvider.notifier).loginOtp(email);
                    },
                    child: const Text("Resend",
                        style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(otpNotifierProvider.notifier)
                        .verifyOtp(args.email, verificationCode);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.indigo,
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
