import 'package:flutter/material.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_sdk/models/player_state.dart';

class SimplePlayerControlRow extends StatelessWidget {
  const SimplePlayerControlRow({
    Key? key,
    required this.playerState,
    required this.spotifyService,
  }) : super(key: key);

  final PlayerState playerState;
  final SpotifyService spotifyService;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        playerState.isPaused
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: spotifyService.resume,
                icon: const Icon(Icons.play_circle_filled_rounded,
                    color: Colors.white, size: 50.0),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: spotifyService.pause,
                icon: const Icon(Icons.pause_circle_filled_rounded,
                    color: Colors.white, size: 50.0),
              ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: spotifyService.skipNext,
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 45.0,
          ),
        ),
      ],
    );
  }
}
