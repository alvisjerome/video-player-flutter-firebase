import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';

import '../../utils/props.dart';
import './controls.dart';

class Player extends StatefulWidget {
  const Player();

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController _controller;
  CameraController _cameraController;
  var cameraPosition;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(Props.videoUrl)
      ..addListener(() {
        if (mounted) setState(() {});
      })
      ..initialize().then((_) => _controller.play());

    enableLandscape();

    cameraInit();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _cameraController.dispose();

    setOrientationsHandler();
  }

  void cameraInit() async {
    final availableCamera = await availableCameras();
    _cameraController =
        CameraController(availableCamera[1], ResolutionPreset.max)
          ..initialize();
  }

  void enableLandscape() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void setOrientationsHandler() async {
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && _controller.value.isInitialized) {
      final size = _controller.value.size;
      return Container(
        alignment: Alignment.topCenter,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            VideoControls(
              controller: _controller,
            ),
            positionedCamera()
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  //resuable widgets

  Widget positionedCamera() {
    if (cameraPosition != null) {
      return Positioned(
          left: cameraPosition?.dx,
          top: cameraPosition?.dy,
          child: draggbleCamera());
    } else {
      return Positioned(
        bottom: 10,
        right: 10,
        child: draggbleCamera(),
      );
    }
  }

  Widget draggbleCamera() {
    return Draggable(
        onDragEnd: (val) {
          setState(() {
            cameraPosition = val.offset;
          });
        },
        child: appCamera(),
        feedback: appCamera());
  }

  Widget appCamera() {
    if (_cameraController?.value?.isInitialized != null) {
      return SizedBox(
        width: 150,
        height: 100,
        child: CameraPreview(_cameraController),
      );
    } else {
      return SizedBox();
    }
  }
}
