extension ToFormatedString on Duration {
  String toFormatedString() {
    if (inMinutes <= 0) {
      return '';
    } else if (inHours == 0) {
      return '${inMinutes}m';
    } else {
      return '${inHours}h ${inMinutes % 60}m';
    }
  }
}
