import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/features/user/presentation/blocs/splash_provider.dart';
import 'package:front/features/user/presentation/widgets/menu_profile_widget.dart';
import 'package:front/features/user/presentation/widgets/profile_top_widget.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class accountScreen extends ConsumerStatefulWidget {
  const accountScreen({Key? key}) : super(key: key);

  @override
  _accountScreenState createState() => _accountScreenState();
}

class _accountScreenState extends ConsumerState<accountScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authLocalDataSourceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Account'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfilTopWidget(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the text horizontally
                      children: [
                        Text(
                          "${GetIt.instance
                                  .get<AuthLocalDataSource>()
                                  .currentUser!
                                  .name!} ${GetIt.instance
                                  .get<AuthLocalDataSource>()
                                  .currentUser!
                                  .lastName!}",
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
                        AutoRouter.of(context).push(const UpdateProfileRoute());
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
                        AutoRouter.of(context).push(const SettingRoute());
                      }),
                  ProfileMenuWidget(
                      title: "Billing Details",
                      icon: Icons.wallet,
                      onPress: () {
                        AutoRouter.of(context)
                            .push(const BillingDetailsRoute());
                      }),
                  ProfileMenuWidget(
                      title: "User Management",
                      icon: Icons.verified_user_sharp,
                      onPress: () {
                        AutoRouter.of(context)
                            .push(const UserManagementRoute());
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
                                      .read(authNotifierProvider.notifier)
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
