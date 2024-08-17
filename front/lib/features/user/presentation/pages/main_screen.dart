import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/reservation/presentation/pages/reservation_list_screen.dart';
import 'package:front/features/user/presentation/pages/account_screen.dart';
import 'package:front/features/user/presentation/pages/events_screen.dart';
import 'package:front/features/user/presentation/pages/home_screen.dart';
import 'package:front/features/user/presentation/pages/parkings_screen.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0, // Ensure this matches your intended home tab
      routes: const [
        HomeRoute(),
        ParkingsRoute(),
        EventRoute(),
        ReservationListRoute(),
        AccountRoute()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              tabsRouter.setActiveIndex(0); // Navigate to Home tab
            },
            backgroundColor: Colors.indigo,
            child: const Icon(Icons.home, color: Colors.white),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 6.0,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            tabsRouter
                                .setActiveIndex(1); // Navigate to Parkings tab
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_car,
                                color: tabsRouter.activeIndex == 1
                                    ? Colors.indigo
                                    : Colors.grey,
                              ),
                              Text(
                                'Parkings',
                                style: TextStyle(
                                  color: tabsRouter.activeIndex == 1
                                      ? Colors.indigo
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            tabsRouter
                                .setActiveIndex(2); // Navigate to Events tab
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_available_outlined,
                                color: tabsRouter.activeIndex == 2
                                    ? Colors.indigo
                                    : Colors.grey,
                              ),
                              Text(
                                'Events',
                                style: TextStyle(
                                  color: tabsRouter.activeIndex == 2
                                      ? Colors.indigo
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            tabsRouter.setActiveIndex(
                                3); // Navigate to Reservations tab
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list_alt,
                                color: tabsRouter.activeIndex == 3
                                    ? Colors.indigo
                                    : Colors.grey,
                              ),
                              Text(
                                'Reservations',
                                style: TextStyle(
                                  color: tabsRouter.activeIndex == 3
                                      ? Colors.indigo
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            tabsRouter
                                .setActiveIndex(4); // Navigate to Account tab
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: tabsRouter.activeIndex == 4
                                    ? Colors.indigo
                                    : Colors.grey,
                              ),
                              Text(
                                'Account',
                                style: TextStyle(
                                  color: tabsRouter.activeIndex == 4
                                      ? Colors.indigo
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: IndexedStack(
            index: tabsRouter.activeIndex,
            children: const [
              homeScreen(),
              parkingsScreen(),
              eventScreen(),
              ReservationListScreen(),
              accountScreen(),
            ],
          ),
        );
      },
    );
  }
}
