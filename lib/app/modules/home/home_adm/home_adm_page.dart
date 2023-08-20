import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../widgets/home_header.dart';
import 'widgets/home_employee_tile.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: PhosphorIcon(
          PhosphorIcons.fill.plusCircle,
          color: Colors.white,
          size: 28,
        ),
      ),
      body: CustomScrollView(
        // physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 13,
              (context, index) {
                return const HomeEmployeeTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}
