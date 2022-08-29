import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_player_widgets/src/components/album_image.dart';
import 'package:spotify_player_widgets/src/components/player_controls_row.dart';
import 'package:spotify_player_widgets/src/components/song_progress_indicator.dart';
import 'package:spotify_player_widgets/src/components/spotify_connection_status.dart';
import 'package:spotify_player_widgets/src/constants/asset_constants.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';
import 'package:spotify_player_widgets/src/services/song_progress_indicator_handler.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_player_widgets/src/services/spotify_service_implementation.dart';
import 'package:spotify_player_widgets/src/user_classes/client_credentials.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/player_state.dart';

class SpotifyPlayer extends StatefulWidget {
  final ClientCredentials clientCredentials;
  const SpotifyPlayer({Key? key, required this.clientCredentials})
      : super(key: key);

  @override
  State<SpotifyPlayer> createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {
  final SpotifyService spotifyService = SpotifyServiceImpl();
  final SongProgressIndicatorHandler songProgressHandler =
      SongProgressIndicatorHandler();
  bool _loading = false;

  @override
  void initState() {
    _connectToSpotify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionStatus>(
        stream: spotifyService.subscribeConnectionStatus(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 300.0,
              width: 250.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorConstants.kSpotifyBlack,
              ),
              child: _loading
                  ? loadingSpotifyConnection()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<PlayerState>(
                        stream: spotifyService.subscribePlayerState(),
                        builder: (BuildContext context,
                            AsyncSnapshot<PlayerState> snapshot) {
                          var playerState = snapshot.data;
                          var track = snapshot.data?.track;
                          if (playerState == null || track == null) {
                            return spotifyConnectionFailed();
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                albumImage(image: track.imageUri),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        track.name.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    SvgPicture.asset(
                                      AssetConstants.kSpotifyLogo,
                                      width: 28.0,
                                      height: 28.0,
                                      color: ColorConstants.kSpotifyGreen,
                                    ),
                                  ],
                                ),
                                Text(
                                  track.artist.name ?? "",
                                  style: const TextStyle(
                                      fontSize: 11.0, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6.0),
                                SongProgressIndicator(
                                  songDuration: track.duration,
                                  songProgressIndicatorHandler:
                                      songProgressHandler,
                                  isPlaying: !playerState.isPaused,
                                ),
                                const SizedBox(height: 6.0),
                                PlayerControlsRow(
                                  spotifyService: spotifyService,
                                  playerState: playerState,
                                  spHandler: songProgressHandler,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
            ),
          );
        });
  }

  void _connectToSpotify() async {
    setState(() {
      _loading = true;
    });

    await spotifyService.connectToSpotify(widget.clientCredentials);
    setState(() {
      _loading = false;
    });
  }
}
