import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_player_widgets/src/constants/asset_constants.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';
import 'package:spotify_player_widgets/src/services/song_progress_indicator_handler.dart';
import 'package:spotify_player_widgets/src/services/spotify_service.dart';
import 'package:spotify_player_widgets/src/user_classes/playlist_details.dart';
import 'package:spotify_player_widgets/src/utils/launch_spotify_url.dart';

class Recommendation extends StatelessWidget {
  final List<PlaylistDetails> playlists;
  final SpotifyService spotifyService;
  final SongProgressIndicatorHandler spHandler;

  const Recommendation(
      {Key? key,
      required this.playlists,
      required this.spotifyService,
      required this.spHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 5),
          const Text(
            "Recommends",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(scrollDirection: Axis.horizontal, children: [
              for (PlaylistDetails playlist in playlists)
                PlaylistCover(
                  playlist: playlist,
                  spotifyService: spotifyService,
                  spHandler: spHandler,
                ),
            ]),
          ),
        ],
      ),
    );
  }
}

class PlaylistCover extends StatelessWidget {
  final PlaylistDetails playlist;
  final SpotifyService spotifyService;
  final SongProgressIndicatorHandler spHandler;
  const PlaylistCover(
      {Key? key,
      required this.playlist,
      required this.spotifyService,
      required this.spHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coverImage = playlist.coverImageUrl;
    return GestureDetector(
      onTap: () async {
        await launchSpotifyUrl(playlist.url);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: coverImage != null
                      ? playlistAlbumCover(coverImage)
                      : playlistCoverPlaceholder()),
              const SizedBox(height: 5.0),
              Flexible(
                child: Text(
                  playlist.name,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget playlistCoverPlaceholder() {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: SvgPicture.asset(
        AssetConstants.kSpotifyLogo,
        color: ColorConstants.kSpotifyGreen,
        width: 40.0,
        height: 40.0,
      ),
    ),
  );
}

Widget playlistAlbumCover(String imageUrl) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: ColorConstants.kSpotifyGreen,
      ),
    ),
  );
}
