class PlaylistDetails {
  final String url;
  final String name;
  final String? coverImageUrl;

  PlaylistDetails({
    required this.url,
    required this.name,
    this.coverImageUrl,
  });
}
