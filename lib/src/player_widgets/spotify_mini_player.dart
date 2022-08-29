import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_player_widgets/src/components/album_image.dart';
import 'package:spotify_player_widgets/src/components/simple_player_controls_row.dart';
import 'package:spotify_player_widgets/src/components/spotify_connection_status.dart';
import 'package:spotify_player_widgets/src/constants/asset_constants.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_player_widgets/src/services/spotify_service_implementation.dart';
import 'package:spotify_player_widgets/src/user_classes/client_credentials.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';

class SpotifyMiniPlayer extends StatefulWidget {
  final ClientCredentials clientCredentials;

  const SpotifyMiniPlayer({Key? key, required this.clientCredentials})
      : super(key: key);

  @override
  State<SpotifyMiniPlayer> createState() => _SpotifyMiniPlayerState();
}

class _SpotifyMiniPlayerState extends State<SpotifyMiniPlayer> {
  final SpotifyService spotifyService = SpotifyServiceImpl();
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
              height: 240.0,
              width: 235.0,
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
                          var track = snapshot.data?.track;
                          var playerState = snapshot.data;
                          if (playerState == null || track == null) {
                            return spotifyConnectionFailed();
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: albumImage(
                                        image: track.imageUri,
                                        height: 150.0,
                                      ),
                                    ),
                                    spotifyIcon(),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(child: SongInfo(track: track)),
                                    const SizedBox(width: 8.0),
                                    PlayerControls(
                                      playerState: playerState,
                                      spotifyService: spotifyService,
                                    ),
                                  ],
                                )
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

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    Key? key,
    required this.playerState,
    required this.spotifyService,
  }) : super(key: key);

  final PlayerState playerState;
  final SpotifyService spotifyService;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: ColorConstants.kSpotifyGrey,
      ),
      child: SimplePlayerControlRow(
        playerState: playerState,
        spotifyService: spotifyService,
      ),
    );
  }
}

class SongInfo extends StatelessWidget {
  const SongInfo({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          track.name.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          track.artist.name ?? "",
          style: const TextStyle(fontSize: 12.0, color: Colors.grey),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

Widget spotifyIcon() {
  return Positioned(
    right: 5.0,
    top: 5.0,
    child: SvgPicture.asset(
      AssetConstants.kSpotifyLogo,
      width: 28.0,
      height: 28.0,
      color: ColorConstants.kSpotifyBlack,
    ),
  );
}
