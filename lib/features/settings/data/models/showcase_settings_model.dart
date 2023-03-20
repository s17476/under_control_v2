import '../../domain/entities/showcase_settings.dart';

class ShowcaseSettingsModel extends ShowcaseSettings {
  const ShowcaseSettingsModel({
    required super.firstRunAdmin,
    required super.firstRun,
  });

  ShowcaseSettingsModel copyWith({
    bool? firstRunAdmin,
    bool? firstRun,
  }) {
    return ShowcaseSettingsModel(
      firstRunAdmin: firstRunAdmin ?? this.firstRunAdmin,
      firstRun: firstRun ?? this.firstRun,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstRunAdmin': firstRunAdmin});
    result.addAll({'firstRun': firstRun});

    return result;
  }

  factory ShowcaseSettingsModel.fromMap(Map<String, dynamic> map) {
    return ShowcaseSettingsModel(
      firstRunAdmin: map['firstRunAdmin'] ?? false,
      firstRun: map['firstRun'] ?? false,
    );
  }

  factory ShowcaseSettingsModel.initial() {
    return const ShowcaseSettingsModel(
      firstRunAdmin: false,
      firstRun: false,
    );
  }

  factory ShowcaseSettingsModel.fromDomain(ShowcaseSettings showcase) {
    return ShowcaseSettingsModel(
      firstRunAdmin: showcase.firstRunAdmin,
      firstRun: showcase.firstRun,
    );
  }
}
