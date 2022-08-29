import 'package:flutter/material.dart';
import 'package:spotify_player_widgets/src/services/song_progress_indicator_handler.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_sdk/models/player_state.dart';


class PlayerControlsRow extends StatelessWidget {
  final SpotifyService spotifyService;
  final PlayerState playerState;
  final SongProgressIndicatorHandler spHandler;
  const PlayerControlsRow(
      {Key? key,
      required this.spotifyService,
      required this.playerState,
      required this.spHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            await spotifyService.skipPrevious();
            spHandler.start();
            spHandler.resume();
          },
          icon: const Icon(
            Icons.skip_previous,
            color: Colors.white,
            size: 50.0,
          ),
        ),
        playerState.isPaused
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await spotifyService.resume();
                  spHandler.resume();
                },
                icon: const Icon(Icons.play_circle_filled_rounded,
                    color: Colors.white, size: 50.0),
              )
            : IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await spotifyService.pause();
                  spHandler.pause();
                },
                icon: const Icon(Icons.pause_circle_filled_rounded,
                    color: Colors.white, size: 50.0),
              ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            await spotifyService.skipNext();
            spHandler.start();
            spHandler.resume();
          },
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ],
    );
  }
}
