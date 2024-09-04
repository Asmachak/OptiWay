import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front/features/event/presentation/widgets/event_list_organiser.dart';

@RoutePage()
class OrganiserEventScreen extends StatefulWidget {
  const OrganiserEventScreen({super.key});

  @override
  State<OrganiserEventScreen> createState() => _OrganiserEventScreenState();
}

class _OrganiserEventScreenState extends State<OrganiserEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventListWidget(),
    );
  }
}
