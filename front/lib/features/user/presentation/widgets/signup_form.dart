import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/features/user/presentation/pages/login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// Text editing controllers for user input
final TextEditingController _nameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
const bool _showPassword = false;

class SignUpForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpForm({Key? key}) : super(key: key);

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
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Call the global signup function
                      await _performSignUp(ref);
                    } catch (e) {
                      print('Error during signup: $e');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
                ),
                child: const Text(
                  "SignUp",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Log in',
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

Future<void> _performSignUp(WidgetRef ref) async {
  try {
    final json = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "last_name": _lastNameController.text,
      "phone": _phoneController.text,
      "address": _addressController.text,
    };

    final createAccount = ref.read(userRepositoryProvider);
    await createAccount.signUpUser(body: json);
  } catch (e) {
    print('Error during signup: $e');
  }
}
