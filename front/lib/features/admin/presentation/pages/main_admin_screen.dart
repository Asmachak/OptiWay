import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:front/features/admin/presentation/pages/admin_account_screen.dart';
import 'package:front/features/admin/presentation/pages/admin_home_screen.dart';
import 'package:front/features/admin/presentation/pages/admin_stats_screen.dart';
import 'package:front/features/admin/presentation/pages/admin_tables_screen.dart';
import 'package:front/routes/app_routes.gr.dart';

@RoutePage()
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0, // This sets the home tab to be the first one (index 0)
      routes: const [
        AdminHomeRoute(),
        AdminTableRoute(),
        AdminStatRoute(),
        AdminAccountRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
            child: BottomAppBar(
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
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        tabsRouter.setActiveIndex(0); // Navigate to Home tab
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: tabsRouter.activeIndex == 0
                                ? Colors.indigo
                                : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: tabsRouter.activeIndex == 0
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
                        tabsRouter.setActiveIndex(1); // Navigate to Tables tab
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.table_chart,
                            color: tabsRouter.activeIndex == 1
                                ? Colors.indigo
                                : Colors.grey,
                          ),
                          Text(
                            'Tables',
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
                        tabsRouter.setActiveIndex(2); // Navigate to Stats tab
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bar_chart,
                            color: tabsRouter.activeIndex == 2
                                ? Colors.indigo
                                : Colors.grey,
                          ),
                          Text(
                            'Stats',
                            style: TextStyle(
                              color: tabsRouter.activeIndex == 2
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
                        tabsRouter.setActiveIndex(3); // Navigate to Account tab
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: tabsRouter.activeIndex == 3
                                ? Colors.indigo
                                : Colors.grey,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                              color: tabsRouter.activeIndex == 3
                                  ? Colors.indigo
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: IndexedStack(
            index: tabsRouter.activeIndex,
            children: const [
              AdminHomeScreen(),
              AdminTableScreen(),
              AdminStatScreen(),
              AdminAccountScreen(),
            ],
          ),
        );
      },
    );
  }
}
