import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/features/user/presentation/pages/signup.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:auto_route/auto_route.dart';

// Text editing controllers for user input

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

AuthLocalDataSource? hiveeee;

const bool _showPassword = false;

class LoginForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  LoginForm({Key? key}) : super(key: key);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "please set e-mail address.";
    } else if (!EmailValidator.validate(value)) {
      return "please enter a valide email address";
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
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

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
                  labelText: 'Email aadress',
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
                    icon: const Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      ref.read(LoginFormProvider).togglePasswordVisibility();
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
                        // Navigator.push(
                        //   context
                        //    MaterialPageRoute(
                        //       builder: (context) => const SignupScreen()),
                        // );
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
                    ref.read(authNotifierProvider.notifier).login(
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
                      AutoRouter.of(context).replace(const HomeRoute());
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
                                  builder: (context) => const SignupScreen()),
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

final LoginFormProvider = Provider((ref) => LoginFormState());

class LoginFormState {
  bool _showPassword = false;
  bool get showPassword => _showPassword;

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
  }
}
