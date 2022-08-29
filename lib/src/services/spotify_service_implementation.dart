import 'package:logging/logging.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_player_widgets/src/user_classes/client_credentials.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Logger _log = Logger("spotify_service");

class SpotifyServiceImpl extends SpotifyService {
  @override
  Future<void> connectToSpotify(ClientCredentials clientCredentials) async {
    try {
      await SpotifySdk.connectToSpotifyRemote(
        clientId: clientCredentials.clientId,
        redirectUrl: clientCredentials.redirectUrl,
      );
    } catch (e, st) {
      _log.severe("Failed connect to spotify remote", e, st);
    }
  }

  @override
  Stream<ConnectionStatus> subscribeConnectionStatus() {
    try {
      return SpotifySdk.subscribeConnectionStatus();
    } catch (e, st) {
      _log.severe("Failed subscribe to connection status", e, st);
      rethrow;
    }
  }

  @override
  Stream<PlayerState> subscribePlayerState() {
    return SpotifySdk.subscribePlayerState();
  }

  @override
  Future<void> play(String? trackUri) async {
    try {
      await SpotifySdk.play(spotifyUri: trackUri ?? "");
    } catch (e, st) {
      _log.severe("Failed play the given track", e, st);
    }
  }

  @override
  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } catch (e, st) {
      _log.severe("Failed pause the current track", e, st);
    }
  }

  @override
  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } catch (e, st) {
      _log.severe("Failed resume the current track", e, st);
    }
  }

  @override
  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } catch (e, st) {
      _log.severe("Failed skip to the next track", e, st);
    }
  }

  @override
  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } catch (e, st) {
      _log.severe("Failed skip to the previous track", e, st);
    }
  }
}
