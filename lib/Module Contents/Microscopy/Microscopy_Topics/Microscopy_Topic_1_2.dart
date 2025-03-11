import 'package:capstone/Module%20Contents/Microscopy/Microscopy_TLA/Microscopy_TLA_1_1.dart';
import 'package:capstone/Module%20Contents/Microscopy/Microscopy_Topics/Microscopy_Topic_1_1.dart';
import 'package:capstone/categories/Microscopy_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Microscopy_Topic_1_2 extends StatefulWidget {
  @override
  _Microscopy_Topic_1_2State createState() => _Microscopy_Topic_1_2State();
}

class _Microscopy_Topic_1_2State extends State<Microscopy_Topic_1_2> {
  late VideoPlayerController _videoController1;
  late VideoPlayerController _videoController2;
  Timer? _sliderTimer1;
  Timer? _sliderTimer2;
  bool _isDragging1 = false;
  bool _isDragging2 = false;
  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // Toggle for TTS

  // Function to speak text
  Future<void> speakText(String content) async {
    if (isTTSEnabled) {
      await flutterTts.speak(content);
    }
  }

  // Function to stop TTS
  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  Widget buildLessonText(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: content,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Initialize video controllers
    _videoController1 = VideoPlayerController.asset(
      'assets/videos/microscopy/microscope2.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    _videoController2 = VideoPlayerController.asset(
      'assets/videos/microscopy/microscope1.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Start timers to update sliders
    _sliderTimer1 = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isDragging1 && _videoController1.value.isInitialized) {
        setState(() {});
      }
    });

    _sliderTimer2 = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isDragging2 && _videoController2.value.isInitialized) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer1?.cancel();
    _sliderTimer2?.cancel();
    _videoController1.dispose();
    _videoController2.dispose();
    stopTextToSpeech(); // Ensure TTS stops when disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    // TTS content
    final List<String> ttsContents = [
      'Function of each Microscope Part',
      '1. Eyepiece or Ocular Lens',
      'Eyepiece lens magnifies the image of the specimen. This part is also known as ocular. Most school microscopes have an eyepiece with 10X magnification.'
          '2. Eyepiece Tube or Body Tube',
      'The tube holds the eyepiece.'
          '3. Nosepiece',
      'Nosepiece holds the objective lenses and is sometimes called a revolving turret. You choose the objective lens by rotating to the specific lens one you want to use.'
          '4. Objective Lenses',
      'Most compound microscopes come with three or four objective lenses that revolve on the nosepiece. The most common objective lenses have power of 4X, 10X, and 40X, resulting in total magnifications of 40X, 100X, and 400X. Some advanced microscopes include an additional 100X lens, allowing for 1,000X magnification.'
          '5. Arm',
      'The Arm connects the base to the nosepiece and eyepiece. It is the structural part that is also used to carry the microscope.'
          '6. Stage',
      'The stage is where the specimen is placed for observation.'
          '7. Stage Clips',
      'Stage clips are the supports that hold the slides in place on the stage.'
          '8. Diaphragm (sometimes called the Iris'
          'The diaphragm controls the amount of light passing through the slide. It is located below the stage and is usually controlled by a round dial.'
          '9. Illuminator',
      'Most light microscopes use a low voltage bulb which supplies light through the stage onto the specimen. Mirrors are sometimes used instead of built-in light sources.'
          '10. Coarse Focus',
      'Coarse focus moves the stage to provide general focus on the specimen. It is the first adjustment used when focusing a specimen.'
          '11. Fine Focus',
      'Fine focus moves the stage in smaller increments to provide a clear view of the specimen. It is used for fine adjustments after the coarse focus.'
          '12. Base',
      'The base is the main support of the microscope. It is the bottom part where all the other parts of the microscope stand.'
    ];

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech(); // Stop TTS when navigating back
        if (_videoController1.value.isPlaying) _videoController1.pause();
        if (_videoController2.value.isPlaying) _videoController2.pause();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MicroscopyScreen(),
          ),
          (Route<dynamic> route) => false,
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
                    backgroundColor: Color(0xFFFFA551),
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
                                  'Microscopy',
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
                                  '1.2 - Parts and Functions of a Compound Light Microscope (CLM)',
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
                          stopTextToSpeech(); // Stop TTS before navigating back
                          if (_videoController1.value.isPlaying) {
                            _videoController1.pause();
                          }
                          if (_videoController2.value.isPlaying) {
                            _videoController2.pause();
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MicroscopyScreen(),
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
                              speakText(ttsContents.join(' '));
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
                              // Your Text.rich and content sections go here...
                              // Example Text with TTS functionality:
                              // Title for the Lesson

                              // PNG Image (Placed Below the Title)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 600, // Adjust width as needed
                                  height: 290, // Adjust height as needed
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/Microscopy/worksheet1.jpg',
                                          fit: BoxFit
                                              .cover, // Ensure the image covers the entire space
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          'A Compound Light Microscope',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Function of each Microscope Part\n\n',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),

                              buildLessonText('1. Eyepiece or Ocular Lens',
                                  'Eyepiece lens magnifies the image of the specimen. This part is also known as ocular. Most school microscopes have an eyepiece with 10X magnification.'),

                              buildLessonText('2. Eyepiece Tube or Body Tube',
                                  'The tube holds the eyepiece.'),

                              buildLessonText('3. Nosepiece',
                                  'Nosepiece holds the objective lenses and is sometimes called a revolving turret. You choose the objective lens by rotating to the specific lens one you want to use.'),

                              buildLessonText('4. Objective Lenses',
                                  'Most compound microscopes come with three or four objective lenses that revolve on the nosepiece. The most common objective lenses have power of 4X, 10X, and 40X, resulting in total magnifications of 40X, 100X, and 400X. Some advanced microscopes include an additional 100X lens, allowing for 1,000X magnification.'),

                              buildLessonText('5. Arm',
                                  'The Arm connects the base to the nosepiece and eyepiece. It is the structural part that is also used to carry the microscope.'),

                              buildLessonText('6. Stage',
                                  'The stage is where the specimen is placed for observation.'),

                              buildLessonText('7. Stage Clips',
                                  'Stage clips are the supports that hold the slides in place on the stage.'),

                              buildLessonText(
                                  '8. Diaphragm (sometimes called the Iris)',
                                  'The diaphragm controls the amount of light passing through the slide. It is located below the stage and is usually controlled by a round dial.'),

                              buildLessonText('9. Illuminator',
                                  'Most light microscopes use a low voltage bulb which supplies light through the stage onto the specimen. Mirrors are sometimes used instead of built-in light sources.'),

                              buildLessonText('10. Coarse Focus',
                                  'Coarse focus moves the stage to provide general focus on the specimen. It is the first adjustment used when focusing a specimen.'),

                              buildLessonText('11. Fine Focus',
                                  'Fine focus moves the stage in smaller increments to provide a clear view of the specimen. It is used for fine adjustments after the coarse focus.'),

                              buildLessonText('12. Base',
                                  'The base is the main support of the microscope. It is the bottom part where all the other parts of the microscope stand.'),

                              SizedBox(height: 20),
                              Text(
                                'Watch this video to learn more about the parts and functions of the microscope:',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 16),
                              buildVideoPlayer(
                                context,
                                _videoController1,
                                _isDragging1,
                                (value) => setState(() {
                                  _isDragging1 = value;
                                }),
                              ),
                              SizedBox(height: 10),
                              // Reference for first video
                              Text(
                                'Reference: https://www.youtube.com/watch?v=gqAcFKGztoY',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Watch this video to learn more about how to focus specimens using a compound microscope:',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 16),
                              buildVideoPlayer(
                                context,
                                _videoController2,
                                _isDragging2,
                                (value) => setState(() {
                                  _isDragging2 = value;
                                }),
                              ),
                              SizedBox(height: 10),
                              // Reference for second video
                              Text(
                                'Reference: https://youtu.be/zzamomqlwxU?si=1u_WitjzxcgwKhJ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),

                              SizedBox(height: 20),
                              Text(
                                'Reference: https://smartschoolsystems.com/parts-of-a-microscope-2/',
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
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Microscopy_Topic_1_1(),
                        ),
                      );
                    },
                    heroTag: 'prevBtn',
                    child: Icon(Icons.navigate_before, color: Colors.white),
                    backgroundColor: Color(0xFFFFA551),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      stopTextToSpeech(); // Stop TTS before moving forward
                      globalVariables.setTopic('lesson1', 3, true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Microscopy_TLA_1_1(),
                        ),
                      );
                    },
                    heroTag: 'nextBtn',
                    child: Icon(Icons.navigate_next, color: Colors.white),
                    backgroundColor: Color(0xFFFFA551),
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
