import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Widget albumImage({required ImageUri image, double height = 160.0}) {
  return Container(
    height: height,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.kSpotifyGrey,
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ]),
    child: FutureBuilder(
        future: SpotifySdk.getImage(
          imageUri: image,
          dimension: ImageDimension.small,
        ),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Image.memory(
                snapshot.data!,
                filterQuality: FilterQuality.medium,
                fit: BoxFit.fill,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load the album cover",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Loading the album cover",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        }),
  );
}
