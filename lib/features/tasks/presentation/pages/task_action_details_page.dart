import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/widgets/asset_tile.dart';
import '../../../assets/utils/get_asset_status_icon.dart';
import '../../../assets/utils/get_localizae_asset_status_name.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/presentation/widgets/user_info_card.dart';
import '../../../core/utils/location_selection_helpers.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../data/models/task_action/task_action_model.dart';
import '../../data/models/task_action/user_action_model.dart';
import '../blocs/task_action/task_action_bloc.dart';
import '../widgets/add_task/inventory_spare_parts_list_with_quantity.dart';
import '../widgets/participants_list.dart';
import '../widgets/work_request_details/images_tab.dart';

class TaskActionDetailsPage extends StatefulWidget {
  const TaskActionDetailsPage({super.key});

  static const routeName = '/task-action/details';

  @override
  State<TaskActionDetailsPage> createState() => _TaskActionDetailsPageState();
}

class _TaskActionDetailsPageState extends State<TaskActionDetailsPage> {
  TaskActionModel? _taskAction;

  UserProfile? _selectedUser;
  bool _isUserInfoCardVisible = false;

  void _showUserInfoCard(UserProfile selectedUser) {
    _selectedUser = selectedUser;
    setState(() {
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    _selectedUser = null;
    setState(() {
      _isUserInfoCardVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    final taskActionId = (ModalRoute.of(context)?.settings.arguments as String);
    final actionsState = context.watch<TaskActionBloc>().state;
    if (actionsState is TaskActionLoadedState) {
      final taskAction = actionsState.getTaskActionById(taskActionId);
      if (taskAction != null) {
        _taskAction = TaskActionModel.fromTaskAction(taskAction);
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeFormat = DateFormat('dd-MM-yyyy HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.task_action_details),
      ),
      body: _taskAction == null
          ? Center(
              child: Text(AppLocalizations.of(context)!.server_error),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // description
                        ActionDescription(description: _taskAction!.comment),
                        const Divider(
                          thickness: 1.5,
                        ),
                        if (_taskAction!.replacedAssetStatus !=
                            AssetStatus.unknown) ...[
                          ActionAssetStatus(taskAction: _taskAction!),
                          const Divider(
                            thickness: 1.5,
                          ),
                        ],
                        ActionDuration(
                          dateTimeFormat: dateTimeFormat,
                          taskAction: _taskAction,
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        Participants(
                          dateTimeFormat: dateTimeFormat,
                          dateFormat: dateFormat,
                          timeFormat: timeFormat,
                          participants: _taskAction!.usersActions,
                          hideUserInfoCard: _hideUserInfoCard,
                          showUserInfoCard: _showUserInfoCard,
                          isUserInfoCardVisible: _isUserInfoCardVisible,
                        ),
                        // checklist
                        if (_taskAction!.checklist.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          ActionChecklist(taskAction: _taskAction!),
                        ],
                        // images
                        if (_taskAction!.images.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          ActionImages(taskAction: _taskAction!),
                        ],
                        // materials
                        if (_taskAction!.sparePartsItems.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          UsedItems(taskAction: _taskAction!),
                        ],
                        // removed assets spare parts
                        if (_taskAction!.removedPartsAssets.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          RemovedAssets(taskAction: _taskAction!)
                        ],
                        // added assets spare parts
                        if (_taskAction!.addedPartsAssets.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          AddedAssets(taskAction: _taskAction!)
                        ],
                        // replacement asset
                        if (_taskAction!.replacementAssetId.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          ReplacementAsset(taskAction: _taskAction!)
                        ],
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                // user info card
                if (_isUserInfoCardVisible)
                  UserInfoCard(
                    onDismiss: _hideUserInfoCard,
                    user: _selectedUser!,
                  ),
              ],
            ),
    );
  }
}

class ReplacementAsset extends StatelessWidget {
  const ReplacementAsset({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.precision_manufacturing,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.task_connected_asset_replaced,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTitleRow(
                icon: Icons.location_on,
                iconColor: Colors.white,
                iconBackground: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!
                    .task_connected_asset_replaced_location,
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<LocationBloc, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoadedState) {
                    return Text(
                      getBreadcrumbsForLocation(
                        taskAction.replacedAssetLocationId,
                        state.allLocations.allLocations,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: Column(
            children: [
              IconTitleRow(
                icon: Icons.health_and_safety_outlined,
                iconColor: Colors.white,
                iconBackground: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!
                    .task_connected_asset_replaced_status,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      getLocalizedAssetStatusName(
                        context,
                        taskAction.replacedAssetStatus,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: getAssetStatusIcon(
                      context,
                      taskAction.replacedAssetStatus,
                      20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.precision_manufacturing,
            iconColor: Colors.white,
            iconBackground: Theme.of(context).primaryColor,
            title:
                AppLocalizations.of(context)!.task_connected_asset_replaced_by,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            if (state is AssetLoadedState) {
              final replacementAssets =
                  state.getAssetById(taskAction.replacementAssetId);
              if (replacementAssets != null) {
                return AssetTile(asset: replacementAssets, searchQuery: '');
              }
            }
            return const ShimmerItemTile();
          },
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconTitleRow(
                icon: Icons.info_outline,
                iconColor: Colors.white,
                iconBackground: Theme.of(context).primaryColor,
                title: AppLocalizations.of(context)!.important,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppLocalizations.of(context)!.asset_replaced_info,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddedAssets extends StatelessWidget {
  const AddedAssets({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.precision_manufacturing,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.asset_used,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            if (state is AssetLoadedState) {
              final addedAssets = state.allAssets.allAssets
                  .where(
                    (asset) => taskAction.addedPartsAssets.contains(asset.id),
                  )
                  .toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addedAssets.length,
                itemBuilder: (context, index) => AssetTile(
                  asset: addedAssets[index],
                  searchQuery: '',
                ),
              );
            }
            return const ShimmerItemTile();
          },
        ),
      ],
    );
  }
}

class RemovedAssets extends StatelessWidget {
  const RemovedAssets({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.precision_manufacturing,
            iconColor: Colors.white,
            iconBackground: Colors.red.shade900,
            title: AppLocalizations.of(context)!.asset_removed,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskAction.removedPartsAssets.length,
          itemBuilder: (context, index) => AssetTile(
            asset: taskAction.removedPartsAssets[index],
            searchQuery: '',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class UsedItems extends StatelessWidget {
  const UsedItems({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.api,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.task_action_used_items,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        InventorySparePartsListWithQuantity(
          items: taskAction.sparePartsItems,
          showTitle: false,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class ActionImages extends StatelessWidget {
  const ActionImages({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.image,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.asset_add_images_added,
          ),
        ),
        ImagesTab(
          images: taskAction.images,
          isScrollable: false,
        ),
      ],
    );
  }
}

class ActionChecklist extends StatelessWidget {
  const ActionChecklist({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconTitleRow(
            icon: Icons.image,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.checklist,
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: taskAction.checklist.length,
          padding: const EdgeInsets.only(bottom: 16),
          itemBuilder: (context, index) {
            return Container(
              color: (index % 2 == 0) ? null : Colors.black26,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IconTitleRow(
                        icon: Icons.check_circle_outline_outlined,
                        iconColor: Colors.grey.shade200,
                        iconBackground: Theme.of(context).primaryColor,
                        title: taskAction.checklist[index].title,
                      ),
                    ),
                    Icon(
                      taskAction.checklist[index].isChecked
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class Participants extends StatelessWidget {
  const Participants({
    Key? key,
    required this.dateTimeFormat,
    required this.dateFormat,
    required this.timeFormat,
    required this.participants,
    required this.isUserInfoCardVisible,
    required this.showUserInfoCard,
    required this.hideUserInfoCard,
  }) : super(key: key);

  final DateFormat dateTimeFormat;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final List<UserActionModel> participants;
  final bool isUserInfoCardVisible;
  final Function(UserProfile) showUserInfoCard;
  final Function() hideUserInfoCard;

  void _toggleUserInfoCardVisibility(BuildContext context, String userId) {
    if (isUserInfoCardVisible) {
      hideUserInfoCard();
    } else {
      final companyState = context.read<CompanyProfileBloc>().state;
      if (companyState is CompanyProfileLoaded) {
        final user = companyState.getUserById(userId);
        if (user != null) {
          showUserInfoCard(user);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconTitleRow(
            icon: Icons.group,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.task_action_participants,
          ),
          const SizedBox(
            height: 16,
          ),
          ParticipantsList(
            participants: participants,
            toggleParticipantSelection: (userId) =>
                _toggleUserInfoCardVisibility(context, userId),
            updateParticipant: (_) {},
            isEnabled: false,
            isExtendedTimeInfo: true,
            showTotalTime: false,
          ),
        ],
      ),
    );
  }
}

class ActionDuration extends StatelessWidget {
  const ActionDuration({
    Key? key,
    required this.dateTimeFormat,
    required this.taskAction,
  }) : super(key: key);

  final DateFormat dateTimeFormat;
  final TaskActionModel? taskAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconTitleRow(
            icon: Icons.timer_outlined,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.task_action_duration,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: IconTitleRow(
                  icon: Icons.play_arrow,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.from,
                ),
              ),
              Text(dateTimeFormat.format(taskAction!.startTime)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: IconTitleRow(
                  icon: Icons.stop,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.to,
                ),
              ),
              Text(dateTimeFormat.format(taskAction!.stopTime)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: IconTitleRow(
                  icon: Icons.timer_outlined,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.total_time,
                ),
              ),
              Text(taskAction!.getTotalDuration),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionAssetStatus extends StatelessWidget {
  const ActionAssetStatus({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconTitleRow(
            icon: Icons.security,
            iconColor: Colors.white,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.asset_status,
            titleFontSize: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  getLocalizedAssetStatusName(
                    context,
                    taskAction.replacedAssetStatus,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 32,
                width: 32,
                child: getAssetStatusIcon(
                  context,
                  taskAction.replacedAssetStatus,
                  14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ActionDescription extends StatelessWidget {
  const ActionDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTitleRow(
            icon: Icons.info_outline,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.description,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
