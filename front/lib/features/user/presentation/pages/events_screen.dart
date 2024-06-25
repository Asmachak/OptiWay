import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/event/presentation/pages/movies_list.dart';

@RoutePage()
class eventScreen extends StatelessWidget {
  const eventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyWidget(),
    );
  }
}
