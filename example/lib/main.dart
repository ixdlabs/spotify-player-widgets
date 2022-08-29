import 'package:flutter/material.dart';
import 'package:spotify_player_widgets/spotify_player_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify  Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SpotifyWidgetDemo(),
    );
  }
}

class SpotifyWidgetDemo extends StatelessWidget {
  const SpotifyWidgetDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ClientCredentials clientCredentials = ClientCredentials(
        clientId: "c7fa04889aa64a7ab5b62703c5307d46",
        redirectUrl: "http://localhost:8889/callback");
    // final List<PlaylistDetails> playlists = [
    //   PlaylistDetails(
    //       url: "https://open.spotify.com/playlist/6TK6jJIzcjyErNGex4xqYE",
    //       name: "Opi Stephen curry",
    //       coverImageUrl:
    //           "https://st3.depositphotos.com/29618360/31748/i/1600/depositphotos_317483090-free-stock-photo-sunset-danube-delta-flying-birds.jpg"),
    //   PlaylistDetails(
    //       url:
    //           "https://open.spotify.com/playlist/1oljSfrrMYqCyiWu1vtsAu?si=6f09797b27cd4a55",
    //       name: "Bubbles"),
    // ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Spotify Widget Demo"),
        ),
        body: Center(
          child: SpotifyPlayer(clientCredentials: clientCredentials),
        ),
      ),
    );
  }
}
