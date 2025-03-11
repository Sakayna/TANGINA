import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_2.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_4.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class Animal_and_Plant_Topic_3_3 extends StatefulWidget {
  @override
  _Animal_and_Plant_Topic_3_3State createState() =>
      _Animal_and_Plant_Topic_3_3State();
}

class _Animal_and_Plant_Topic_3_3State
    extends State<Animal_and_Plant_Topic_3_3> {
  late VideoPlayerController _videoController;
  final FlutterTts flutterTts = FlutterTts();
  Timer? _sliderTimer;
  bool _isDragging = false;
  bool isTTSEnabled = false;

  @override
  void initState() {
    super.initState();

    // Initialize video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/cell/cell1.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Start timer to update the slider
    _sliderTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isDragging && _videoController.value.isInitialized) {
        setState(() {});
      }
    });
  }

  // Function to handle text-to-speech
  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content =
      
                                          ' Each eukaryotic cell has a plasma membrane, cytoplasm, a nucleus, ribosomes, mitochondria, peroxisomes, and in some, vacuoles; however, there are some striking differences between animal and plant cells. While both animal and plant cells have microtubule organizing centers (MTOCs), animal cells also have centrioles associated with the MTOC: a complex called the centrosome. Animal cells each have a centrosome and lysosomes, whereas plant cells do not. Plant cells have a cell wall, chloroplasts and other specialized plastids, and a large central vacuole, whereas animal cells do not.'
                                                                                    'Both plant and animal cells comprise membrane-bound organelles, such as endoplasmic reticulum, mitochondria, the nucleus, Golgi apparatus, and lysosomes. The plant cell can also be larger than the animal cell. The normal range of the animal cell varies from about 10 – 30 micrometres and that of plant cell range between 10 – 100 micrometres.'
                                                                                    'Centrioles '  
                                                                                                                              'are paired barrel-shaped organelles located in the cytoplasm of animal cells near the nuclear envelope. Centrioles play a role in organizing microtubules that serve as the cell\'s skeletal system. They help determine the locations of the nucleus and other organelles within the cell.'
                                                                                                                              'Vacuoles '
                                                                                                                                                                        'Vacuoles are membrane-bound cell organelles seen in plants and fungi. Some bacterial, protist and animal cells also have vacuoles. They usually maintain the hydrostatic pressure within the cell.'
                                                                                                                                                                                                                  'The plant vacuoles are larger in size and occupy approximately 90% of the cell space. They are one huge structure that is surrounded by a tonoplast. This tonoplast avoids the intermixing of substances from the cytoplasm. The vacuole acts as an organelle that maintains the turgor pressure of the cell. Also, they store water, metabolites and nutrients. Their function is significant in plant cells as they cannot move to find nutrients and water. Thus, plant cells have larger vacuoles than animal cells. '
                                                                                                                                                                                                                                                            'The animal cell has several small and scattered vacuoles. They usually contain fluid and food. They are temporary structures of less significance. They aid in the endocytosis and exocytosis processes. Their main function in animal cells is osmoregulation, storage, excretion and digestion. Moreover, there are also animal cells with no vacuoles.'
                                                                                                                                                                                                                                                            
                                                                                        ;
      await flutterTts.speak(content);
    }
  }

  // Function to stop TTS
  Future<void> stopTextToSpeech() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _videoController.dispose();
    stopTextToSpeech(); // Ensure TTS stops when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech(); // Stop TTS when navigating back
        if (_videoController.value.isPlaying) _videoController.pause();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Animal_and_Plant_Screen(),
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
                    backgroundColor: Color(0xFFA1C084),
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
                                  'Animal and Plant Cells',
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
                                  '3.3: Comparison of a Plant Cell and an Animal Cell',
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
                          stopTextToSpeech(); // Stop TTS
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          }
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_Screen(),
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
                                          ' Each eukaryotic cell has a plasma membrane, cytoplasm, a nucleus, ribosomes, mitochondria, peroxisomes, and in some, vacuoles; however, there are some striking differences between animal and plant cells. While both animal and plant cells have microtubule organizing centers (MTOCs), animal cells also have centrioles associated with the MTOC: a complex called the centrosome. Animal cells each have a centrosome and lysosomes, whereas plant cells do not. Plant cells have a cell wall, chloroplasts and other specialized plastids, and a large central vacuole, whereas animal cells do not.',
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
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Both plant and animal cells comprise membrane-bound organelles, such as endoplasmic reticulum, mitochondria, the nucleus, Golgi apparatus, and lysosomes. The plant cell can also be larger than the animal cell. The normal range of the animal cell varies from about 10 – 30 micrometres and that of plant cell range between 10 – 100 micrometres.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 400, // Adjust width as needed
                                  height: 250, // Adjust height as needed
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/cells/cell comparison .jpeg',
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Comparative structure of a plant and an animal cell',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Centrioles ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are paired barrel-shaped organelles located in the cytoplasm of animal cells near the nuclear envelope. Centrioles play a role in organizing microtubules that serve as the cell\'s skeletal system. They help determine the locations of the nucleus and other organelles within the cell.',
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
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Vacuoles ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Vacuoles are membrane-bound cell organelles seen in plants and fungi. Some bacterial, protist and animal cells also have vacuoles. They usually maintain the hydrostatic pressure within the cell.',
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
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The plant vacuoles are larger in size and occupy approximately 90% of the cell space. They are one huge structure that is surrounded by a tonoplast. This tonoplast avoids the intermixing of substances from the cytoplasm. The vacuole acts as an organelle that maintains the turgor pressure of the cell. Also, they store water, metabolites and nutrients. Their function is significant in plant cells as they cannot move to find nutrients and water. Thus, plant cells have larger vacuoles than animal cells. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text:
                                          'The animal cell has several small and scattered vacuoles. They usually contain fluid and food. They are temporary structures of less significance. They aid in the endocytosis and exocytosis processes. Their main function in animal cells is osmoregulation, storage, excretion and digestion. Moreover, there are also animal cells with no vacuoles.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Watch this video to learn more about the difference between Animal Cell and Plant Cell:',
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
                                'Reference: https://www.youtube.com/watch?v=HjC-eMiMDfo&t=68s',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                                                               SizedBox(height: 20),

                              Text(
                                'Reference: https://bio.libretexts.org/Bookshelves/Introductory_and_General_Biology/General_Biology_(Boundless)/04%3A_Cell_Structure/4.10%3A_Eukaryotic_Cells_-_Comparing_Plant_and_Animal_Cells',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                                                            SizedBox(height: 20),

                              Text(
                                'Reference: https://byjus.com/biology/difference-between-plant-and-animal-vacuoles/',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                                                            SizedBox(height: 20),

                              Text(
                                'Reference: https://byjus.com/biology/difference-between-plant-cell-and-animal-cell/',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                                                            SizedBox(height: 20),

                              Text(
                                'Reference: https://www.genome.gov/genetics-glossary/Centriole#:~:text=Definition&text=Centrioles%20are%20paired%20barrel-shaped,other%20organelles%20within%20the%20cell.',
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
                        stopTextToSpeech(); // Stop TTS
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_Topic_3_2(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFFA1C084),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTextToSpeech(); // Stop TTS
                        globalVariables.setTopic('lesson3', 4, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Animal_and_Plant_Topic_3_4(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFFA1C084),
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
