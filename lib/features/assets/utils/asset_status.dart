enum AssetStatus {
  ok('ok'),
  workingRequiresAttention('workingAttention'),
  notWorkingRequiresReparation('notWorkingReparation'),
  disposed('disposed'),
  noInspection('noInspection'),
  unknown('');

  final String name;

  const AssetStatus(this.name);

  factory AssetStatus.fromString(String name) {
    switch (name) {
      case 'ok':
        return AssetStatus.ok;
      case 'workingAttention':
        return AssetStatus.workingRequiresAttention;
      case 'notWorkingReparation':
        return AssetStatus.notWorkingRequiresReparation;
      case 'disposed':
        return AssetStatus.disposed;
      case 'noInspection':
        return AssetStatus.noInspection;
      default:
        return AssetStatus.unknown;
    }
  }
}
