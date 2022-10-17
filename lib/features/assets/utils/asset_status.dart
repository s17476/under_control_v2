enum AssetStatus {
  ok('ok'),
  workingRequiresAttention('workingAttention'),
  workingRequiresReparation('workingReparation'),
  notWorkingRequiresReparation('notWorkingReparation'),
  disposed('disposed'),
  unknown('');

  final String name;

  const AssetStatus(this.name);

  factory AssetStatus.fromString(String name) {
    switch (name) {
      case 'ok':
        return AssetStatus.ok;
      case 'workingAttention':
        return AssetStatus.workingRequiresAttention;
      case 'workingReparation':
        return AssetStatus.workingRequiresReparation;
      case 'notWorkingReparation':
        return AssetStatus.notWorkingRequiresReparation;
      case 'disposed':
        return AssetStatus.disposed;
      default:
        return AssetStatus.unknown;
    }
  }
}
