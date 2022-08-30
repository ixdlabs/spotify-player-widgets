import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_player_widgets/spotify_player_widgets.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Players Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SpotifyWidgetDemo(),
    );
  }
}

class SpotifyWidgetDemo extends StatelessWidget {
  const SpotifyWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientCredentials clientCredentials = ClientCredentials(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString());

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
          title: const Center(child: Text("Example App")),
        ),
        body: Center(
          child: SpotifyPlayer(clientCredentials: clientCredentials),
        ),
      ),
    );
  }
}
