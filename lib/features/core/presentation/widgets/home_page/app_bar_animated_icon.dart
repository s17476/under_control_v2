import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/blocs/items_management/items_management_bloc.dart';
import '../../../../knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart';

class AppBarAnimatedIcon extends StatefulWidget {
  const AppBarAnimatedIcon({Key? key}) : super(key: key);

  @override
  State<AppBarAnimatedIcon> createState() => _AppBarAnimatedIconState();
}

class _AppBarAnimatedIconState extends State<AppBarAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotateY;

  void _stopAnimation() {
    if (_animationController.isAnimating) {
      _animationController.animateTo(0);
    }
  }

  void _startAnimation() {
    if (!_animationController.isAnimating) {
      _animationController.repeat();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _rotateY = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ItemsBloc, ItemsState>(
          listener: (context, state) {
            if (state is ItemsLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
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
        BlocListener<FilterBloc, FilterState>(
          listener: (context, state) {
            if (state is FilterLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<InstructionBloc, InstructionState>(
          listener: (context, state) {
            if (state is InstructionLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<InstructionManagementBloc, InstructionManagementState>(
          listener: (context, state) {
            if (state is InstructionManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
      ],
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final child = Image.asset('assets/under_control_menu_icon.png');

          return Transform(
            transform: Matrix4.rotationY(_rotateY.value * 2 * math.pi),
            alignment: Alignment.center,
            child: child,
          );
        },
      ),
    );
  }
}
