import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_player_widgets/src/components/album_image_small.dart';
import 'package:spotify_player_widgets/src/components/player_controls_row.dart';
import 'package:spotify_player_widgets/src/components/recommendation.dart';
import 'package:spotify_player_widgets/src/components/song_progress_indicator.dart';
import 'package:spotify_player_widgets/src/components/spotify_connection_status.dart';
import 'package:spotify_player_widgets/src/constants/asset_constants.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';
import 'package:spotify_player_widgets/src/services/song_progress_indicator_handler.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_player_widgets/src/services/spotify_service_implementation.dart';
import 'package:spotify_player_widgets/src/user_classes/client_credentials.dart';
import 'package:spotify_player_widgets/src/user_classes/playlist_details.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';

class SpotifyPlaylistPlayer extends StatefulWidget {
  final List<PlaylistDetails> playlists;
  final ClientCredentials clientCredentials;

  const SpotifyPlaylistPlayer(
      {Key? key, required this.playlists, required this.clientCredentials})
      : super(key: key);

  @override
  State<SpotifyPlaylistPlayer> createState() => _SpotifyPlaylistPlayerState();
}

class _SpotifyPlaylistPlayerState extends State<SpotifyPlaylistPlayer> {
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
            height: 500.0,
            width: 350.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              color: Colors.black54.withOpacity(0.5),
            ),
            child: _loading
                ? loadingSpotifyConnection()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<PlayerState>(
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
                                const SizedBox(height: 15.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 10.0,
                                  ),
                                  child: SongDetails(track: track),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: SongProgressIndicator(
                                    songDuration: track.duration,
                                    songProgressIndicatorHandler:
                                        songProgressHandler,
                                    isPlaying: !playerState.isPaused,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white38,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                PlayerControlsRow(
                                    spotifyService: spotifyService,
                                    playerState: playerState,
                                    spHandler: songProgressHandler),
                                const SizedBox(height: 15),
                                PlaylistContainer(
                                  widget: widget,
                                  spotifyService: spotifyService,
                                  songProgressHandler: songProgressHandler,
                                ),
                                const SizedBox(height: 15.0),
                                spotifyLogo(),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
          ),
        );
      },
    );
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

class PlaylistContainer extends StatelessWidget {
  const PlaylistContainer({
    Key? key,
    required this.widget,
    required this.spotifyService,
    required this.songProgressHandler,
  }) : super(key: key);

  final SpotifyPlaylistPlayer widget;
  final SpotifyService spotifyService;
  final SongProgressIndicatorHandler songProgressHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.kSpotifyBlack,
        height: 230.0,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Recommendation(
                  playlists: widget.playlists,
                  spotifyService: spotifyService,
                  spHandler: songProgressHandler,
                ),
              )
            ],
          ),
        ));
  }
}

class SongDetails extends StatelessWidget {
  final Track track;
  const SongDetails({
    Key? key,
    required this.track,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        albumImageSmall(image: track.imageUri),
        const SizedBox(width: 15.0),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                track.name.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                track.artist.name ?? "",
                style: const TextStyle(fontSize: 14.0, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget spotifyLogo() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        AssetConstants.kSpotifyLogo,
        width: 30.0,
        height: 30.0,
        color: Colors.white,
      ),
      const SizedBox(width: 8),
      const Text(
        "Spotify",
        style: TextStyle(fontSize: 16.0, color: Colors.white54),
      ),
    ],
  );
}
