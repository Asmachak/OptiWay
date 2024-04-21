import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:front/features/user/presentation/blocs/otp_providers.dart';
import 'package:front/features/user/presentation/pages/login_screen.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

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

  bool _isPasswordMatch = false;
  bool _showPassword = false;
  bool _showPasswordConf = false;
  String? _locationMessage;
  String? city;
  String? country;
  String? locationInfo;
  bool isLoading = false;

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      // L'utilisateur a refusé les autorisations
      // Gérez cette situation selon vos besoins
      print('User denied location permissions');
    }
  }

  Future<void> _getLocation() async {
    try {
      await requestLocationPermission();
      setState(() {
        isLoading = true; // Show loading indicator
      });
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _locationMessage = '${position.latitude} ${position.longitude}';
        print(_locationMessage);
      });
      await getLocationInfo();
    } catch (e) {
      setState(() {
        _locationMessage = 'Error getting location: $e';
        print(_locationMessage);
      });
    }
  }

  Future<void> getLocationInfo() async {
    try {
      var latitude = double.parse(_locationMessage!.split(' ')[0]);
      var longitude = double.parse(_locationMessage!.split(' ')[1]);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          locationInfo = '${placemark.country} ${placemark.locality}';
          city = placemark.locality;
          country = placemark.country;
          isLoading = false;
          print(locationInfo);
        });
      } else {
        setState(() {
          locationInfo = 'No location information available';
          print(locationInfo);
        });
      }
    } catch (e) {
      setState(() {
        locationInfo = 'Error getting location information: $e';
        print(locationInfo);
      });
    }
  }

  void showPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void showPasswordConfirm() {
    setState(() {
      _showPasswordConf = !_showPasswordConf;
    });
  }

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
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48, // Adjust the height as needed
                      child: TextFormField(
                        controller: TextEditingController(text: locationInfo),
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          hintText: 'Please Set your Address',
                          prefixIcon: const Icon(Icons.home),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 48, // Match the height of the TextFormField
                    child: TextButton.icon(
                      onPressed: () {
                        _getLocation();
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Get Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading)
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: CircularProgressIndicator(),
                    ),
                ],
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
              TextFormField(
                controller: _passwordController,
                validator: _validatePassword,
                maxLines: 1,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Confirm your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      showPasswordConfirm();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, watch, child) {
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
                            "address": _locationMessage,
                            "city": city,
                            "country": country,
                          };
                          ref
                              .read(otpNotifierProvider.notifier)
                              .loginOtp(_emailController.text);
                          AutoRouter.of(context).push(
                            VerifyOtpRoute(
                                email: _emailController.text, json: json),
                          );
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
