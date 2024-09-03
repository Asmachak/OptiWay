import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/organiser/presentation/pages/oragniser_home_screen.dart';
import 'package:front/features/organiser/presentation/pages/organiser_account_screen.dart';
import 'package:front/features/organiser/presentation/pages/organiser_events_screen.dart';
import 'package:front/features/organiser/presentation/pages/organiser_reservations_screen.dart';
import 'package:front/features/organiser/presentation/pages/organiser_statistiques_screen.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class MainOrganiserScreen extends StatefulWidget {
  const MainOrganiserScreen({Key? key}) : super(key: key);

  @override
  State<MainOrganiserScreen> createState() => _MainOrganiserScreenState();
}

class _MainOrganiserScreenState extends State<MainOrganiserScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0, // Default home tab is the first one
      routes: const [
        OrganiserHomeRoute(),
        OrganiserEventRoute(),
        OrganiserStatistqueRoute(),
        OrganiserReservationRoute(),
        OrganiserAccountRoute(),
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
                    // Left side of the floating action button
                    Row(
                      children: [
                        _buildTabButton(
                          icon: Icons.event_available_outlined,
                          label: 'Events',
                          isActive: tabsRouter.activeIndex == 1,
                          onTap: () => tabsRouter.setActiveIndex(1),
                        ),
                        _buildTabButton(
                          icon: Icons.bar_chart,
                          label: 'Stats',
                          isActive: tabsRouter.activeIndex == 2,
                          onTap: () => tabsRouter.setActiveIndex(2),
                        ),
                      ],
                    ),
                    // Right side of the floating action button
                    Row(
                      children: [
                        _buildTabButton(
                          icon: Icons.list_alt,
                          label: 'Reservations',
                          isActive: tabsRouter.activeIndex == 3,
                          onTap: () => tabsRouter.setActiveIndex(3),
                        ),
                        _buildTabButton(
                          icon: Icons.account_circle,
                          label: 'Account',
                          isActive: tabsRouter.activeIndex == 4,
                          onTap: () => tabsRouter.setActiveIndex(4),
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
              OrganiserHomeScreen(),
              OrganiserEventScreen(),
              OrganiserStatistqueScreen(),
              OrganiserReservationScreen(),
              OrganiserAccountScreen(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return MaterialButton(
      minWidth: 40,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.indigo : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.indigo : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
