import 'package:flutter/material.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';

Widget spotifyConnectionFailed() {
  return const Center(
    child: Text(
      "Couldn't open Spotify",
      style: TextStyle(color: Colors.white, fontSize: 15.0),
    ),
  );
}

Widget loadingSpotifyConnection() {
  return const Center(
      child: CircularProgressIndicator(
    color: ColorConstants.kSpotifyGreen,
  ));
}
