import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_TLA/Ecosystem_TLA_6_1.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_4_3.dart';
import 'package:capstone/categories/ecosystem.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:capstone/globals/global_variables_notifier.dart';

class Ecosystem_Topic_6_5 extends StatefulWidget {
  @override
  _Ecosystem_Topic_6_5State createState() => _Ecosystem_Topic_6_5State();
}

class _Ecosystem_Topic_6_5State extends State<Ecosystem_Topic_6_5> {
  late VideoPlayerController _videoController;
  Timer? _sliderTimer;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/ecosystem/eco3.mp4',
    )..initialize().then((_) {
        setState(() {});
      });

    // Timer to update slider
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var globalVariables = Provider.of<GlobalVariables>(context);

    return WillPopScope(
      onWillPop: () async {
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
                                  '6.5 - Interactions in an Ecosystem',
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Ecosystem_Screen(),
                          ));
                        },
                      ),
                    ),
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
                                          'In Lesson 2, you learned that energy is needed by all living things in performing various life functions. You also learned that food is the source of energy for all living things. Living things vary in terms of how they acquire or obtain food. Autotrophs make their own food. Heterotrophs use plants and other animals as sources of food. In obtaining food, various methods of feeding evolved among heterotrophs. In obtaining food, various relationships or interactions are manifested by living things in their pursuit to survive.',
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
                                          'Interactions among living things fall into two distinct categories: intraspecific and interspecific. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Intraspecific interaction ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'exists between individuals of the same species (e.g. a dog and another dog). ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Interspecific interaction, ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'on the other hand, exists between individuals of different species (e.g. cat and mouse). The interactions vary in terms of strength, duration, and effects.',
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
                                      text: '\u2022 Symbiotic relationships ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
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
                                          'This type of interaction occurs when the two participating organisms live closely together for a certain period of time (protocooperation) or when they cannot be separated, so they have to completely live together throughout their lifetime (endosymbiosis).',
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
                                      text: '- Mutualism',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is an interaction wherein both participating organisms benefit from their association. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Butterfly pollinating a flower - The butterfly obtains nectar from the flower. The pollen of the flower is being scattered.',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- A carabao with a heron at its back - The bird gets a free ride so it conserves its energy and feeds on the parasites on the hair of the carabao. The carabao is freed from parasites.',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- An alga and a fungus species living together as lichen - The alga photosynthesizes and the product of the process is absorbed by the fungus as a source of nourishment. The alga is protected from drying by living in between the filaments of the fungus.',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- A termite with a flagellated protozoan (Trichonympha campanula) living in its gut - The protozoan digests the wood that the termite eats. Without the protozoan, the termite will die of starvation for it lacks the enzymes that digest cellulose from wood. The protozoan benefits in having a home and food source.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
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
                                      text:
                                          'In the last two examples, the participating organisms (alga and fungus, termite and protozoan) cannot be separated. One cannot exist without the other. These two are examples of ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'endosymbiosis',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/ecosystem/trico.jpg', // Image path for trico.jpg
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Spacing between image and text
                                        Text(
                                          'Trichonympha campanulla lives in the intestine of termites', // Text below trico.jpg
                                          style: TextStyle(
                                            fontSize:
                                                14, // Adjust font size as needed
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            20), // Vertical spacing between images
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/ecosystem/algae.png', // Image path for algae.png
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        Text(
                                          'An alga and a fungus live together as lichen', // Text below algae.png
                                          style: TextStyle(
                                            fontSize:
                                                14, // Adjust font size as needed
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '- Commensalism,',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' one organism benefits from the association, while the other one does not benefit and is neither harmed nor affected. The organism that benefits from the relationship is called the ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: '- commensal.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- The shark and the remora fish attached on its ventral side - The remora fish gets a free ride and food from the leftovers of the shark. The shark is not affected by the presence of the remora and does not benefit from their association.',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- An orchid plant attached high up a tree trunk-The orchid plant has a safe place to grow and can obtain water dripping down the tree trunk that it can use as a raw material in making food. The tree does not benefit from their association.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'In',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: '- parasitism,',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' one organism benefits from the relationship while the other one is harmed. The organism that harms is the parasite. Parasites live in (endoparasite) or on (ectoparasite) the body of the host. It feeds and exploits the host, but it does not outrightly kill the host. A parasite that causes the eventual death of the host is called parasitoid. The organism that is harmed and which harbors the parasite is the host. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Ticks and mites in the dog\'s fur (ectoparasitism)',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Worms (ascaris) in the intestine of a child (endoparasitism)',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 30),
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/ecosystem/bee.jpg', // Image path for bee.jpg
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Spacing between image and text
                                        Text(
                                          'A bee pollinating a flower', // Text below bee.jpg
                                          style: TextStyle(
                                            fontSize:
                                                14, // Adjust font size as needed
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            20), // Vertical spacing between images
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/ecosystem/shark.png', // Image path for shark.png
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Spacing between image and text
                                        Text(
                                          'A shark and remora fish', // Text below shark.png
                                          style: TextStyle(
                                            fontSize:
                                                14, // Adjust font size as needed
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            20), // Vertical spacing between images
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/ecosystem/tick.jpg', // Image path for tick.jpg
                                          height:
                                              200, // Adjust height as needed
                                          width: 400, // Adjust width as needed
                                          fit: BoxFit
                                              .contain, // Ensure the image is fully visible
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Spacing between image and text
                                        Text(
                                          "Tick on a dog's fur", // Updated text below tick.jpg
                                          style: TextStyle(
                                            fontSize:
                                                14, // Adjust font size as needed
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '- Amensalism,',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is a relationship where one organism is inhibited or killed while the other organism is unaffected. The organism that harms is capable of secreting a toxic material that is harmful to other organisms but not to itself. This interaction is called allelopathy. Ecologists consider this the rarest type of symbiosis, and it is particularly prevalent only among plant species. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ecosystem/wallnut.jpeg', // Updated image path
                                    height: 300, // Adjust height as needed
                                    width: 300, // Adjust width as needed
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the area
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spacing between image and text
                                  Text(
                                    'The black walnut tree (Junglas nigra)', // Text below the image
                                    style: TextStyle(
                                      fontSize:
                                          14, // Adjust font size as needed
                                      // Optionally make the text bold
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Farmers use rye and wheat as cover crops to suppress the growth of weeds.',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Broccoli plants secrete a chemical substance that inhibits ',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Black walnut tree (Juglans nigra) in the United States secretes the chemical substance juglone that inhibits the growth of other plants that grow near the tree\'s root zone. ',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- A species of bread mold (Penicillium notatum) secretes the chemical substance known as penicillin that kills and inhibits the growth of bacterial species that attempt to grow on the same medium where the molds grow. This led to the discovery of the bacteria-killing property of penicillin and its usage as an antibiotic medicine. ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Predation ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '-  is a relationship wherein one organism benefits and the other one is harmed. The organism that benefits is called predator; the one that is harmed is called prey. A predator is usually a carnivore that hunts, kills, and eats other animals or a herbivore that feeds on plants. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ecosystem/lizard feeding.jpeg', // Image path
                                    height: 300, // Adjust height as needed
                                    width: 300, // Adjust width as needed
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the area
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spacing between image and text
                                  Text(
                                    'Lizard (predator) eating cockroach (prey)', // Text below the image
                                    style: TextStyle(
                                      fontSize: 14, // Text size
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- a rabbit eating vegetables ',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- birds feeding on earthworms ',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- tortoises feeding on cactus plants lizard eating a cockroach',
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'In the discussion of food chain and food web, you learned that predators check on the population of prey. As the number of predators rises, the number of prey declines; and when the number of predators lowers, the number of prey rises. Thus, ecologists consider predation as a mechanism of population control.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Competition ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '-  All living organisms have the same basic needs-a place to live, water to drink, food to eat, and air to breathe. These needs we share to all living things-with your neighbors, with your domestic pets, with the plants in your garden, and even with the microbes in the soil where you step on. Because living things have the same basic needs, in some instances that there is scarcity in any one of these basic needs, competition exists. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ecosystem/deer.jpg', // Image path
                                    height: 200, // Adjust height as needed
                                    width: 300, // Adjust width as needed
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the area
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spacing between image and text
                                  Text(
                                    'The two male red deer competing for the same food and mate is an example of intraspecific competition', // Text below the image
                                    style: TextStyle(
                                      fontSize: 14, // Text size
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Competition',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is an interaction between species, in which the survival of one of the participating organisms is lowered by the presence of another. It exists among members of the same species (intraspecific competition). In Figure 5.20, the two male red deer go along and play with each other; but when they eat, they compete for the available meal. When they mate, they also compete so that whichever wins will be the one to mate with the female. ',
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
                                          'Competition also exists between individuals of different species (interspecific competition). Competition can exist between a lizard and a frog because both of them are herbivores and they eat similar food such as small insects. Ecologists consider competition as a negative relationship because both the interacting organisms are harmed to some extent.',
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
                                          'Each species in an ecosystem occupies an ecological niche. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Ecological niche ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the role which the organism plays in the community. It also comprises everything (biotic and abiotic factors) that the organism needs in order to survive. However, in most cases, niches of organisms overlap and competition exists.',
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
                                          'One classic example of niche overlap was studied by G.F. Gause, a Russian biologist. Gause introduced the difference between fundamental niche and realized niche using two strains of paramecium, which were cultured separately and together using the same medium (hay infusion). ',
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
                                          'Applying the same variables, the two strains were cultured separately. Both strains reproduced rapidly indicating that they were both adapted to their living conditions. However, when the two strains were cultured together, one strain outcompeted the other strain until it was eliminated. From this experiment, Gause formulated one important ecological principle, the ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'Competitive Exclusion Principle ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'that states: When two competitors occupy the same realized niche, competition exists and there is the possibility that one species will eliminate the other.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ecosystem/niche.png', // Image path
                                    height: 200, // Adjust height as needed
                                    width: 420, // Take up full available width
                                    fit: BoxFit
                                        .cover, // Cover the area without stretching
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spacing between image and text
                                  Text(
                                    'Fundamental niche vs. Realized niche', // Text below the image
                                    style: TextStyle(
                                      fontSize: 14, // Text size
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'The totality of the habitat where a species can exist and reproduce without any competition from other species is called its ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: ' fundamental niche. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'The range of habitat a species occupies that constrains the species to its access to some resources because of the presence of competing species is called the ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: ' realized niche.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
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
                                      text: '\u2022 Coexistence ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
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
                                          'If one of the competitors is efficient in utilizing a particular resource, it would outcompete the other until it is completely eliminated. In many cases, to decrease competition between species, they coexist. Coexistence involves the sharing of the limited resources so as to reduce actual fighting and excessive elimination. There are various strategies employed to reduce competition, and two methods were observed by biologists: character displacement and resource partitioning.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ecosystem/resource.png', // Image path
                                    height: 200, // Adjust height as needed
                                    width: 420, // Adjust width as needed
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the area
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spacing between image and text
                                  Text(
                                    'Resource in Ecosystem', // Text below the image
                                    style: TextStyle(
                                      fontSize: 14, // Text size
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '- Character displacement ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'involves a change in the behavior of species and resource specialization. One classic example of character displacement was observed between two species of barnacles, Chthamalus and Balanus, that live in the marine intertidal zones and are competing for space. ',
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The Balanus species is a better competitor for space because its growth is rapid, and it can crush and smother the slow-growing Chthamalus species. However, Balanus cannot live close to the shore because it would desiccate during low tide. In contrast, Chthamalus species can live in the upper, middle, and lower intertidal zones. Therefore, this species can survive in areas where Balanus cannot. To reduce competition for space, the two species of barnacles coexist. The Balanus species inhabits only the lower and middle intertidal zones, while the Chthamalus species inhabits the upper intertidal zone.',
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
                                      text: '- Resource partitioning ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'involves the splitting up of the niches between the two competing species within the biotic community so as to reduce excessive fighting and elimination. Another classic example that illustrates resource partitioning is the five different species of warbler birds living in a single spruce tree and competing for food. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/ecosystem/birdy.jpg', // Image path
                                    height: 250, // Adjust height as needed
                                    width: 600, // Take up full available width
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the area
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Spacing between image and text
                                  Text(
                                    'Resource partitioning in five species of warbler birds', // Text below the image
                                    style: TextStyle(
                                      fontSize: 14, // Text size
                                    ),
                                  ),
                                ],
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
                                      text:
                                          'The five species of birds were Cape May, Blackburnian, Bay-breasted, Myrtle, and Black- throated green warbler. To reduce competition among them, they split their niches. Each species hunts for food in separate places on the tree and nests on separate time, different from the other warblers. ',
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
                                      child: SizedBox(
                                        width: 40,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'The various interactions that were discussed can be summarized in terms of the effects of the participating organisms to each other. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Watch this video to learn more about Interactions in an Ecosystem:',
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
                                'Reference: https://youtu.be/rNjPI84sApQ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              // Add additional content here if needed
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_4_3(),
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
                        globalVariables.setTopic('lesson6', 11, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_TLA_6_1(),
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
      body: Ecosystem_Topic_6_5(),
    ),
  ));
}
