import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/user/presentation/pages/account_screen.dart';
import 'package:front/features/user/presentation/pages/events_screen.dart';
import 'package:front/features/user/presentation/pages/home_screen.dart';
import 'package:front/features/user/presentation/pages/parkings_screen.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0,
      routes: const [
        HomeRoute(),
        ParkingsRoute(),
        EventRoute(),
        AccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18), topLeft: Radius.circular(18)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                selectedItemColor: Colors.indigo,
                unselectedItemColor: Colors.grey,
                iconSize: 30,
                onTap: (index) {
                  // here we switch between tabs
                  tabsRouter.setActiveIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      label: "home",
                      icon: Icon(Icons.home),
                      backgroundColor: Color.fromARGB(255, 229, 237, 243)),
                  BottomNavigationBarItem(
                      label: "Parkings",
                      icon: Icon(Icons.directions_car),
                      backgroundColor: Color.fromARGB(255, 229, 237, 243)),
                  BottomNavigationBarItem(
                      label: "Events",
                      icon: Icon(Icons.event_available_outlined),
                      backgroundColor: Color.fromARGB(255, 229, 237, 243)),
                  BottomNavigationBarItem(
                      label: "Account",
                      icon: Icon(Icons.account_circle),
                      backgroundColor: Color.fromARGB(255, 229, 237, 243)),
                ],
              ),
            ),
          ),
          body: IndexedStack(
            index: tabsRouter.activeIndex,
            children: const [
              homeScreen(),
              parkingsScreen(),
              eventScreen(),
              accountScreen(),
            ],
          ),
        );
      },
    );
  }
}
