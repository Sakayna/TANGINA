import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_1_4.dart';
import 'package:capstone/Module%20Contents/Funji,%20Protists,%20and%20Bacteria/Bacteria_Topics/Bacteria_Topic_4_2.dart';
import 'package:capstone/categories/bacteria_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Bacteria_Topic_4_1_5 extends StatefulWidget {
  @override
  _Bacteria_Topic_4_1_5State createState() => _Bacteria_Topic_4_1_5State();
}

class _Bacteria_Topic_4_1_5State extends State<Bacteria_Topic_4_1_5> {
  late VideoPlayerController _videoController;
  late FlutterTts flutterTts;
  Timer? _sliderTimer;
  bool _isDragging = false;
  bool isTTSEnabled = false;

  @override
  void initState() {
    super.initState();

    // Initialize video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/bacteria/bacteria1.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Initialize TTS
    flutterTts = FlutterTts();

    // Start timer to update the slider
    _sliderTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isDragging && _videoController.value.isInitialized) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _videoController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content = '''
      The preceding discussions provided information concerning the beneficial effects of bacteria. 
      This part will now discuss the harmful effects of bacteria. Since bacteria cause 90 percent of the known diseases that afflict humans, 
      it is important that you know some of them to employ proper health measures. 
      Examples of harmful bacteria include:
      - Saprotrophic bacteria acting on food items, causing them to become unfit for eating.
      - Staphylococcus aureus secreting toxins that lead to food poisoning.
      - Spirochaete cytophaga causing deterioration of wood and leather.
      Additionally, diseases caused by pathogenic bacteria include:
      - Tuberculosis (Mycobacterium tuberculosis),
      - Leprosy (Mycobacterium leprae),
      - Typhoid (Bacillus typhosus),
      - Tetanus (Clostridium tetani),
      - Pneumonia (Diplococcus pneumoniae),
      - Cholera (Vibrio cholera),
      - Syphilis (Treponema pallidum), and
      - Furuncles and carbuncles (Staphylococcus aureus).
      ''';
      await flutterTts.speak(content);
    }
  }

  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_videoController.value.isPlaying) _videoController.pause();
        stopTextToSpeech();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Bacteria_Screen(),
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
                    backgroundColor: Color(0xFFFF6A6A),
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
                                  'Funji, Protists, and Bacteria',
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
                                  '4.1.5 - Harmful Effects of Bacteria',
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
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          }
                          stopTextToSpeech();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Bacteria_Screen(),
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
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 80.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'The preceding discussions provided information concerning the beneficial effects of bacteria. This part will now discuss the harmful effects of bacteria. Since bacteria cause 90 percent of the known diseases that afflict humans, it is also important that you know some of them so that proper health measures can be employed.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Saprotrophic bacteria can act on food items, making them unfit for eating. Staphylococcus aureus secrete toxic substances that can cause food poisoning. Ingestion of this contaminated food can lead to death.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Deterioration of some wooden and leather articles can be caused by bacterial activities (Spirochaete cytophaga).',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\u2022 Human diseases are caused by pathogenic bacteria like:',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Tuberculosis - Mycobaterium tuberculosis',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Leprosy - Mycobacterium leprae ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- Typhoid - Bacillus typhosus',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- Tetanus - Clostridium tetani',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Pneumonia - Diplococcus pnemoniae',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- Cholera - Vibrio cholera',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- Syphilis - Treponema pallidum',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Furuncles and carbuncles - Staphylococcus aureus',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Watch this video to learn more about Pathogens:',
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
                                'Reference: https://www.youtube.com/watch?v=dGEWefqGk2k',
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
                      stopTextToSpeech();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bacteria_Topic_4_1_4(),
                        ),
                      );
                    },
                    heroTag: 'prevBtn',
                    child: Icon(Icons.navigate_before, color: Colors.white),
                    backgroundColor: Color(0xFFFF6A6A),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      stopTextToSpeech();
                      globalVariables.setTopic('lesson4', 7, true);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bacteria_Topic_4_2(),
                        ),
                      );
                    },
                    heroTag: 'nextBtn',
                    child: Icon(Icons.navigate_next, color: Colors.white),
                    backgroundColor: Color(0xFFFF6A6A),
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
              "${controller.value.position.inMinutes}:${(controller.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${controller.value.duration.inMinutes}:${(controller.value.duration.inSeconds % 60).toString().padLeft(2, '0')}",
            ),
          ],
        ),
      ],
    );
  }
}
