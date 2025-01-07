import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_2.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_Topic_6_4_1 extends StatefulWidget {
  @override
  _Ecosystem_Topic_6_4_1State createState() => _Ecosystem_Topic_6_4_1State();
}

class _Ecosystem_Topic_6_4_1State extends State<Ecosystem_Topic_6_4_1> {
  late VideoPlayerController _videoController;
  late FlutterTts flutterTts;
  Timer? _sliderTimer;
  bool _isDragging = false;
  bool isTTSEnabled = false;

  String content = '''
Energy enters the living system in the form of light. Light is trapped by producers (autotrophs), and it is used in making food. Through photosynthesis, the producers become the primary sources of food and energy in the ecosystem. The flow of energy in the ecosystem begins when the producers are eaten by the herbivores. The herbivores are eaten by the carnivores, and decomposers act on the dead remains and waste products that are produced at all levels. This series of eating and being eaten is called the food chain. A food chain shows how each living thing obtains food and how nutrients and energy are passed on from one organism to another.
''';

  @override
  void initState() {
    super.initState();

    // Initialize video player
    _videoController = VideoPlayerController.asset(
      'assets/videos/ecosystem/eco8.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Timer to update the video slider
    _sliderTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isDragging && _videoController.value.isInitialized) {
        setState(() {});
      }
    });

    // Initialize TTS
    flutterTts = FlutterTts();
  }

  Future<void> speakText() async {
    if (isTTSEnabled) {
      await flutterTts.speak(content);
    }
  }

  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _videoController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech();
        if (_videoController.value.isPlaying) _videoController.pause();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Ecosystem_Screen(),
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Color(0xFFA846A0),
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 120.0,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final isTop =
                            constraints.biggest.height <= kToolbarHeight + 16.0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isTop) ...[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 50.0),
                                child: Text(
                                  'Ecosystem',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                                child: Text(
                                  'Topics',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 18.0),
                                child: Text(
                                  '6.4.1 - Food Chain',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          stopTextToSpeech();
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Ecosystem_Screen(),
                          ));
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          isTTSEnabled ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isTTSEnabled = !isTTSEnabled;
                            if (isTTSEnabled) {
                              speakText();
                            } else {
                              stopTextToSpeech();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            25.0,
                            30.0,
                            25.0,
                            80.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                content,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(left: 18.0),
                                child: Container(
                                  width: 400,
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/ecosystem/food chain.jpg',
                                        height: 200,
                                        width: 400,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'An example of a food chain',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Watch this video to learn more about Food Chain:',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 16),
                              buildVideoPlayer(
                                context,
                                _videoController,
                                _isDragging,
                                (value) => setState(() {
                                  _isDragging = value;
                                }),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Reference: https://youtu.be/YuO4WB4SwCg',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_4(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFFA846A0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech();
                        globalVariables.setTopic('lesson6', 8, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_4_2(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFFA846A0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideoPlayer(
      BuildContext context,
      VideoPlayerController controller,
      bool isDragging,
      Function(bool) setDragging) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
        Slider(
          value: isDragging
              ? controller.value.position.inSeconds.toDouble()
              : controller.value.position.inSeconds.toDouble(),
          min: 0.0,
          max: controller.value.duration.inSeconds.toDouble(),
          onChanged: (value) {
            setDragging(true);
            controller.seekTo(Duration(seconds: value.toInt()));
          },
          onChangeEnd: (value) {
            setDragging(false);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  controller.value.isPlaying
                      ? controller.pause()
                      : controller.play();
                });
              },
              icon: Icon(
                controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
            Text(
              "${controller.value.position.inMinutes}:${(controller.value.position.inSeconds % 60).toString().padLeft(2, '0')}",
            ),
            Text(
              " / ${controller.value.duration.inMinutes}:${(controller.value.duration.inSeconds % 60).toString().padLeft(2, '0')}",
            ),
          ],
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Ecosystem_Topic_6_4_1(),
    ),
  ));
}
