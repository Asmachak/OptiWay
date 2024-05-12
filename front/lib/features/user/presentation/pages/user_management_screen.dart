import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front/features/user/data/data_sources/local_data_source.dart';
import 'package:front/features/user/presentation/widgets/menu_profile_widget.dart';
import 'package:front/features/vehicule/presentation/blocs/vehicule_list_provider.dart';
import 'package:front/routes/app_routes.gr.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class UserManagementScreen extends ConsumerWidget {
  const UserManagementScreen({super.key});

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
          child: Text('User Management'),
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
                      title: "reservations",
                      icon: Icons.event_note_outlined,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "vehicules",
                      icon: Icons.directions_car,
                      onPress: () {
                        AutoRouter.of(context)
                            .push(VehiculeListRoute(previous: ""));
                      }),
                  ProfileMenuWidget(
                      title: "connections",
                      icon: Icons.connect_without_contact,
                      onPress: () {}),
                  ProfileMenuWidget(
                      title: "Calender",
                      icon: Icons.calendar_month,
                      onPress: () {}),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileMenuWidget(
                      title: "Add Profile", icon: Icons.add, onPress: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
