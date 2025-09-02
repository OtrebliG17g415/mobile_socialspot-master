import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/models/ad.model.dart';
import 'package:social_spot/viewmodels/home.viewmodel.dart';
import 'package:social_spot/widgets/custom_button.widget.dart';
import 'package:video_player/video_player.dart';

class VideoAdPage extends ConsumerStatefulWidget {
  const VideoAdPage({super.key, required this.ad});

  final Ad ad;

  @override
  ConsumerState<VideoAdPage> createState() => _VideoAdPageState();
}

class _VideoAdPageState extends ConsumerState<VideoAdPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isVideoEnd = false;
  bool btnLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.ad.content["link"]),
    )..addListener(onVideoEnd);
    _initializeVideoPlayerFuture = _controller.initialize();
    if (mounted) {
      _controller.play();
    }
  }

  void onVideoEnd() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        // isVideoEnd = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: appSecondaryColor),
              ),
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        _controller.value.isPlaying
            ? const SizedBox()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  title: "Terminer",
                  onPressed: () {
                    Navigator.pop(context);
                    ref.read(loginProvider.future);
                    // ref.read(loginProvider.future).then((value) {
                    //   if (value) Navigator.pop(context);
                    // });
                    // setState(() {
                    //   btnLoading = true;
                    //   ref.read(loginProvider.future).then((value) {
                    //     btnLoading = false;
                    //   });
                    // });
                  },
                ),
              ),
        const Gap(20),
      ],
    );
  }
}
