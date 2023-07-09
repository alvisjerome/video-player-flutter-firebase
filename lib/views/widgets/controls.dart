import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoControls({@required this.controller});

  @override
  _VideoControlsState createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  var volume = 20.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setVolume(volume);
    });
  }

  void setVolume(double val) async {
    await widget.controller.setVolume(val);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.controller.value.isPlaying
            ? widget.controller.pause()
            : widget.controller.play();
      },
      child: Stack(
        children: <Widget>[
          if (!widget.controller.value.isPlaying)
            Container(
              alignment: Alignment.center,
              color: Colors.black26,
              child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(
              widget.controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                  playedColor: Theme.of(context).accentColor),
            ),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              top: 0,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Expanded(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Slider(
                          activeColor: Theme.of(context).primaryColor,
                          value: volume,
                          min: 0,
                          max: 100,
                          inactiveColor: Theme.of(context).accentColor,
                          onChanged: (val) {
                            volume = val;
                            setVolume(volume);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "${volume.toInt()}",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
