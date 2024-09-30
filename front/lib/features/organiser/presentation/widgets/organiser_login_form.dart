import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:front/features/organiser/presentation/blocs/auth_providers.dart';
import 'package:front/features/organiser/presentation/pages/sign_up_organiser.dart';
import 'package:front/features/user/presentation/pages/signup.dart';
import 'package:front/features/user/presentation/widgets/forget_password_btn.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:auto_route/auto_route.dart';

// Text editing controllers for user input
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class OrganiserLoginForm extends ConsumerStatefulWidget {
  OrganiserLoginForm({Key? key}) : super(key: key);

  @override
  _OrganiserLoginFormState createState() => _OrganiserLoginFormState();
}

class _OrganiserLoginFormState extends ConsumerState<OrganiserLoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  void showPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please set e-mail address.";
    } else if (!EmailValidator.validate(value)) {
      return "please enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Enter your password";
    } else if (value.length < 8) {
      return "You need 8 Characters minimum";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authOrganiserNotifierProvider);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: _validateEmail,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Email address',
                  hintText: 'Set your Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                validator: _validatePassword,
                maxLines: 1,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      showPassword();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: "Forgot your password ? ",
                    style: const TextStyle(
                      color: Colors.indigo,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _showModalBottomSheet(context);
                      },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ref.read(authOrganiserNotifierProvider.notifier).login(
                          _emailController.text,
                          _passwordController.text,
                        );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 67, 70, 225),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 67, 70, 225),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: authState.when(
                  initial: () => const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  loading: () => const Text("its loading"),
                  authenticated: (_) {
                    // Navigate to home route when authenticated
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      AutoRouter.of(context)
                          .replace(const MainOrganiserRoute());
                    });
                    return const SizedBox();
                  },
                  failure: (_) => const Text(
                    "Login",
                  ),
                  success: () => const SizedBox(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Builder(
                builder: (context) => RichText(
                  text: TextSpan(
                    text: "You don't have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(
                          color: Colors.indigo,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OrganiserSignupScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Make a Selection!",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 32, 40, 89))),
            Text("Select one of the options given below to reset your password",
                style: Theme.of(context).textTheme.bodyLarge
                ),
            const SizedBox(height: 30.0),
            ForgetPasswordBtnWidget(
              onTap: () {
                AutoRouter.of(context).push(const ForgetPasswordMailRoute());
              },
              title: "E-mail",
              subTitle: "Reset via Mail verification",
              btnIcon: Icons.mail_outline_rounded,
            ),
            const SizedBox(height: 20.0),
            ForgetPasswordBtnWidget(
              onTap: () {},
              title: "Phone Number",
              subTitle: "Reset via Phone verification",
              btnIcon: Icons.mobile_friendly_rounded,
            ),
          ],
        ),
      ),
    ),
  );
}
