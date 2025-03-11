import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_ILO/Levels_of_Biological_Organization_ILO.dart';
import 'package:capstone/Module%20Contents/Levels%20of%20Biological%20Organization/Levels_of_Biological_Organization_TLA/Levels_of_Biological_Organization_TLA_2_1.dart';
import 'package:capstone/categories/levels_of_biological_organization_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class Biological_Organization_Topic_2_1 extends StatefulWidget {
  @override
  _Biological_Organization_Topic_2_1State createState() =>
      _Biological_Organization_Topic_2_1State();
}

class _Biological_Organization_Topic_2_1State
    extends State<Biological_Organization_Topic_2_1> {
  late VideoPlayerController _videoController;
  Timer? _sliderTimer;
  bool _isDragging = false;

  final FlutterTts flutterTts = FlutterTts();
  bool isTTSEnabled = false;

  final String ttsContent =
      'Biology, the study of life and living organisms, is a vast and complex field that covers a multitude of structures, systems, and processes. One fundamental aspect of biology is understanding how life organizes from the simplest to the most complex forms. This concept of hierarchical organization helps us comprehend the vast diversity of life, how different biological structures interact, and how they function both individually and collectively.'
      'Why Understanding Organization is Important'
      'Understanding the levels of biological organization assists in making sense of the complexity of life forms, their interactions, and their environments. It provides a framework for biologists to classify and study organisms. Also, it helps in understanding how different components of an ecosystem work together. This knowledge is essential for fields like medicine, environmental science, and genetics.'
      'Levels of Organization in Biology'
      'From the simplest to the most complex, the levels of organization in biology are: atoms, molecules, macromolecules, cells, tissues, organs, organ systems, organisms, populations, communities, and the biosphere. Eukaryotic cells (plants, animals, fungi) display all of these levels, while prokaryotic cells (bacteria and archaea) don’t have tissues, organs, or organ systems.'
      'This is the most basic level, involving the smallest units of matter that make up the chemical composition of living organisms.'
      'Molecular subunits connect via covalent bonds (polymerize) and form large, complex organic molecules called macromolecules.'
      'A configuration of a molecule. The different colors represent the different atoms that compose the molecule.'
      'are highly organized assemblies of several macromolecules bonded together to perform a specific function in the cell. The organelles are most often membrane-bound. Examples of organelles are mitochondria, nucleus, chloroplasts, and lysosomes. '
      'The animal cell is composed of various parts called organelles that perform specific functions.'
      'is the basic units of life. Some exist independently in unicellular organisms, while others are part of a larger multicellular organism.'
      'Organs are structures that consist of two or more types of tissues that work together to perform specific, complex functions. '
      'An organ system is a group of organs that work together to perform major functions or meet physiological needs of the body. '
      'An organism is an individual living entity that functions on its own.'
      'A population is a group of organisms of the same species living in a specific geographical area and capable of interbreeding.'
      'A community is the collection of all the different populations that live together in an area.'
      'Ecosystems include all the living things in a given area, interacting with each other, and also with their non-living environments. In other words, an ecosystem includes both biotic and abiotic factors.'
      'pertains to a collection of ecosystems with similar climates and covering a large geographical area. Grasslands, savanna, deserts, and tropical rainforests are examples of ecosystems that cover a large geographical area. '
      'The biosphere is the global ecological system integrating all living beings and their relationships, including their interaction with the elements of the lithosphere, hydrosphere, and atmosphere.';

  @override
  void initState() {
    super.initState();

    // Initialize video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/levels/biological.mp4',
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

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _videoController.dispose();
    flutterTts.stop(); // Stop TTS when the widget is disposed
    super.dispose();
  }

  Future<void> speakText() async {
    if (isTTSEnabled) {
      await flutterTts.speak(ttsContent);
    }
  }

  Future<void> stopTTS() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_videoController.value.isPlaying) _videoController.pause();
        stopTTS(); // Stop TTS on back navigation
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Levels_of_biological_organization_Screen(),
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
                    backgroundColor: Color(0xFF9463FF),
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
                                  'Levels of Biological Organization',
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
                                  '2.1',
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
                          stopTTS();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Levels_of_biological_organization_Screen(),
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
                              stopTTS();
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
                                          'Biology, the study of life and living organisms, is a vast and complex field that covers a multitude of structures, systems, and processes. One fundamental aspect of biology is understanding how life organizes from the simplest to the most complex forms. This concept of hierarchical organization helps us comprehend the vast diversity of life, how different biological structures interact, and how they function both individually and collectively.',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Why Understanding Organization is Important\n\n',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Understanding the levels of biological organization assists in making sense of the complexity of life forms, their interactions, and their environments. It provides a framework for biologists to classify and study organisms. Also, it helps in understanding how different components of an ecosystem work together. This knowledge is essential for fields like medicine, environmental science, and genetics.',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Levels of Organization in Biology\n\n',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'From the simplest to the most complex, the levels of organization in biology are: atoms, molecules, macromolecules, cells, tissues, organs, organ systems, organisms, populations, communities, and the biosphere. Eukaryotic cells (plants, animals, fungi) display all of these levels, while prokaryotic cells (bacteria and archaea) don’t have tissues, organs, or organ systems.',
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
                                      text: 'Atom ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'This is the most basic level, involving the smallest units of matter that make up the chemical composition of living organisms.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 0.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 350, // Adjust height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/atom.png',
                                        height: 250, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A configuration of an atom. The neurons and protons are found within the nucleus.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'A ',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'molecule ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Molecular subunits connect via covalent bonds (polymerize) and form large, complex organic molecules called macromolecules.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 350, // Adjust height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/molecule.png',
                                        height: 250, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A configuration of a molecule. The different colors represent the different atoms that compose the molecule.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Organelles ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are highly organized assemblies of several macromolecules bonded together to perform a specific function in the cell. The organelles are most often membrane-bound. Examples of organelles are mitochondria, nucleus, chloroplasts, and lysosomes. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 350, // Adjust height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/cell.png',
                                        height: 250, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      Text(
                                        'The animal cell is composed of various parts called organelles that perform specific functions.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'A ',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'cell ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the basic units of life. Some exist independently in unicellular organisms, while others are part of a larger multicellular organism.',
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
                                      text: 'Tissue ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are groups of similar eukaryotic cells that work together to perform a specific function. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1), // Thin border
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:
                                                  200, // Ensure the same height for all containers
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/organization/cardiac muscle.jpg',
                                                    height:
                                                        100, // Adjust height as needed
                                                    width:
                                                        100, // Adjust width as needed
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'The Cardiac Muscle is a group of muscle cells.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            8), // Add spacing between columns
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1), // Thin border
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:
                                                  200, // Ensure the same height for all containers
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/organization/heart.jpg',
                                                    height:
                                                        100, // Adjust height as needed
                                                    width:
                                                        100, // Adjust width as needed
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'The Heart is an organ composed primarily of cardiac muscles.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            8), // Add spacing between columns
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1), // Thin border
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height:
                                                  200, // Ensure the same height for all containers
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/organization/system.jpg',
                                                    height:
                                                        100, // Adjust height as needed
                                                    width:
                                                        100, // Adjust width as needed
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'The heart is an organ of the cardiovascular system.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      text: 'Organ ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are structures that consist of two or more types of tissues that work together to perform specific, complex functions. ',
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
                                      text: 'Organ system ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is a group of organs that work together to perform major functions or meet physiological needs of the body. ',
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
                                      text: 'Organism ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is an individual living entity that functions on its own.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 300, // Adjust height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/bison.jpg',
                                        height: 250, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Population ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is a group of organisms of the same species living in a specific geographical area and capable of interbreeding.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height:
                                      200, // Adjust height to match the image height
                                  alignment:
                                      Alignment.center, // Center the content
                                  child: Image.asset(
                                    'assets/images/organization/group.jpg',
                                    height: 200, // Adjust height as needed
                                    width: 300, // Adjust width as needed
                                    fit: BoxFit
                                        .contain, // Ensure the image is fully visible
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
                                      text: 'Community ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the collection of all the different populations that live together in an area.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 350, // Adjust width as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/community.jpg',
                                        height: 120, // Adjust height as needed
                                        width: 350, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      Text(
                                        'Hawk, snake, bison, prairie dog, grass',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Ecosystem ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'include all the living things in a given area, interacting with each other, and also with their non-living environments. In other words, an ecosystem includes both biotic and abiotic factors.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.grey[300]!, // Thin grey border
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/ecosystem.jpg',
                                        height: 150, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A freshwater pond is an example of an ecosystem.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          Colors.grey[300]!, // Thin grey border
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/savana.jpg',
                                        height: 150, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'A savanna is an example of an ecosystem covering a large geographical area.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Biome ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'pertains to a collection of ecosystems with similar climates and covering a large geographical area. Grasslands, savanna, deserts, and tropical rainforests are examples of ecosystems that cover a large geographical area. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 350, // Adjust height as needed
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/organization/biosphere.jpg',
                                        height: 250, // Adjust height as needed
                                        width: 300, // Adjust width as needed
                                        fit: BoxFit
                                            .contain, // Ensure the image is fully visible
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'The world of life',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Biosphere ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the global ecological system integrating all living beings and their relationships, including their interaction with the elements of the lithosphere, hydrosphere, and atmosphere.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Watch this video to learn more about the levels of biological organization:',
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
                                'Reference: https://www.youtube.com/watch?v=52B7Edcc7y4',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Reference: https://sciencenotes.org/levels-of-organization-in-biology/',
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
                        stopTTS();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Biological_Organization_ILOScreen(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFF9463FF),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        stopTTS();
                        globalVariables.setTopic('lesson2', 2, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Biological_Organization_TLA_2_1(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFF9463FF),
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
