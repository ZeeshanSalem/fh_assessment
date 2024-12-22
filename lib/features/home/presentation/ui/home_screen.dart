import 'package:fh_assignment/core/routing/routers.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:fh_assignment/features/home/presentation/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,

      /// 1. `AppBar` : contain 1. Avatar 2. UserName
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: Builder(
              builder: (buildContext) {
                return InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Scaffold.of(buildContext).openDrawer();
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 32,
                    ),
                  ),
                );
              }
          ),
        ),
        title: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return RichText(
              text: TextSpan(
                  text: 'Welcome back\n',
                  style: AppTypography.lightTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: '${state.user?.name}',
                      style: AppTypography.lightTheme.titleLarge,
                    ),
                  ]),
            );
          },
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

      /// 2. Drawer Section.
      drawer: Drawer(
        child: HomeDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [

            /// Total Balance  tile
            YourBalanceTile(),

            /// Feature Action Buttons.
            Text(
              'Features',
              style: AppTypography.lightTheme.titleMedium,
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: FeatureButton(
                    btnIcon: Icons.add,
                    btnName: 'Top Up',
                    onPress: () {
                      context.pushNamed(Routes.topUpRoute);
                    },
                  ),
                ),
                Expanded(
                  child: FeatureButton(
                    btnIcon: Icons.send,
                    btnName: 'Transfer',
                    onPress: () {},
                  ),
                ),
              ],
            ),

            ///  Transaction.
            Text(
              'Transaction',
              style: AppTypography.lightTheme.titleMedium,
            ),

            ListView.separated(
              itemBuilder: (context, index) => TransactionTile(),
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey,),
              itemCount: 5,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
