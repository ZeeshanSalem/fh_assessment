import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
         DrawerHeader(
          decoration: BoxDecoration(
            color: CustomColors.primary,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 44, color: CustomColors.primary,),
                ),
              ),

              Text('Zeeshan \nSaleem', style: AppTypography.lightTheme.headlineLarge?.copyWith(
                color: Colors.white,
              ),)
            ],
          ),
        ),

        ListTile(
          title: Text('Verified',style: AppTypography.lightTheme.headlineMedium,),
          trailing: Switch(
              inactiveThumbColor: Colors.grey,
              value: true, onChanged: (val){}),
        ),
      ],
    );
  }
}
