import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/edit_providers.dart';
import 'package:front/features/user/presentation/blocs/state/edit/edit_state.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ResetPasswordRouteArgs args =
        ModalRoute.of(context)?.settings.arguments as ResetPasswordRouteArgs;
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final editState = ref.watch(editNotifierProvider);
    final editNotifier = ref.watch(editNotifierProvider.notifier);

    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return "Please enter your password";
      } else if (value.length < 8) {
        return "Password must be at least 8 characters long";
      } else if (!value.contains(RegExp(r'\d'))) {
        return "Password must contain at least one number";
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
                const SizedBox(height: 10),
                const Text(
                  "Please set your new password",
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
                        controller: _passwordController,
                        validator: _validatePassword,
                        maxLines: 1,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        maxLines: 1,
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Confirm your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: editState is Loading,
                        child: const Text("Loading..."),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              var json = {
                                "email": args.email,
                                "newPassword": _passwordController.text
                              };
                              editNotifier.forgetPassword(json);
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
                      if (editState is Success)
                        FutureBuilder(
                          future: Future.delayed(Duration.zero, () async {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle_outline,
                                        size: 80,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Password reset successfully, go to login page',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          AutoRouter.of(context)
                                              .push(LoginRoute());
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            // Reset the provider state after dialog is dismissed
                            editNotifier.resetState();
                          }),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            return Container();
                          },
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
