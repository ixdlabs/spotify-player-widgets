A Fluitter package that provides Spotify player widgets, which can be used to seamlessly connect with your Spotify app.




## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

#### Widget Demos


<p>
  <img src="https://github.com/ixdlabs/spotify-player-widgets/blob/master/previews/spotify_player.gif?raw=true"
    alt="Spotify player" height="400"/>
   &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/ixdlabs/spotify-player-widgets/blob/master/previews/spotify_mini_player.gif?raw=true"
   alt="Spotify mini player" height="400"/>
   &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/ixdlabs/spotify-player-widgets/blob/master/previews/spotify_playlist_player.gif?raw=true"
   alt="Spotify mini player" height="400"/>
</p>

#### Example App Demo


 <img src="https://github.com/ixdlabs/spotify-player-widgets/blob/master/previews/example_app.gif?raw=true"
   alt="Spotify mini player" height="400"/>

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage
You can import the package as follows,

```dart
import 'package:spotify_player_widgets/spotify_player_widgets.dart';
```
#### Example : SpotifyPlayer widget

```dart
class SpotifyPlayerDemo extends StatelessWidget {
   SpotifyPlayerDemo({Key? key}) : super(key: key);

  final ClientCredentials clientCredentials = ClientCredentials(
      clientId:<CLIENT_ID>,
      redirectUrl: <REDIRECT_URL>);
  @override
  Widget build(BuildContext context) {
    return  SpotifyPlayer(clientCredentials: clientCredentials);
  }
}
```

#### Example : SpotifyMiniPlayer widget

```dart
class SpotifyMiniPlayerDemo extends StatelessWidget {
  SpotifyMiniPlayerDemo({Key? key}) : super(key: key);

  final ClientCredentials clientCredentials = ClientCredentials(
      clientId:<CLIENT_ID>,
      redirectUrl: <REDIRECT_URL>);
  @override
  Widget build(BuildContext context) {
    return  SpotifyMiniPlayer(clientCredentials: clientCredentials);
  }
}
```

#### Example : SpotifyPlaylistPlayer widget

```dart
class SpotifyPlaylistPlayerDemo extends StatelessWidget {
  SpotifyPlaylistPlayerDemo({Key? key}) : super(key: key);
  final ClientCredentials clientCredentials = ClientCredentials(
      clientId:<CLIENT_ID>,
      redirectUrl: <REDIRECT_URL>);

  final List<PlaylistDetails> playlists = [
    PlaylistDetails(
        url: "playlist URL",
        name: "playlist name",
        coverImageUrl: "playlist cover image URL - Optional"),
  ];

  @override
  Widget build(BuildContext context) {
    return SpotifyPlaylistPlayer(playlists: playlists, clientCredentials: clientCredentials);
  }

}
```
## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
