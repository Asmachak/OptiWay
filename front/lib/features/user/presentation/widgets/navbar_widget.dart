import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final selectedIndexProvider = StateProvider<int>((ref) => 0);

// List<IconData> navIcons = [
//   Icons.home,
//   Icons.directions_car,
//   Icons.event_available_outlined,
//   Icons.person,
// ];
// List<String> navTitle = ["Home", "Parkings", "Events", "Account"];

class NavbarWidget extends ConsumerWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final selectedIndex = ref.watch(selectedIndexProvider);

    return AutoTabsRouter(routes: const []);
    // Container(
    //   height: 65,
    //   margin: const EdgeInsets.only(right: 14, left: 14, bottom: 24),
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(20),
    //       boxShadow: [
    //         BoxShadow(
    //             color: Colors.black.withAlpha(29),
    //             blurRadius: 20,
    //             spreadRadius: 10)
    //       ]),
    //   child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: navIcons.asMap().entries.map((entry) {
    //         final index = entry.key;
    //         final icon = entry.value;
    //         final isSelected = selectedIndex == index;
    //         return Material(
    //           color: Colors.transparent,
    //           child: GestureDetector(
    //             onTap: () {
    //               ref.read(selectedIndexProvider.notifier).state = index;
    //             },
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     alignment: Alignment.center,
    //                     margin: const EdgeInsets.only(
    //                         top: 15, bottom: 0, left: 35, right: 35),
    //                     child: Icon(
    //                       icon,
    //                       color: isSelected ? Colors.indigo : Colors.grey,
    //                     ),
    //                   ),
    //                   Text(
    //                     navTitle[index],
    //                     style: TextStyle(
    //                         color: isSelected ? Colors.indigo : Colors.grey,
    //                         fontSize: 12),
    //                   ),
    //                   const SizedBox(
    //                     height: 10,
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //       }).toList()),
    // );
  }
}
