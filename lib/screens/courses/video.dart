import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../utils/colors.dart' as color;

class Video extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;
  Video(
      {Key? key,
      required this.videoUrl,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      allowPlaybackSpeedChanging: true,
      looping: false,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: true,
      allowedScreenSleep: false,
      showControlsOnInitialize: true,
      showControls: true,
      placeholder: const SizedBox(
        child: Center(child: CircularProgressIndicator()),
      ),
      materialProgressColors: ChewieProgressColors(
          handleColor: color.AppColor.gradientSecond,
          backgroundColor: color.AppColor.homePageBackground,
          bufferedColor: color.AppColor.card,
          playedColor: color.AppColor.gradientFirst),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    loading();
  }

  bool isloading = true;
  loading() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: color.AppColor.gradientSecond,
        leading: IconButton(
          onPressed: (() {
            Get.back();
          }),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
                  color: color.AppColor.gradientSecond),
            )
          : Column(
              children: [
                SafeArea(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        border: Border.all(
                            color: color.AppColor.homePageSubtitle, width: 2)),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Divider(
                          color: color.AppColor.homePageSubtitle,
                          indent: 20,
                          endIndent: 20,
                          height: 1.5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            widget.description,
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ]),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
