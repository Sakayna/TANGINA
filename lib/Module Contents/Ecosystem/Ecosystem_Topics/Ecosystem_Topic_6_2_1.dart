import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_2.dart';
import 'package:capstone/Module%20Contents/Ecosystem/Ecosystem_Topics/Ecosystem_Topic_6_2_2.dart';
import 'package:capstone/categories/ecosystem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone/globals/global_variables_notifier.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class Ecosystem_Topic_6_2_1 extends StatefulWidget {
  @override
  _Ecosystem_Topic_6_2_1State createState() => _Ecosystem_Topic_6_2_1State();
}

class _Ecosystem_Topic_6_2_1State extends State<Ecosystem_Topic_6_2_1> {
  late VideoPlayerController _videoController;
  Timer? _sliderTimer;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller
    _videoController = VideoPlayerController.asset(
      'assets/videos/ecosystem/eco6.mp4',
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
                                  '6.2.1 - Climatic Factors',
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
                                      child: SizedBox(width: 40),
                                    ),
                                    TextSpan(
                                      text:
                                          'Climatic factors pertain to the factors in the environment that affect the weather. These factors include light, temperature, water, and wind ',
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
                                      text: '\u2022 Light ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'is the visible portion of solar radiation. It is the primary source of energy in almost all ecosystems. This is the energy that is trapped by plants and used in the food manufacturing process (photosynthesis). Wavelength, intensity, and duration are the factors of light that play an important part in any ecosystem.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
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
                                            '- The blue and red wavelengths are very important during photosynthesis. Light is not a limiting factor in terrestrial ecosystems, but it is in the aquatic ecosystems. They do not penetrate deeply into the water, limiting the depth of the photic zone to 300 ft. ',
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
                                            '- Light intensity pertains to the amount of light that strikes the earth\'s surface. Light intensity varies according to latitude. The tropics receive vertical rays (direct rays) from the sun in the months of March, June, and September. Places beyond the tropics receive only oblique or slanting rays from the sun in these months. ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 18.0), // Add left padding
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Minimize the height to fit content
                                    children: [
                                      Image.asset(
                                        'assets/images/ecosystem/red.jpg', // Update the image path here
                                        height: 250, // Adjust height as needed
                                        width: 200, // Adjust width as needed
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the entire space
                                      ),
                                      SizedBox(
                                          height:
                                              10), // Add spacing between the image and text
                                      Text(
                                        'Poinsettia plant is a short-day plant', // Update the text here if needed
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
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '- Duration pertains to the length of the day and night that varies during certain times of the year as seasons change. Plants can detect the length of time they are exposed to sunlight, and this affects their growth and blossoming. The relative length of daylight and darkness that affect the behavior and functioning. Plants are called photoperiodism.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
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
                                          'There are plants that produce flowers only when night is longer than days. These plants are called ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'short-day plants. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Examples are the poinsettia (Figure 5.5) and chrysanthemum plants. Those that produce flowers when days are longer than nights are called ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    TextSpan(
                                      text: 'long-day ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'plants. Examples are radish, spinach, clover, and wheat plants. The plants that are not affected or influenced by the length of day and night are called neutral plants. Examples are corn and tomato plants. Neutral plants produce abundant flowers and fruits the whole year round.',
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
                                          'Light duration is also affected by stratification or layering that exists in some ecosystems. Plants that grow well in bright sunlight are called heliophytes, and those that grow well in shady conditions are called sciophytes.',
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
                                      text: '\u2022 Temperature. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Sunlight that strikes the surface undergoes transformation, ultimately forming heat energy. This heat energy provides the earth\'s surface with its characteristic surface temperature. As seasons change, temperature changes as well. During summer season, the atmospheric temperature is high. This is because vertical rays from the sun that strike the surface cover a narrow area. Thus, heat is concentrated only in a small area. Summer season is described as the warm season. During the winter season, atmospheric temperature is comparatively lower. Places that have winter seasons receive oblique rays from the sun or no sunlight at all. Oblique rays are spread over a larger area. Thus, heat is minimal. Winter season is described as the cold season.',
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
                                          'Temperature is an important abiotic factor because the biochemical processes that bring about life are temperature dependent. Certain metabolic functions in the body can happen only under certain temperatures. Too much heat or too little heat can cause biochemical reactions to fail. Extreme temperatures can also cause destruction to body tissues and cells.',
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
                                          'Since temperature is important in the metabolic functioning of living things, animals are divided into two distinct categories based on body temperatures: exothermic and endothermic. ',
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
                                      text: 'Endothermic animals ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'are those with stable body temperatures. No matter where they are, their body temperature does not change. Metabolic functions among endotherms go on smoothly wherever they are.',
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
                                      text: 'Exothermic animals, ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          ' on the other hand, have unstable body temperatures. Their body temperatures are affected by the environmental temperature. Studies showed that exotherms\' metabolic rates could increase when the environmental temperature rises even as little as 5°C. Exothermic animals stay in shaded areas, or they do not go out to search for food during daylight hours for their metabolic functions to go on smoothly. During very cold seasons, exotherms obtain heat from outside sources by either basking under the sun or lying over a rock exposed to the sun',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 18.0), // Add left padding
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Minimize the height to fit content
                                    children: [
                                      Image.asset(
                                        'assets/images/ecosystem/rock.jpg', // Update the image path here
                                        height: 250, // Adjust height as needed
                                        width: 200, // Adjust width as needed
                                        fit: BoxFit
                                            .cover, // Ensure the image covers the entire space
                                      ),
                                      SizedBox(
                                          height:
                                              10), // Add spacing between the image and text
                                      Text(
                                        'An iguana acquires heat by lying on a warm rock', // Update the text here if needed
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Aside from the hazardous effects of extreme temperatures, warm and cold seasonal temperatures can also influence living things in many different ways.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
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
                                            '- Various plant functions and behaviors like blossoming of flowers, seed germination (called vernalization), pollination, and plant dormancy are markedly influenced by temperature.  ',
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
                                            '- Temperature also affects the following animal behaviors: the seasonal migration of birds and some insect species, aestivation of animals during warm and dry conditions, and the hibernation of animals such as the polar bears during cold and dry seasons. ',
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
                                            '- In places affected by long, harsh winters, some animals develop fats as food reserves and grow thicker fur to keep them warm.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Water. ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'Most of our planet\'s surface is covered with water. Within a relatively small range in temperature, water exists in three states: as solid (ice and snow), as gas (water vapor in clouds. and fog), or as liquid water that is free flowing.',
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
                                          'Water is essential to life on Earth, both in the external and internal environments of the organisms. The bodies of living things are made up mostly of water. It is the basic medium where biochemical reactions critical to life take place. Water is also a basic external medium where critical life activities occur-searching for food, mating, and other important roles such as transporting dissolved gasses (CO, and oxygen) and minerals needed by aquatic organisms and acting as a "heat sink" to minimize the effect of very high temperature. Water in its liquid form also provides the powerful erosional force that shapes the landscape.',
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
                                          'Water availability is affected by climate, frequency of rainfall, relative humidity, wind direction, and temperatures. The amount of water (plenty or scarce) in an area dictates what plants will grow in the area and also the number and type of consumers that can be supported. In terms of water requirement, plants are classified into three distinct types: hydrophytes, mesophytes, and xerophytes.',
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
                                  height: 200, // Adjust height as needed
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis
                                        .horizontal, // Enable horizontal scrolling
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width:
                                                        1), // Add a thin grey border
                                              ),
                                              child: Image.asset(
                                                'assets/images/ecosystem/lotus.jpg', // Update the image path here
                                                height:
                                                    150, // Adjust height as needed
                                                width:
                                                    150, // Adjust width as needed
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the entire space
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    10), // Add spacing between the image and text
                                            Text(
                                              'Lotus Plant is an example of a hydrophyte', // Text for the first image
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Add spacing between the images
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width:
                                                        1), // Add a thin grey border
                                              ),
                                              child: Image.asset(
                                                'assets/images/ecosystem/santan.jpg', // Update the image path here
                                                height:
                                                    150, // Adjust height as needed
                                                width:
                                                    150, // Adjust width as needed
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the entire space
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    10), // Add spacing between the image and text
                                            Text(
                                              'Santan Plant is an example of a mesophyte', // Text for the second image
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Add spacing between the images
                                        Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width:
                                                        1), // Add a thin grey border
                                              ),
                                              child: Image.asset(
                                                '/mnt/data/cactus.jpg', // Update the image path here
                                                height:
                                                    150, // Adjust height as needed
                                                width:
                                                    150, // Adjust width as needed
                                                fit: BoxFit
                                                    .cover, // Ensure the image covers the entire space
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    10), // Add spacing between the image and text
                                            Text(
                                              'Cactus Plant is an example of a xerophyte', // Text for the third image
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 60), // Add left padding
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '- Hydrophytes ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text:
                                            'are plants that grow in water (emergent or submerged). Examples are water lilies, elodeas, rushes, duck weeds, and algae.',
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
                                        text: '- Mesophytes ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text:
                                            'are plants that grow in areas with moderate amounts of water. Examples are land plants-rose, gumamela (hibiscus), mango, santan, etc.',
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
                                        text: '- Xerophytes ',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextSpan(
                                        text:
                                            'are plants that grow in very dry environments or in areas with very limited supply of water. Examples are cacti plants and aloe vera.',
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
                                            '- The ribosomes are the organelles where protein synthesis occurs; and ',
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
                                            '- Some storage granules and various forms of inclusions.',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '\u2022 Wind, ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text:
                                          'also called air current, is a result of the complex interactions between hot air expanding and rising and cold air shrinking and sinking on a global scale. These air currents are affected by the earth\'s rotation and deflected to the southern and northern hemispheres by the Coriolis force. Winds carry water vapor that can cool and condense in the upper atmosphere and fall on the surface in the form of rain, snow, or hail.',
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
                                          'Wind affects living things in so many ways: it defines how strong and sturdy organisms in an ecosystem are strong and long-period winds make branches of trees fall and determine which habitat must still exist as they continuously blow. It plays a role in the dispersal of pollen that can fertilize nearby plants and in the dispersal of spores and seed so they can spread and germinate in other places.',
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
                                          'Strong and steady winds also affect the environment for it can remove and erode the topsoil in places that are denuded of plant life. They also serve as agents in the spread of dirt and pathogens from the exposed soil particles that they picked up contaminating the entire vegetation in the area.',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Watch this video to learn more about Climatic Factors:',
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
                                'Reference: https://youtu.be/wAPpAxfsars',
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
                            builder: (context) => Ecosystem_Topic_6_2(),
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
                        globalVariables.setTopic('lesson6', 4, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ecosystem_Topic_6_2_2(),
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
      body: Ecosystem_Topic_6_2_1(),
    ),
  ));
}
