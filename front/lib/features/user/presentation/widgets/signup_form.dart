import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/features/user/presentation/blocs/state/auth_state.dart';
import 'package:front/features/user/presentation/pages/login_screen.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);
  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  // Text editing controllers for user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isPasswordMatch = false;
  static const bool _showPassword = false;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please set your name";
    } else if (value.length < 4) {
      return "Minimum length is 4 Characters";
    }
    return null;
  }

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
    } else if (!value.contains(RegExp(r'\d'))) {
      return "Password must contain at least one number";
    }
    return null;
  }

  void checkPasswordMatch() {
    setState(() {
      _isPasswordMatch =
          (_controllerConfirmPassword.text == _passwordController.text);
    });
  }

  @override
  void initState() {}

  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                validator: _validateName,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  hintText: 'Please Set your name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _lastNameController,
                validator: _validateName,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  labelText: 'Last Name',
                  hintText: 'Please Set your last name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
              IntlPhoneField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialCountryCode: 'BE',
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _addressController,
                validator: _validateName,
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  hintText: 'Please Set your Address',
                  prefixIcon: const Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                      ref.read(signUpFormProvider).togglePasswordVisibility();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // mdps validator
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Les mots de passe ne correspondent pas.";
                  }
                  return null;
                },
                maxLines: 1,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Verifier votre password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      ref.read(signUpFormProvider).togglePasswordVisibility();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, watch, child) {
                  final authNotifier = ref.watch(authNotifierProvider.notifier);
                  return ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(
                      height: 40,
                      width: 157,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final json = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "password": _passwordController.text,
                            "last_name": _lastNameController.text,
                            "phone": _phoneController.text,
                            "address": _addressController.text,
                          };
                          authNotifier.signup(json);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 67, 70, 225),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              FutureBuilder<AuthState>(
                future:
                    null, // No need to provide a future, we will use the current state from the provider
                builder: (context, snapshot) {
                  final authState = ref.watch(authNotifierProvider);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Display a loading indicator while waiting for the registration process
                  } else if (authState is Success) {
                    Future.delayed(Duration.zero, () {
                      AutoRouter.of(context).navigate(
                          const EmailOTPscreen()); // Schedule the call to show the verification modal after the build process is completed
                    });
                    return const SizedBox(); // Return an empty widget since we're showing the modal separately
                  } else {
                    return const SizedBox(); // Return an empty widget if the registration process is not completed or failed
                  }
                },
              ),
              if (authState is Failure) ...[
                const SizedBox(height: 10),
                Text(
                  authState.exception.message,
                  style: const TextStyle(
                      color: Colors.red, fontFamily: 'SFUIText', fontSize: 14),
                ),
              ],
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final signUpFormProvider = Provider((ref) => SignUpFormState());

class SignUpFormState {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
  }
}
