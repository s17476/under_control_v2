import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/knowledge_base/data/models/instruction_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/task.dart'
    as custom_task;
import 'package:under_control_v2/features/tasks/domain/entities/task_action/task_action.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

import '../../assets/data/models/asset_model.dart';
import '../../assets/domain/entities/asset.dart';
import '../../assets/domain/entities/asset_action/asset_action.dart';
import '../../assets/domain/entities/asset_category/asset_category.dart';
import '../../checklists/domain/entities/checklist.dart';
import '../../groups/domain/entities/group.dart';
import '../../inventory/domain/entities/item.dart';
import '../../inventory/domain/entities/item_action/item_action.dart';
import '../../inventory/domain/entities/item_category/item_category.dart';
import '../../knowledge_base/domain/entities/instruction_category/instruction_category.dart';
import '../../locations/domain/entities/location.dart';
import '../../notifications/domain/entities/notification_type.dart';
import '../../tasks/domain/entities/work_request/work_request.dart';
import '../error/failures.dart';

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AddUserParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final File? avatar;

  const AddUserParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.avatar,
  });

  @override
  List<Object> get props => [firstName, lastName, phoneNumber];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class VoidResult extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssignParams extends Equatable {
  final String userId;
  final String companyId;

  const AssignParams({
    required this.userId,
    required this.companyId,
  });

  @override
  List<Object> get props => [userId, companyId];
}

class UserAndGroupParams extends Equatable {
  final String userId;
  final String groupId;

  const UserAndGroupParams({
    required this.userId,
    required this.groupId,
  });

  @override
  List<Object> get props => [userId, groupId];
}

class AssignGroupAdminParams extends Equatable {
  final String userId;
  final String groupId;
  final String companyId;

  const AssignGroupAdminParams({
    required this.userId,
    required this.groupId,
    required this.companyId,
  });

  @override
  List<Object> get props => [userId, groupId];
}

class AvatarParams extends Equatable {
  final String id;
  final File avatar;

  const AvatarParams({
    required this.id,
    required this.avatar,
  });

  @override
  List<Object> get props => [id, avatar];
}

class LocationParams extends Equatable {
  final Location location;
  final String comapnyId;

  const LocationParams({
    required this.location,
    required this.comapnyId,
  });

  @override
  List<Object> get props => [location, comapnyId];
}

class SelectedLocationsParams extends Equatable {
  final List<String> locations;
  final List<String> children;

  const SelectedLocationsParams({
    required this.locations,
    required this.children,
  });

  @override
  List<Object> get props => [locations, children];
}

class GroupParams extends Equatable {
  final Group group;
  final String companyId;

  const GroupParams({
    required this.group,
    required this.companyId,
  });

  @override
  List<Object> get props => [group, companyId];
}

class ChecklistParams extends Equatable {
  final Checklist checklist;
  final String companyId;

  const ChecklistParams({
    required this.checklist,
    required this.companyId,
  });

  @override
  List<Object> get props => [checklist, companyId];
}

class ItemParams extends Equatable {
  final Item item;
  final File? photo;
  final List<File>? images;
  final List<File>? documents;
  final String companyId;

  const ItemParams({
    required this.item,
    this.photo,
    this.images,
    this.documents,
    required this.companyId,
  });

  @override
  List<Object> get props => [item, companyId];
}

class WorkRequestParams extends Equatable {
  final WorkRequest workRequest;
  final List<File>? images;
  final File? video;
  final String companyId;

  const WorkRequestParams({
    required this.workRequest,
    this.images,
    this.video,
    required this.companyId,
  });

  @override
  List<Object> get props => [workRequest, companyId];
}

class TaskParams extends Equatable {
  final custom_task.Task task;
  final List<File>? images;
  final File? video;
  final String companyId;

  const TaskParams({
    required this.task,
    this.images,
    this.video,
    required this.companyId,
  });

  @override
  List<Object> get props => [task, companyId];
}

class TaskActionParams extends Equatable {
  final TaskAction taskAction;
  final custom_task.Task task;
  final List<File>? images;
  final UserProfile userProfile;

  const TaskActionParams({
    required this.taskAction,
    required this.task,
    this.images,
    required this.userProfile,
  });

  @override
  List<Object> get props => [taskAction, userProfile];
}

class CodeParams extends Equatable {
  final String internalCode;
  final String companyId;

  const CodeParams({
    required this.internalCode,
    required this.companyId,
  });

  @override
  List<Object> get props => [internalCode, companyId];
}

