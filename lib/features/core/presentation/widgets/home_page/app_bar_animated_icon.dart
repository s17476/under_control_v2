import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';

import '../../../../inventory/presentation/blocs/items_management/items_management_bloc.dart';

class AppBarAnimatedIcon extends StatefulWidget {
  const AppBarAnimatedIcon({Key? key}) : super(key: key);

  @override
  State<AppBarAnimatedIcon> createState() => _AppBarAnimatedIconState();
}

class _AppBarAnimatedIconState extends State<AppBarAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> rotateY;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    rotateY = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _stopAnimation() {
    if (animationController.isAnimating) {
      animationController.animateTo(0);
    }
  }

  void _startAnimation() {
    if (!animationController.isAnimating) {
      animationController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ItemsManagementBloc, ItemsManagementState>(
          listener: (context, state) {
            if (state is ItemsManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<DashboardItemActionBloc, DashboardItemActionState>(
          listener: (context, state) {
            if (state is DashboardItemActionLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
      ],
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final child = Image.asset('assets/under_control_menu_icon.png');

          return Transform(
            transform: Matrix4.rotationY(rotateY.value * 2 * math.pi),
            alignment: Alignment.center,
            child: child,
          );
        },
      ),
    );
  }
}
