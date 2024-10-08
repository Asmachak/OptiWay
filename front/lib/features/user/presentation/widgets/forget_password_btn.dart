import 'package:flutter/material.dart';

class ForgetPasswordBtnWidget extends StatelessWidget {
  const ForgetPasswordBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromARGB(255, 32, 40, 89).withOpacity(0.08)),
        child: Row(
          children: [
            Icon(
              btnIcon,
              size: 60.0,
              color: const Color.fromARGB(255, 32, 40, 89),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 32, 40, 89),
                  ).merge(Theme.of(context).textTheme.titleLarge),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 32, 40, 89),
                  ).merge(Theme.of(context).textTheme.bodyMedium),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
