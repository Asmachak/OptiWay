import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/data/models/user_model.dart';
import 'package:front/features/user/presentation/blocs/edit_providers.dart';
import 'package:front/features/user/presentation/blocs/splash_provider.dart';
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
              ProfilTopWidget(),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: _validateName,
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
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("Password",
                            style: TextStyle(color: Colors.indigo)),
                        prefixIcon:
                            const Icon(Icons.fingerprint, color: Colors.indigo),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye_outlined,
                                color: Colors.indigo),
                            onPressed: () {}),
                      ),
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

                            var user = editNotifier.editProfile(
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
                            ;
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

                    // -- Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
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
