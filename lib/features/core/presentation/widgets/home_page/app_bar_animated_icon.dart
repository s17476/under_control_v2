import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/blocs/asset_action/asset_action_bloc.dart';
import '../../../../assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart';
import '../../../../assets/presentation/blocs/asset_category/asset_category_bloc.dart';
import '../../../../assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart';
import '../../../../assets/presentation/blocs/asset_management/asset_management_bloc.dart';
import '../../../../company_profile/presentation/blocs/company_management/company_management_bloc.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../inventory/presentation/blocs/item_action/item_action_bloc.dart';
import '../../../../inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart';
import '../../../../inventory/presentation/blocs/item_category/item_category_bloc.dart';
import '../../../../inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart';
import '../../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';
import '../../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../../inventory/presentation/blocs/items_management/items_management_bloc.dart';
import '../../../../knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart';
import '../../../../knowledge_base/presentation/blocs/instruction_category_management/instruction_category_management_bloc.dart';
import '../../../../knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/presentation/blocs/user_management/user_management_bloc.dart';

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
        BlocListener<InstructionCategoryManagementBloc,
            InstructionCategoryManagementState>(
          listener: (context, state) {
            if (state is InstructionCategoryManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<InstructionCategoryBloc, InstructionCategoryState>(
          listener: (context, state) {
            if (state is InstructionCategoryLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<ItemActionManagementBloc, ItemActionManagementState>(
          listener: (context, state) {
            if (state is ItemActionManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<ItemActionBloc, ItemActionState>(
          listener: (context, state) {
            if (state is ItemActionLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<ItemCategoryManagementBloc, ItemCategoryManagementState>(
          listener: (context, state) {
            if (state is ItemCategoryManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<ItemCategoryBloc, ItemCategoryState>(
          listener: (context, state) {
            if (state is ItemCategoryLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<GroupBloc, GroupState>(
          listener: (context, state) {
            if (state is GroupLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is LocationLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<CompanyManagementBloc, CompanyManagementState>(
          listener: (context, state) {
            if (state is CompanyManagementLoading) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<CompanyProfileBloc, CompanyProfileState>(
          listener: (context, state) {
            if (state is CompanyProfileLoading) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<UserManagementBloc, UserManagementState>(
          listener: (context, state) {
            if (state is UserManagementLoading) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
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
        BlocListener<AssetCategoryBloc, AssetCategoryState>(
          listener: (context, state) {
            if (state is AssetCategoryLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<AssetCategoryManagementBloc, AssetCategoryManagementState>(
          listener: (context, state) {
            if (state is AssetCategoryManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<AssetActionBloc, AssetActionState>(
          listener: (context, state) {
            if (state is AssetActionLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<AssetActionManagementBloc, AssetActionManagementState>(
          listener: (context, state) {
            if (state is AssetActionManagementLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<AssetBloc, AssetState>(
          listener: (context, state) {
            if (state is AssetLoadingState) {
              _startAnimation();
            } else {
              _stopAnimation();
            }
          },
        ),
        BlocListener<AssetManagementBloc, AssetManagementState>(
          listener: (context, state) {
            if (state is AssetManagementLoadingState) {
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
