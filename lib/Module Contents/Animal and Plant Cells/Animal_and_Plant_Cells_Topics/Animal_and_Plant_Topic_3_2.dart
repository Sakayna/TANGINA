import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_1.dart';
import 'package:capstone/Module%20Contents/Animal%20and%20Plant%20Cells/Animal_and_Plant_Cells_Topics/Animal_and_Plant_Topic_3_3.dart';
import 'package:capstone/categories/animal_and_plant_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Animal_and_Plant_Topic_3_2 extends StatefulWidget {
  @override
  _Animal_and_Plant_Topic_3_2State createState() =>
      _Animal_and_Plant_Topic_3_2State();
}

class _Animal_and_Plant_Topic_3_2State
    extends State<Animal_and_Plant_Topic_3_2> {
  late VideoPlayerController _videoController;
  Timer? _sliderTimer;
  bool _isDragging = false;

  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false; // TTS toggle state

  @override
  void initState() {
    super.initState();

    // Initialize video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/cell/cell2.mp4',
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

  Future<void> speakText() async {
    if (isTTSEnabled) {
      String content =
          'Right now your body is doing a million things at once. It’s sending electrical impulses, pumping blood, filtering urine, digesting food, making protein, storing fat, and that’s just the stuff you’re not thinking about! You can do all this because you are made of cells — tiny units of life that are like specialized factories, full of machinery designed to accomplish the business of life. Cells make up every living thing, from blue whales to the archaebacteria that live inside volcanos. Just like the organisms they make up, cells can come in all shapes and sizes. Nerve cells in giant squids can reach up to 12m [39 ft] in length, while human eggs (the largest human cells) are about 0.1mm across. Plant cells have protective walls made of cellulose (which also makes up the strings in celery that make it so hard to eat) while fungal cell walls are made from the same stuff as lobster shells. However, despite this vast range in size, shape, and function, all these little factories have the same basic machinery. '
          'There are two main types of cells, prokaryotic and eukaryotic. Prokaryotes are cells that do not have membrane bound nuclei, whereas eukaryotes do. The rest of our discussion will strictly be on eukaryotes. Think about what a factory needs in order to function effectively. At its most basic, a factory needs a building, a product, and a way to make that product. All cells have membranes (the building), DNA (the various blueprints), and ribosomes (the production line), and so are able to make proteins (the product - let’s say we’re making toys). This article will focus on eukaryotes, since they are the cell type that contains organelles.'
          'The Parts of a Typical Cell and Their Function '
          'Organelle Structure Function'
          '1. Cell wall'
          'Nonliving component composed of cellulose, a polysaccharide.'
          'Provides mechanical support and maintains cell shape in plant cells.'
          '2. Plasma membrane'
          ' Flexible and elastic; composed of a phospholipid bilayer with proteins, carbohydrates, and steroids. '
          'Acts as a barrier to protect the cell and regulates the movement of substances in and out..'
          '3. Mitochondrion'
          'Double-membrane structure with inner membrane folded into cristae.'
          'Generates ATP through cellular respiration, serving as the energy powerhouse of the cell. '
          '4. Vacuole'
          '5. Golgi apparatus'
          'Stacks of single membranes (cisternae) connected to the plasma membrane and endoplasmic reticulum.'
          'Modifies, sorts, and packages proteins and lipids for secretion or delivery to other organelles.'
          '6. Cytoplasm'
          'Gel-like fluid that fills the cell; contains organelles and cytoskeleton.'
          'Provides a medium for biochemical reactions and supports organelles within the cell.'
          '7. Nuclear membrane'
          'Double-layered membrane enclosing the nucleus; outer membrane is porous. '
          'Protects the nucleus and regulates the exchange of materials between the nucleus and cytoplasm. '
          '8. Nucleolus'
          'Dense, spherical body within the nucleus; rich in RNA. ';
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
    stopTextToSpeech();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        stopTextToSpeech(); // Stop TTS on back navigation
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
                                  '3.2: Parts and Functions of Typical Cell',
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
                                          'Right now your body is doing a million things at once. It’s sending electrical impulses, pumping blood, filtering urine, digesting food, making protein, storing fat, and that’s just the stuff you’re not thinking about! You can do all this because you are made of cells — tiny units of life that are like specialized factories, full of machinery designed to accomplish the business of life. Cells make up every living thing, from blue whales to the archaebacteria that live inside volcanos. Just like the organisms they make up, cells can come in all shapes and sizes. Nerve cells in giant squids can reach up to 12m [39 ft] in length, while human eggs (the largest human cells) are about 0.1mm across. Plant cells have protective walls made of cellulose (which also makes up the strings in celery that make it so hard to eat) while fungal cell walls are made from the same stuff as lobster shells. However, despite this vast range in size, shape, and function, all these little factories have the same basic machinery. ',
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
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'There are two main types of cells, prokaryotic and eukaryotic. Prokaryotes are cells that do not have membrane bound nuclei, whereas eukaryotes do. The rest of our discussion will strictly be on eukaryotes. Think about what a factory needs in order to function effectively. At its most basic, a factory needs a building, a product, and a way to make that product. All cells have membranes (the building), DNA (the various blueprints), and ribosomes (the production line), and so are able to make proteins (the product - let’s say we’re making toys). This article will focus on eukaryotes, since they are the cell type that contains organelles.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'The Parts of a Typical Cell and Their Function ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(
                                          120), // Width of the 1st column
                                      1: FixedColumnWidth(
                                          200), // Width of the 2nd column
                                      2: FixedColumnWidth(
                                          300), // Width of the 3rd column
                                    },
                                    border: TableBorder.all(),
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text('Organelle')),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: Text('Structure')),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:
                                                Center(child: Text('Function')),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('1. Cell wall'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Nonliving component composed of cellulose, a polysaccharide.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Provides mechanical support and maintains cell shape in plant cells.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('2. Plasma membrane'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                ' Flexible and elastic; composed of a phospholipid bilayer with proteins, carbohydrates, and steroids. '),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Acts as a barrier to protect the cell and regulates the movement of substances in and out..'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('3. Mitochondrion'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Double-membrane structure with inner membrane folded into cristae.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Generates ATP through cellular respiration, serving as the energy powerhouse of the cell. '),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('4. Vacuole'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Compartment covered by a single membrane called tonoplast.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Stores nutrients, waste products, and helps maintain turgor pressure in plant cells.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('5. Golgi apparatus'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Stacks of single membranes (cisternae) connected to the plasma membrane and endoplasmic reticulum.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Modifies, sorts, and packages proteins and lipids for secretion or delivery to other organelles.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('6. Cytoplasm'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Gel-like fluid that fills the cell; contains organelles and cytoskeleton.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Provides a medium for biochemical reactions and supports organelles within the cell.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('7. Nuclear membrane'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Double-layered membrane enclosing the nucleus; outer membrane is porous. '),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Protects the nucleus and regulates the exchange of materials between the nucleus and cytoplasm. '),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('8. Nucleolus'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Dense, spherical body within the nucleus; rich in RNA. '),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Produces ribosomal RNA (rRNA) and assembles ribosomes for protein synthesis. '),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '9. Nucleoplasm/Nuclear sap'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Gel-like substance filling the nucleus; contains chromatin and nucleolus.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Serves as a suspension medium for nuclear components and facilitates the organization of genetic material.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('10. Chromosomes'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Highly coiled structures made of DNA and proteins; visible during cell division.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Carries genetic information and is essential for inheritance and cell division.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('11. Nucleus'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Spherical structure containing the cell\'s genetic material.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Acts as the control center of the cell, regulating gene expression and cellular activities. '),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                '12. Endoplasmic reticulum'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Network of membranes (rough with ribosomes, smooth without) extending from the nuclear envelope. '),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Synthesizes proteins (Rough ER) and lipids (Smooth ER); involved in detoxification and calcium storage. '),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('13. Chloroplastid'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Double-membrane structure containing chlorophyll and thylakoids.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Conducts photosynthesis, converting light energy into chemical energy stored in glucose.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('14. Centrioles'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Pair of small, cylindrical structures made of microtubules, arranged in a 9+0 pattern. '),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Organizes microtubules during cell division, facilitating the separation of chromosomes.'),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('15. Lysosome'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Single membrane-bound vesicle containing hydrolytic enzymes.'),
                                          ),
                                        ),
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Digests macromolecules, recycles cellular components, and eliminates waste materials.'),
                                          ),
                                        )
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Watch this video to learn more about why the cell is considered the basic structural and functional unit of all organisms:',
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
                                'Reference: https://www.youtube.com/watch?v=-TkC7BmdGcY',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Reference: https://training.seer.cancer.gov/anatomy/cells_tissues_membranes/cells/structure.html',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Reference: https://sepup.lawrencehallofscience.org/cells-unit-modeling-cell-structure-and-function/',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Reference: https://www.khanacademy.org/test-prep/mcat/cells/eukaryotic-cells/a/organelles-article',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Reference: https://byjus.com/biology/cell-organelles/',
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
                      stopTextToSpeech(); // Stop TTS before navigating
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Animal_and_Plant_Topic_3_1(),
                        ),
                      );
                    },
                    heroTag: 'prevBtn',
                    child: Icon(Icons.navigate_before, color: Colors.white),
                    backgroundColor: Color(0xFFA1C084),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      stopTextToSpeech(); // Stop TTS before navigating
                      globalVariables.setTopic('lesson3', 3, true);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Animal_and_Plant_Topic_3_3(),
                        ),
                      );
                    },
                    heroTag: 'nextBtn',
                    child: Icon(Icons.navigate_next, color: Colors.white),
                    backgroundColor: Color(0xFFA1C084),
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
