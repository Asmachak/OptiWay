import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:front/features/organiser/presentation/blocs/otp_providers.dart';
import 'package:front/features/organiser/presentation/pages/login_organiser.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void debounce(Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}

class OrganiserSignupForm extends ConsumerStatefulWidget {
  const OrganiserSignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<OrganiserSignupForm> createState() =>
      _OrganiserSignupFormState();
}

class _OrganiserSignupFormState extends ConsumerState<OrganiserSignupForm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Debouncer locationDebouncer = Debouncer(delay: Duration(milliseconds: 500));

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
      print('User denied location permissions');
    }
  }

  Future<void> _getLocation() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      locationDebouncer.debounce(() async {
        try {
          await requestLocationPermission();
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          setState(() {
            _locationMessage = '${position.latitude} ${position.longitude}';
          });
          await getLocationInfo();
        } catch (e) {
          setState(() {
            _locationMessage = 'Error getting location: $e';
          });
        } finally {
          setState(() {
            isLoading = false;
          });
        }
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
        });
      } else {
        setState(() {
          locationInfo = 'No location information available';
        });
      }
    } catch (e) {
      setState(() {
        locationInfo = 'Error getting location information: $e';
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
      return "Please set e-mail address.";
    } else if (!EmailValidator.validate(value)) {
      return "Please enter a valid email address";
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
                enabled: !isLoading,
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
              const SizedBox(height: 20),
              TextFormField(
                enabled: !isLoading,
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
              const SizedBox(height: 20),
              TextFormField(
                enabled: !isLoading,
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
              const SizedBox(height: 20),
              IntlPhoneField(
                enabled: !isLoading,
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: isLoading,
                      child: Container(
                        height: 48,
                        child: TextFormField(
                          enabled: !isLoading,
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
                  ),
                  Container(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {
                        _getLocation();
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      label: const Text(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator()),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                enabled: !isLoading,
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
              const SizedBox(height: 20),
              TextFormField(
                enabled: !isLoading,
                controller: _controllerConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password";
                  }
                  if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                maxLines: 1,
                obscureText: !_showPasswordConf,
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
                      _showPasswordConf
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      showPasswordConfirm();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
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
                              .read(otpOrganiserNotifierProvider.notifier)
                              .loginOtp(_emailController.text);
                          AutoRouter.of(context).push(
                            OrganiserVerifyOtpRoute(
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
              const SizedBox(height: 10),
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
                                builder: (context) =>
                                    const OrganiserLoginScreen()),
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

final OrganisersignUpFormProvider =
    Provider((ref) => OrganiserSignUpFormState());

class OrganiserSignUpFormState {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
  }
}
