import 'package:equatable/equatable.dart';

class ShowcaseSettings extends Equatable {
  // first run admin
  final bool firstRunAdmin;
  // first run everybody
  final bool firstRun;

  const ShowcaseSettings({
    required this.firstRunAdmin,
    required this.firstRun,
  });

  @override
  List<Object> get props => [firstRunAdmin, firstRun];

  @override
  String toString() =>
      'ShowcaseSettings(firstRunAdmin: $firstRunAdmin, firstRun: $firstRun)';
}
