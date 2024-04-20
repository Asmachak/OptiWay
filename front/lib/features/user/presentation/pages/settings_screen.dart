import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/presentation/blocs/auth_providers.dart';
import 'package:front/features/user/presentation/widgets/menu_profile_widget.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Settings'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Notifications",
                      icon: Icons.notifications,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Languages", icon: Icons.language, onPress: () {}),
                  ProfileMenuWidget(
                      title: "Theme",
                      icon: Icons.dark_mode_outlined,
                      onPress: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
