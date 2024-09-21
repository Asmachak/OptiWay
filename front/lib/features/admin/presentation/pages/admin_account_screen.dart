import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/admin/data/data_sources/admin_local_data_src.dart';
import 'package:front/features/admin/presentation/blocs/auth_providers.dart';
import 'package:front/features/admin/presentation/widgets/admin_profil_top_widget.dart';
import 'package:front/features/user/presentation/widgets/menu_profile_widget.dart';
import 'package:front/features/organiser/presentation/blocs/auth_providers.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class AdminAccountScreen extends ConsumerWidget {
  const AdminAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Account',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AdminProfilTopWidget(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the text horizontally
                      children: [
                        Text(
                          "${GetIt.instance.get<AdminLocalDataSource>().currentAdmin!.name!} ${GetIt.instance.get<AdminLocalDataSource>().currentAdmin!.lastName!}",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),

                  Text("Profil Bio",
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 20),

                  /// -- BUTTON
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // AutoRouter.of(context).push(const UpdateProfileRoute());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text("Edit Profil",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Settings",
                      icon: Icons.settings,
                      onPress: () {
                        //AutoRouter.of(context).push(const SettingRoute());
                      }),
                  ProfileMenuWidget(
                      title: "Billing Details",
                      icon: Icons.wallet,
                      onPress: () {
                        // AutoRouter.of(context)
                        //     .push(const BillingDetailsRoute());
                      }),
                  ProfileMenuWidget(
                      title: "User Management",
                      icon: Icons.verified_user_sharp,
                      onPress: () {
                        // AutoRouter.of(context)
                        //     .push(const UserManagementRoute());
                      }),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Information", icon: Icons.info, onPress: () {}),
                  ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.logout,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("LOGOUT",
                                style: TextStyle(fontSize: 20)),
                            content: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text("Are you sure you want to logout?"),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(authAdminNotifierProvider.notifier)
                                      .logout();
                                  AutoRouter.of(context)
                                      .navigate(const WelcomeRoute());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.red,
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("No"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
