import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Widget albumImageSmall({required ImageUri image}) {
  return Container(
    height: 80.0,
    width: 80.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: FutureBuilder(
        future: SpotifySdk.getImage(
          imageUri: image,
          dimension: ImageDimension.small,
        ),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
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
