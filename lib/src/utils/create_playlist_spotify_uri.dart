String createPlaylistSpotifyUri(String url) {
  String baseUri = "spotify:playlist:";
  var queryParamsRemovedUrl = url.split("?")[0];
  var playlistId = queryParamsRemovedUrl.split("/").last;
  baseUri += playlistId;

  return baseUri;
}
