import '../../domain/entities/feature.dart';

// ignore: must_be_immutable
class FeatureModel extends Feature {
  FeatureModel({
    required super.type,
    required super.create,
    required super.read,
    required super.edit,
    required super.delete,
  });

  void toggleRead() {
    read = !read;
    if (create) {
      create = false;
    }
    if (edit) {
      edit = false;
    }
    if (delete) {
      delete = false;
    }
  }

  void toggleCreate() {
    create = !create;
    if (!read) {
      read = true;
    }
    if (edit) {
      edit = false;
    }
    if (delete) {
      delete = false;
    }
  }

  void toggleEdit() {
    edit = !edit;
    if (!read) {
      read = true;
    }
    if (!create) {
      create = true;
    }
    if (delete) {
      delete = false;
    }
  }

  void toggleDelete() {
    delete = !delete;
    if (!read) {
      read = true;
    }
    if (!create) {
      create = true;
    }
    if (!edit) {
      edit = true;
    }
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type.name});
    result.addAll({'create': create});
    result.addAll({'read': read});
    result.addAll({'edit': edit});
    result.addAll({'delete': delete});

    return result;
  }

  factory FeatureModel.fromMap(Map<String, dynamic> map) {
    return FeatureModel(
      type: FeatureType.fromString(map['type']),
      create: map['create'] ?? false,
      read: map['read'] ?? false,
      edit: map['edit'] ?? false,
      delete: map['delete'] ?? false,
    );
  }

  FeatureModel copyWith({
    FeatureType? type,
    bool? create,
    bool? read,
    bool? edit,
    bool? delete,
  }) {
    return FeatureModel(
      type: type ?? this.type,
      create: create ?? this.create,
      read: read ?? this.read,
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
    );
  }
}
