import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/features/user/presentation/blocs/otp_providers.dart';
import 'package:front/features/user/presentation/blocs/state/auth_state.dart'
    as auth_state;
import 'package:front/features/user/presentation/blocs/state/auth_state.dart';
import 'package:front/features/user/presentation/blocs/state/otp_state.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

final verificationCodeProvider = StateProvider<String>((ref) => '');

@RoutePage()
class VerifyOtpScreen extends ConsumerWidget {
  const VerifyOtpScreen({Key? key, required this.email, required this.json})
      : super(key: key);
  final String email;
  final json;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VerifyOtpRouteArgs args =
        ModalRoute.of(context)?.settings.arguments as VerifyOtpRouteArgs;
    final otpState = ref.watch(otpNotifierProvider);
    final verificationCode = ref.watch(verificationCodeProvider);
    final authNotifier = ref.watch(authNotifierProvider.notifier);
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 237, 243),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
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
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Verification",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 17, 66, 150)),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                textAlign: TextAlign.center,
                "Please enter the 6 digit code sent to \n $email",
                style: TextStyle(
                    fontSize: 16, color: Colors.grey.shade500, height: 1.5),
              ),
              const SizedBox(
                height: 30,
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
              if (otpState is Verified) ...[
                FutureBuilder<AuthState>(
                  future:
                      null, // No need to provide a future, we will use the current state from the provider
                  builder: (context, snapshot) {
                    final authState = ref.watch(authNotifierProvider);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Display a loading indicator while waiting for the registration process
                    } else if (authState is auth_state.Success) {
                      Future.delayed(Duration.zero, () {
                        AutoRouter.of(context).navigate(
                            const LoginRoute() // Schedule the call to show the verification modal after the build process is completed
                            );
                      });
                      return const SizedBox(); // Return an empty widget since we're showing the modal separately
                    } else {
                      return const SizedBox(); // Return an empty widget if the registration process is not completed or failed
                    }
                  },
                ),
                if (authState is auth_state.Failure) ...[
                  const SizedBox(height: 10),
                  const Text(
                    'An Error is occured while signing up !!',
                    style: TextStyle(
                        color: Colors.red,
                        fontFamily: 'SFUIText',
                        fontSize: 14),
                  ),
                ],
              ],
              const SizedBox(
                height: 30,
              ),
              VerificationCode(
                length: 4,
                textStyle: const TextStyle(fontSize: 20),
                underlineColor: Colors.blueAccent,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  ref
                      .read(verificationCodeProvider.notifier)
                      .update((state) => value);
                  authNotifier.signup(args.json);
                },
                onEditing: (value) {},
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't receive the OTP?",
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
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  ref.read(otpNotifierProvider.notifier).verifyOtp(
                        args.email, // Use the email from route arguments
                        verificationCode, // Pass the verification code from state
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

class VerifyOtpScreenArguments {
  final String email;

  VerifyOtpScreenArguments({required this.email});
}

Widget _otpMessage(BuildContext context, OtpState otpState) {
  switch (otpState) {
    case OtpState.initial:
      return const SizedBox.shrink();
    case OtpState.loading:
      return const CircularProgressIndicator();
    case OtpState.received:
      return const Text('Received...');
    case OtpState.verified:
      return const Text('Verified');
    case OtpState.failure:
      return const Text('Failed');
  }
  return const SizedBox.shrink();
}
