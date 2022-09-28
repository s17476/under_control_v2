enum ContentType {
  url('url'),
  image('image'),
  video('video'),
  youtube('youtube'),
  unknown('');

  final String name;

  const ContentType(this.name);

  factory ContentType.fromString(String name) {
    switch (name) {
      case 'url':
        return ContentType.url;
      case 'image':
        return ContentType.image;
      case 'video':
        return ContentType.video;
      case 'youtube':
        return ContentType.youtube;
      default:
        return ContentType.unknown;
    }
  }
}
