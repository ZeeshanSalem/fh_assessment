import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/features/home/presentation/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: CircleAvatar(
            child: Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
              text: 'Welcome back\n',
              style: TextStyle(fontSize: 14, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Zeeshan Saleem',
                  style: TextStyle(
                    fontSize: 18,
                    color: CustomColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ]),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 32,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          spacing: 10,
          children: [
            ///
            YourBalanceTile(),
          ],
        ),
      ),
    );
  }
}
