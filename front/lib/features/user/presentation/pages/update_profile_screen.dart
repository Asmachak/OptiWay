import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/blocs/edit_providers.dart';
import 'package:front/features/user/presentation/blocs/state/edit/edit_state.dart';
import 'package:front/features/user/presentation/widgets/profile_top_widget.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';

// Text editing controllers for user input
final TextEditingController _nameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _PasswordFormKey = GlobalKey<FormState>();

@RoutePage()
class UpdateProfileScreen extends ConsumerWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editNotifier = ref.watch(editNotifierProvider.notifier);
    final editState = ref.watch(editNotifierProvider);

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // -- IMAGE with ICON
              const ProfilTopWidget(),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      // validator: _validateName,
                      decoration: const InputDecoration(
                          label: Text(
                            "First Name",
                            style: TextStyle(color: Colors.indigo),
                          ),
                          prefixIcon: Icon(Icons.manage_accounts_outlined,
                              color: Colors.indigo)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                          label: Text(
                            "Last Name",
                            style: TextStyle(color: Colors.indigo),
                          ),
                          prefixIcon: Icon(Icons.manage_accounts,
                              color: Colors.indigo)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          label: Text("Email Adress",
                              style: TextStyle(color: Colors.indigo)),
                          prefixIcon: Icon(Icons.mail, color: Colors.indigo)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          label: Text("Phone Number",
                              style: TextStyle(color: Colors.indigo)),
                          prefixIcon: Icon(Icons.phone, color: Colors.indigo)),
                    ),
                    const SizedBox(height: 20),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final json = {
                              "name": _nameController.text.isNotEmpty
                                  ? _nameController.text
                                  : GetIt.instance
                                      .get<AuthLocalDataSource>()
                                      .currentUser!
                                      .name!,
                              "email": _emailController.text.isNotEmpty
                                  ? _emailController.text
                                  : GetIt.instance
                                      .get<AuthLocalDataSource>()
                                      .currentUser!
                                      .email!,
                              "last_name": _lastNameController.text.isNotEmpty
                                  ? _lastNameController.text
                                  : GetIt.instance
                                      .get<AuthLocalDataSource>()
                                      .currentUser!
                                      .lastName!,
                              "phone": _phoneController.text.isNotEmpty
                                  ? _phoneController.text
                                  : GetIt.instance
                                      .get<AuthLocalDataSource>()
                                      .currentUser!
                                      .phone!,
                            };

                            editNotifier.editProfile(
                                json,
                                GetIt.instance
                                    .get<AuthLocalDataSource>()
                                    .currentUser!
                                    .id!);
                            if (editState is Success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 90,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: const Column(
                                      children: [
                                        Text(
                                          "Congrats!",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        Text(
                                            " Your Profile Data are updated successfully!",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );
                              AutoRouter.of(context)
                                  .replace(const AccountRoute());
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("EditProfile",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController
                                      actualPasswordController =
                                      TextEditingController();
                                  TextEditingController newPasswordController =
                                      TextEditingController();

                                  TextEditingController
                                      confirmNewPasswordController =
                                      TextEditingController();
                                  return AlertDialog(
                                    title: const Text(" Change Your Password"),
                                    content: SingleChildScrollView(
                                        child: Form(
                                      key: _PasswordFormKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            obscureText: true,
                                            validator: _validatePassword,
                                            controller:
                                                actualPasswordController,
                                            decoration: const InputDecoration(
                                                labelText: "Actual Password"),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            validator: _validatePassword,
                                            obscureText: true,
                                            controller: newPasswordController,
                                            decoration: const InputDecoration(
                                                labelText: "New Password"),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                            validator: _validatePassword,
                                            obscureText: true,
                                            controller:
                                                confirmNewPasswordController,
                                            decoration: const InputDecoration(
                                                labelText:
                                                    "Confirm New Password"),
                                          ),
                                        ],
                                      ),
                                    )),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle password change logic here
                                          String actualPassword =
                                              actualPasswordController.text;
                                          String newPassword =
                                              newPasswordController.text;
                                          String confirmPassword =
                                              confirmNewPasswordController.text;
                                          if (newPassword != confirmPassword) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Passwords do not match"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                          if (_formKey.currentState!
                                              .validate()) {
                                            var json = {
                                              "password": actualPassword,
                                              "newPassword": newPassword
                                            };
                                            editNotifier.editPassword(
                                                json,
                                                GetIt.instance
                                                    .get<AuthLocalDataSource>()
                                                    .currentUser!
                                                    .id!);
                                            print("hello state");
                                            print(editState);

                                            if (editState is Success) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    height: 90,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: const Column(
                                                      children: [
                                                        Text(
                                                          "Congrats!",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                            " Your Password is updated successfully!",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                ),
                                              );

                                              AutoRouter.of(context).replace(
                                                  const AccountRoute());
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.indigo,
                                          shape: StadiumBorder(),
                                          side: BorderSide.none,
                                        ),
                                        child: const Text(
                                          "Change",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.withOpacity(0.1),
                              elevation: 0,
                              shape: StadiumBorder(),
                              side: BorderSide.none,
                            ),
                            icon: const Icon(Icons.fingerprint,
                                color: Colors.indigo),
                            label: const Text("Edit Password",
                                style: TextStyle(color: Colors.indigo)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // -- Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.redAccent.withOpacity(0.1),
                                elevation: 0,
                                foregroundColor: Colors.red,
                                shape: const StadiumBorder(),
                                side: BorderSide.none),
                            child: const Text("Delete All"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
