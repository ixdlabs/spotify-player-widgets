import 'package:spotify_player_widgets/src/user_classes/client_credentials.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/player_state.dart';

abstract class SpotifyService {
  // Connect to spotify app of the phone
  Future<void> connectToSpotify(ClientCredentials clientCredentials);
  // Play the currently selected track
  Future<void> play(String? trackUri);
  // Pause the currently playing track
  Future<void> pause();
  // Resume the currently stopped track
  Future<void> resume();
  // Skip to the next track in the playlist
  Future<void> skipNext();
  // Skip to the previous track in the playlist
  Future<void> skipPrevious();
  // Get details about the connection status of the Spotify app
  Stream<ConnectionStatus> subscribeConnectionStatus();
  // Get details about the status of the currently playing track
  Stream<PlayerState> subscribePlayerState();
}
