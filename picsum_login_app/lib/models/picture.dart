class Picture {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  Picture({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'] as String,
      author: json['author'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      url: json['url'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }
}
