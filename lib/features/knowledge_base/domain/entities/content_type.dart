enum ContentType {
  url('url'),
  image('image'),
  video('video'),
  youtube('youtube'),
  pdf('pdf'),
  text('text'),
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
      case 'pdf':
        return ContentType.pdf;
      case 'text':
        return ContentType.text;
      default:
        return ContentType.unknown;
    }
  }
}
