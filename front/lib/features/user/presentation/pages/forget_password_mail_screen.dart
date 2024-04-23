import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/otp_providers.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class ForgetPasswordMailScreen extends ConsumerWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    String? _validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return "please set e-mail address.";
      } else if (!EmailValidator.validate(value)) {
        return "please enter a valid email address";
      }
      return null;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                  "Forget your password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 41, 88),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Please set your email to have the OTP Code",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 44, 55, 121),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15 * 4),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: _validateEmail,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                          hintText: 'Set your Email',
                          prefixIcon: const Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              ref
                                  .read(otpNotifierProvider.notifier)
                                  .loginOtp(_emailController.text);
                              AutoRouter.of(context).push(
                                PasswordOtpRoute(email: _emailController.text),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.indigo,
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
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
