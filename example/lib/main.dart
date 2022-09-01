import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_player_widgets/spotify_player_widgets.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Players Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Example App")),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SpotifyPlayerWidgetDemo(),
                        )),
                    child: const Text("Spotify Player Widget"),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SpotifyMiniPlayerWidgetDemo(),
                        )),
                    child: const Text("Spotify Mini Player Widget"),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SpotifyPlaylistPlayerWidgetDemo(),
                        )),
                    child: const Text("Spotify Playlist Player Widget"),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class SpotifyPlayerWidgetDemo extends StatelessWidget {
  const SpotifyPlayerWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NOTE: dotenv isn't required to work with this package, you can simply add the secrets here.
    final ClientCredentials clientCredentials = ClientCredentials(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Spotify Player Demo")),
        ),
        body: Center(
          child: SpotifyPlayer(clientCredentials: clientCredentials),
        ),
      ),
    );
  }
}

class SpotifyMiniPlayerWidgetDemo extends StatelessWidget {
  const SpotifyMiniPlayerWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientCredentials clientCredentials = ClientCredentials(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Spotify Player Demo")),
        ),
        body: Center(
          child: SpotifyMiniPlayer(clientCredentials: clientCredentials),
        ),
      ),
    );
  }
}

class SpotifyPlaylistPlayerWidgetDemo extends StatelessWidget {
  const SpotifyPlaylistPlayerWidgetDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientCredentials clientCredentials = ClientCredentials(
        clientId: dotenv.env['CLIENT_ID'].toString(),
        redirectUrl: dotenv.env['REDIRECT_URL'].toString());
    final List<PlaylistDetails> playlists = [
      PlaylistDetails(
          url: "https://open.spotify.com/playlist/6TK6jJIzcjyErNGex4xqYE",
          name: "Opi Stephen curry",
          coverImageUrl:
              "https://st3.depositphotos.com/29618360/31748/i/1600/depositphotos_317483090-free-stock-photo-sunset-danube-delta-flying-birds.jpg"),
      PlaylistDetails(
          url:
              "https://open.spotify.com/playlist/1oljSfrrMYqCyiWu1vtsAu?si=6f09797b27cd4a55",
          name: "Bubbles"),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Spotify Player Demo")),
        ),
        body: Center(
          child: SpotifyPlaylistPlayer(
            clientCredentials: clientCredentials,
            playlists: playlists,
          ),
        ),
      ),
    );
  }
}
