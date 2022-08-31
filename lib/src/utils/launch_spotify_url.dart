import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

Logger _log = Logger("launch_spotify_url");

Future<void> launchSpotifyUrl(String url) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e, st) {
    _log.severe("Failed to open the Spotify Url", st);
  }
}
