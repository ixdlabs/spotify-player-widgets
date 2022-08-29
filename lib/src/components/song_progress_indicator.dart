import 'package:flutter/material.dart';
import 'package:spotify_player_widgets/src/constants/colors.dart';
import 'package:spotify_player_widgets/src/services/song_progress_indicator_handler.dart';

class SongProgressIndicator extends StatefulWidget {
  final int songDuration;
  final SongProgressIndicatorHandler songProgressIndicatorHandler;
  final bool isPlaying;
  final Color activeColor;
  final Color inactiveColor;
  const SongProgressIndicator({
    Key? key,
    required this.songDuration,
    required this.songProgressIndicatorHandler,
    required this.isPlaying,
    this.activeColor = ColorConstants.kSpotifyGreen,
    this.inactiveColor = ColorConstants.kSpotifyGrey,
  }) : super(key: key);

  @override
  State<SongProgressIndicator> createState() => _SongProgressIndicatorState();
}

class _SongProgressIndicatorState extends State<SongProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.songDuration),
    )..addListener(() {
        setState(() {});
      });
    if (widget.isPlaying) {
      controller.forward();
    }
    widget.songProgressIndicatorHandler.attachPauseHandler(() {
      controller.stop();
    });
    widget.songProgressIndicatorHandler.attachResumeHandler(() {
      controller.forward();
    });
    widget.songProgressIndicatorHandler.attachStartHandler(() {
      controller.reset();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        value: controller.value,
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}