class IdParams extends Equatable {
  final String id;
  final String companyId;
  const IdParams({
    required this.id,
    required this.companyId,
  });

  @override
  List<Object> get props => [id, companyId];
}

class AssetParams extends Equatable {
  final AssetModel asset;
  final List<File>? images;
  final List<File>? documents;
  final String companyId;
  final String? userId;

  const AssetParams({
    required this.asset,
    this.images,
    this.documents,
    required this.companyId,
    this.userId,
  });

  @override
  List<Object> get props => [asset, companyId];
}

class ItemActionParams extends Equatable {
  final Item updatedItem;
  final ItemAction itemAction;
  final String companyId;

  const ItemActionParams({
    required this.updatedItem,
    required this.itemAction,
    required this.companyId,
  });

  @override
  List<Object> get props => [updatedItem, itemAction, companyId];
}

class AssetActionParams extends Equatable {
  final Asset updatedAsset;
  final AssetAction assetAction;
  final String companyId;

  const AssetActionParams({
    required this.updatedAsset,
    required this.assetAction,
    required this.companyId,
  });

  @override
  List<Object> get props => [updatedAsset, assetAction, companyId];
}

class MoveItemActionParams extends Equatable {
  final Item updatedItem;
  final ItemAction moveFromItemAction;
  final ItemAction moveToItemAction;
  final String companyId;

  const MoveItemActionParams({
    required this.updatedItem,
    required this.moveFromItemAction,
    required this.moveToItemAction,
    required this.companyId,
  });

  @override
  List<Object> get props => [
        updatedItem,
        moveFromItemAction,
        moveToItemAction,
        companyId,
      ];
}

class ItemsInLocationsParams extends Equatable {
  final List<String> locations;
  final String companyId;

  const ItemsInLocationsParams({
    required this.locations,
    required this.companyId,
  });

  @override
  List<Object> get props => [locations, companyId];
}

class AssetsInLocationsParams extends Equatable {
  final List<String> locations;
  final String companyId;

  const AssetsInLocationsParams({
    required this.locations,
    required this.companyId,
  });

  @override
  List<Object> get props => [locations, companyId];
}

class InstructionsInLocationsParams extends Equatable {
  final List<String> locations;
  final String companyId;

  const InstructionsInLocationsParams({
    required this.locations,
    required this.companyId,
  });

  @override
  List<Object> get props => [locations, companyId];
}

class ItemCategoryParams extends Equatable {
  final ItemCategory itemCategory;
  final String companyId;

  const ItemCategoryParams({
    required this.itemCategory,
    required this.companyId,
  });

  @override
  List<Object> get props => [itemCategory, companyId];

  @override
  String toString() =>
      'ItemsCategoriesParams(itemCategory: $itemCategory, companyId: $companyId)';
}

class AssetCategoryParams extends Equatable {
  final AssetCategory assetCategory;
  final String companyId;

  const AssetCategoryParams({
    required this.assetCategory,
    required this.companyId,
  });

  @override
  List<Object> get props => [assetCategory, companyId];

  @override
  String toString() =>
      'AssetCategoryParams(assetCategory: $assetCategory, companyId: $companyId)';
}

class InstructionCategoryParams extends Equatable {
  final InstructionCategory instructionCategory;
  final String companyId;

  const InstructionCategoryParams({
    required this.instructionCategory,
    required this.companyId,
  });

  @override
  List<Object> get props => [instructionCategory, companyId];

  @override
  String toString() =>
      'InstructionCategoryParams(instructionCategory: $instructionCategory, companyId: $companyId)';
}

class InstructionParams extends Equatable {
  final InstructionModel instruction;
  final String companyId;

  const InstructionParams({
    required this.instruction,
    required this.companyId,
  });

  @override
  List<Object> get props => [instruction, companyId];

  @override
  String toString() =>
      'InstructionParams(instruction: $instruction, companyId: $companyId)';
}

class SelectedGroupsParams extends Equatable {
  final List<String> groups;

  const SelectedGroupsParams({
    required this.groups,
  });

  @override
  List<Object> get props => [groups];
}

class UserProfileParams extends Equatable {
  final UserProfile userProfile;

  const UserProfileParams({required this.userProfile});

  @override
  List<Object> get props => [userProfile];
}

class NotificationSettingsParams extends Equatable {
  final String userId;
  final NotificationType type;
  final bool value;

  const NotificationSettingsParams({
    required this.userId,
    required this.type,
    required this.value,
  });

  @override
  List<Object> get props => [userId, type, value];
}
