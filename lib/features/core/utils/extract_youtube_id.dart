String extractYoutubeId(String input) {
  final linkRegex = RegExp(
    r'((youtu.*be.*)\/(watch\?v=|embed\/|v|shorts|)(.*?((?=[&#?])|$)))|([a-zA-Z0-9_-]{11})',
    caseSensitive: false,
  );
  String? youtubeId = linkRegex.firstMatch(input)?.group(4) ??
      linkRegex.firstMatch(input)?.group(6);
  return youtubeId ?? '';
}
