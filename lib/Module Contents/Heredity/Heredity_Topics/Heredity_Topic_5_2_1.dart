import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2.dart';
import 'package:capstone/Module%20Contents/Heredity/Heredity_Topics/Heredity_Topic_5_2_2.dart';
import 'package:capstone/categories/heredity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'dart:async';

class Heredity_Topic_5_2_1 extends StatefulWidget {
  @override
  _Heredity_Topic_5_2_1State createState() => _Heredity_Topic_5_2_1State();
}

class _Heredity_Topic_5_2_1State extends State<Heredity_Topic_5_2_1> {
  late VideoPlayerController _videoController;
  Timer? _sliderTimer;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/heredidty/heredity5.mp4',
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
            builder: (context) => Heredity_Screen(),
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
                    backgroundColor: Color(0xFF64B6AC),
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
                                  'Heredity',
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
                                  '5.2.1 - Examples of Asexual Reproduction',
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
                            builder: (context) => Heredity_Screen(),
                          ));
                        },
                      ),
                    ),
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
                                      text: '\u2022 Budding ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is a form of asexual reproduction in which a new organism develops from an outgrowth called ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'bud ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'that grows in a specific site in the body of a matured or older species. Buds develop due to repeated cell division. Buds form if the food is abundant in the area where the organism lives. The new organism will only detach from the parent organism when it is mature and ready to live by itself. Budding is observed among yeast cells (Saccharomyces cerevisiae) and in multicellular animals like the hydra. ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      10.0), // Padding around the table
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(
                                          200), // Width of the 1st column
                                    },
                                    border: TableBorder.all(
                                        width: 1.0,
                                        color: Colors
                                            .grey), // Border for the table
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/budding.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '(A) Budding in Hydra',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/budding2.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '(B) Budding in Yeast',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
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
                                      text: '\u2022 Binary fission ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the simplest form of asexual reproduction and the most common among single-celled organisms. It involves the replication of the genetic material and the subsequent division or splitting of the cell into two genetically identical daughter cells. Binary fission may be transverse, wherein the cell divides across a short axis, or longitudinal, in which the cell divides across a long axis or random (no axis involved).',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      10.0), // Padding around the table
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(
                                          200), // Width of the 1st column
                                    },
                                    border: TableBorder.all(
                                        width: 1.0,
                                        color: Colors
                                            .grey), // Border for the table
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/binary.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Transverse binary fission in paramecium',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/long.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Longitudinal binary fission in euglena',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/am.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Random binary fission in amoeba',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
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
                                          '\u2022 Fragmentation and Regeneration ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'In fragmentation, a new organism grows from a fragment of the parent. The body of the parent breaks into several pieces in a process called ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'autotomy. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Each of these pieces develops into a complete organism by the process of regeneration.',
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
                                      text: 'Regeneration ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the ability to grow back any missing parts of the body. This type of reproduction occurs in simple organisms such as the planaria, starfish, and corals. In more complex animals like the lizard, fragmentation and regeneration are also observed as a defense mechanism.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      10.0), // Padding around the table
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(
                                          200), // Width of the 1st column
                                    },
                                    border: TableBorder.all(
                                        width: 1.0,
                                        color: Colors
                                            .grey), // Border for the table
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/starfish.png',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'A starfish emerging from a cut part',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/planarian.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'A planaria emerging from a cut part',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      180, // Set width to control image size
                                                  height:
                                                      180, // Set height to control image size
                                                  child: Image.asset(
                                                    'assets/images/heredity/lizard.jpg',
                                                    fit: BoxFit
                                                        .cover, // Cover the space
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'A lizard with a new emerging tail',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]),
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
                                          '\u2022 Spore formation or sporulation ',
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
                                    WidgetSpan(
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text: 'Spores ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are unicellular structures that are capable of germinating into an individual. They are resistant structures that are adapted for dispersal and survival for a long period of time when environmental conditions are unfavorable. They are formed in various ways and with quite different outcomes.',
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
                                          'Some multicellular plants, such as the ferns and mosses, exhibit a complex life cycle referred to as ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'alternation ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'of generation. Spore formation forms a part of their life cycles.',
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
                                          'In ferns, spores are haploid structures that grow and develop into a multicellular gamete-producing plant (gametophyte) called a ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'prothallus. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Union of the gametes gives rise to the development of the leafy spore-producing (sporophyte) fern plant that is commonly seen.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0), // Add left padding
                                child: Container(
                                  width: 300, // Adjust width as needed
                                  height: 180, // Adjust height as needed
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/heredity/prothallus.jpg',
                                          fit: BoxFit
                                              .cover, // Ensure the image covers the entire space
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'The Prothallus of a Fern (gametophyte)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 18.0,
                                        bottom:
                                            10.0), // Add left and bottom padding
                                    child: Container(
                                      width: 300, // Adjust width as needed
                                      height: 200, // Adjust height as needed
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Image.asset(
                                              'assets/images/heredity/sporophyte.jpg',
                                              fit: BoxFit
                                                  .cover, // Ensure the image covers the entire space
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'The fern plant (sporophyte)',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 18.0), // Add left padding
                                    child: Container(
                                      width: 500, // Adjust width as needed
                                      height: 250, // Adjust height as needed
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Image.asset(
                                              'assets/images/heredity/sporo and game.jpg',
                                              fit: BoxFit
                                                  .cover, // Ensure the image covers the entire space
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'The moss plant with the saprophyte and gametophyte stages',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                          'In mosses, spores are haploid structures that grow and develop into haploid male and female moss plants that are gamete-producing (gametophytes). The ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'archegonium ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the female sex organ, while the',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: ' antheridium ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the male sex organ. Fertilization takes place in the presence of water. The union of the egg and sperm gives rise to the development of the diploid sporophyte, which is a slender stalk with a capsule that is capable of producing haploid spores by meiosis.',
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
                                          'Fungi form different kinds of spores. As a matter of fact, among fungi, any part of the body that can form into a new individual is called a spore. Spores can be formed sexually and asexually. Asexual spores are formed in two ways-by fragmentation of the existing hyphae and by the development of a swelling (called sporangium) at the tip of a specialized hypha. Successive cell divisions within the sporangium give rise to numerous spores that can be dispersed which later on will germinate into new organisms.',
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
                                      text: '\u2022 Parthenogenesis ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          '(Greek: parthenos = virgin; genesis = birth) is a form of reproduction in which the offspring are produced asexually. This happens as females produce egg cells that develop into new individuals without fertilization. This form of reproduction has been observed among the following: some invertebrates like rotifers; many social insects such as the ants and the honeybees; fish, amphibians, and reptiles; and some birds. Although these organisms also reproduce sexually, parthenogenesis happens as mediated by existing environmental conditions. For instance, aphids reproduce by parthenogenesis when food is abundant.',
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
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 400, // Adjust width as needed
                                      height: 300, // Adjust height as needed
                                      child: Image.asset(
                                        'assets/images/heredity/2#fungus.jpg',
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the entire space
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            10), // Adds space between the image and the text
                                    Text(
                                      'The fungus rhizopus produces spores at the tip of a specialized hypha',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
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
                                          'Compared to sexual reproduction, the offspring are produced faster in parthenogenesis. This method allows the production of more offspring that can take advantage of exploiting the available food resources. Among honeybees, the unfertilized eggs give rise to male drones while the fertilized eggs develop into female workers and queens. The offspring produced by some types of individuals are identical to the mother in almost all inherited characteristics. In plants, parthenogenesis is a rare phenomenon, and it is referred to as',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: ' parthenocarpy ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'However, using special manipulations, parthenogenesis can be done artificially on some species.',
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
                                      text: '\u2022 Vegetative Propagation',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' is a form of asexual reproduction in plants. It is a process by which new individuals are formed not from seeds or spores but from other plant parts. This form of reproduction occurs naturally, or it can be induced for commercial purposes. Horticulturists artificially propagate plants in order to keep particular desirable characteristics-flavor, flower size and color, resistance to diseases, among others.',
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
                                          'Vegetative propagation can happen naturally or artificially because in most plant tissues meristematic cells are always present.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: ' Meristematic cells ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are actively dividing and multiplying cells that are capable of differentiation. They are found in growing regions of plants such as the tip of roots and shoots (called apical meristem), which are responsible for the increase in length of the plant and at vascular cambium (called lateral meristem) responsible for the increase in the lateral growth or girth of the plants.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Watch this video to learn more about Asexual Reproduction:',
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
                                'Reference: https://www.youtube.com/watch?v=i9zj9V8OWRk',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                              // Add more content as needed
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
                            builder: (context) => Heredity_Topic_5_2(),
                          ),
                        );
                      },
                      heroTag: 'prevBtn',
                      child: Icon(Icons.navigate_before, color: Colors.white),
                      backgroundColor: Color(0xFF64B6AC),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        globalVariables.setTopic('lesson5', 6, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Heredity_Topic_5_2_2(),
                          ),
                        );
                      },
                      heroTag: 'nextBtn',
                      child: Icon(Icons.navigate_next, color: Colors.white),
                      backgroundColor: Color(0xFF64B6AC),
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
      body: Heredity_Topic_5_2_1(),
    ),
  ));
}
