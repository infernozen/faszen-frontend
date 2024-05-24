import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart';

class MediaResultWidget extends StatefulWidget {
  final String filePath;
  final String fileType;

  const MediaResultWidget(
      {super.key, required this.filePath, required this.fileType});

  @override
  State<MediaResultWidget> createState() => _CameraResultWidgetState();
}

class _CameraResultWidgetState extends State<MediaResultWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.duration == _controller.value.position)) {
        //checking the duration and position every time
        setState(() {
          if (kDebugMode) {
            print(
                "*************** video paying  c o m p l e t e d *******************");
          }
        });
      }
    });
  }

  Future<void> _downloadFile() async {
    try {
      final dir = await getExternalStorageDirectory();
      if (dir != null) {
        final file = File('${dir.path}/${widget.filePath.split('/').last}');
        await Dio().download(widget.filePath, file.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded to ${file.path}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file: $e')),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      elevation: 5,
      backgroundColor: Colors.black,
      shadowColor: Colors.black,
      titleSpacing: 0,
      title: Row(
        children: [
          const Text(
            "Result",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => {_downloadFile},
            icon: Icon(
              Icons.download,
              size: MediaQuery.of(context).size.height * 0.0325,
              color: Colors.white,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        ],
      ),
      leading: Center(
        child: IconButton(
          icon: Icon(
            Icons.chevron_left_sharp,
            size: MediaQuery.of(context).size.height * 0.045,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigate back when pressed
            Navigator.pop(context);
          },
        ),
      ),
    ),
    floatingActionButton: widget.filePath.isNotEmpty &&
            widget.fileType == "video"
        ? FloatingActionButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          )
        : Container(),
    body: Container(
      height: MediaQuery.sizeOf(context).height,
      color: Colors.black,
      child: widget.filePath.isNotEmpty
            ? widget.fileType == 'video'
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : widget.fileType == 'image'
                    ? Image.file(File(widget.filePath))
                    : const Text(
                        "Unknown File to show",
                        style: TextStyle(color: Colors.white),
                      )
            : const Text(
                "No File to show",
                style: TextStyle(color: Colors.white),
              ),
    ),
  );
}
}