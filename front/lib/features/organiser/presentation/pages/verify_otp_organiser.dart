import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/organiser/presentation/blocs/auth_providers.dart';
import 'package:front/features/organiser/presentation/blocs/otp_providers.dart';
import 'package:front/features/organiser/presentation/blocs/state/auth/auth_notifier.dart';
import 'package:front/features/organiser/presentation/blocs/state/auth/auth_state.dart'
    as auth_state;
import 'package:front/features/organiser/presentation/blocs/state/otp/otp_state.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

final verificationCodeProvider = StateProvider<String>((ref) => '');

@RoutePage()
class OrganiserVerifyOtpScreen extends ConsumerWidget {
  const OrganiserVerifyOtpScreen(
      {Key? key, required this.email, required this.json})
      : super(key: key);
  final String email;
  final dynamic json; // specify the type if possible

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OrganiserOtpState organiserOtpState =
        ref.watch(otpOrganiserNotifierProvider);
    final String verificationCode = ref.watch(verificationCodeProvider);
    final AuthOrganiserNotifier organiserAuthNotifier =
        ref.watch(authOrganiserNotifierProvider.notifier);
    final auth_state.OrganiserAuthState organiserAuthState =
        ref.watch(authOrganiserNotifierProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 237, 243),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade200),
                    child: Transform.rotate(
                      angle: 38,
                      child: const Image(
                        image: AssetImage('assets/email.png'),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                "Verification",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 66, 150)),
              ),
              const SizedBox(height: 30),
              Text(
                textAlign: TextAlign.center,
                "Please enter the 4 digit code sent to \n $email",
                style: TextStyle(
                    fontSize: 16, color: Colors.grey.shade500, height: 1.5),
              ),
              const SizedBox(height: 30),
              _otpMessage(
                  context, organiserOtpState), // Using the helper function
              if (organiserOtpState is Verified) ...[
                FutureBuilder<auth_state.OrganiserAuthState>(
                  future: null, // No need for a future, we'll use the provider
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (organiserAuthState is auth_state.Success) {
                      Future.delayed(Duration.zero, () {
                        AutoRouter.of(context)
                            .replace(const OrganiserLoginRoute());
                      });
                      return const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                if (organiserAuthState is auth_state.Failure) ...[
                  const SizedBox(height: 10),
                  const Text(
                    'An Error occurred while signing up!',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
              ],
              const SizedBox(height: 30),
              VerificationCode(
                length: 4,
                textStyle: const TextStyle(fontSize: 20),
                underlineColor: Colors.blueAccent,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  ref.read(verificationCodeProvider.notifier).state = value;
                  organiserAuthNotifier.signup(json);
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
                      ref
                          .read(otpOrganiserNotifierProvider.notifier)
                          .loginOtp(email);
                    },
                    child: const Text("Resend",
                        style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              MaterialButton(
                onPressed: () {
                  ref.read(otpOrganiserNotifierProvider.notifier).verifyOtp(
                        email, // Use the email directly
                        verificationCode,
                      );
                },
                color: const Color.fromARGB(255, 17, 66, 150),
                minWidth: double.infinity,
                height: 50,
                child: const Text(
                  "Verify",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper function for displaying OTP messages
Widget _otpMessage(BuildContext context, OrganiserOtpState otpState) {
  switch (otpState) {
    case OrganiserOtpState.initial:
      return const SizedBox.shrink();
    case OrganiserOtpState.loading:
      return const CircularProgressIndicator();
    case OrganiserOtpState.received:
      return const Text('Received...');
    case OrganiserOtpState.verified:
      return const Text('Verified');
    case OrganiserOtpState.failure:
      return const Text('Failed');
  }
  return const SizedBox.shrink();
}
