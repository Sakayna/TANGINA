import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphDetailScreen extends StatelessWidget {
  final String title;
  final int itemCount;
  final int takeCount;
  final List<String> remarks;
  final List<int> scores;
  final List<DateTime> dateTaken;

  const GraphDetailScreen({
    required this.title,
    required this.itemCount,
    required this.takeCount,
    required this.remarks,
    required this.scores,
    required this.dateTaken,
  });

  @override
  Widget build(BuildContext context) {
    double graphHeight = 200.0 + (itemCount * 10.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE4E7EF),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Learning Curve',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'y',
                                  style: TextStyle(
                                    color: AppColors.contentColorCyan,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'No. of Items',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  'x',
                                  style: TextStyle(
                                    color: AppColors.contentColorBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'No. of Takes',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: graphHeight,
                        child: AspectRatio(
                          aspectRatio: 1.70,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 24,
                              left: 16,
                              top: 24,
                              bottom: 16,
                            ),
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  horizontalInterval: 1,
                                  verticalInterval: 1,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: AppColors.mainGridLineColor
                                          .withOpacity(0.4),
                                      strokeWidth: 1,
                                      dashArray: [4, 2],
                                    );
                                  },
                                  getDrawingVerticalLine: (value) {
                                    return FlLine(
                                      color: AppColors.mainGridLineColor
                                          .withOpacity(0.4),
                                      strokeWidth: 1,
                                      dashArray: [4, 2],
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval: 1,
                                      getTitlesWidget: _bottomTitleWidgets,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: _leftTitleWidgets,
                                      reservedSize: 42,
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: const Color(0xff37434d)),
                                ),
                                minX: 1,
                                maxX: takeCount.toDouble(),
                                minY: 0,
                                maxY: itemCount.toDouble(),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: scores.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      int score = entry.value;
                                      return FlSpot((index + 1).toDouble(),
                                          score.toDouble());
                                    }).toList(),
                                    isCurved: true,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.contentColorCyan,
                                        AppColors.contentColorBlue,
                                      ],
                                    ),
                                    barWidth: 5,
                                    isStrokeCapRound: true,
                                    dotData: const FlDotData(
                                      show: false,
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.contentColorCyan
                                              .withOpacity(0.3),
                                          AppColors.contentColorBlue
                                              .withOpacity(0.3),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24.0),
                child: const Text(
                  'Progress Log',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: takeCount,
                  itemBuilder: (context, index) {
                    // Reverse the order to show the latest attempt first
                    int reverseIndex = takeCount - 1 - index;
                    DateTime parsedDate =
                        DateTime.parse(dateTaken[reverseIndex].toString());
                    String formattedDate =
                        DateFormat('MMMM d, yyyy').format(parsedDate);
                    String formattedTime =
                        DateFormat('h:mm a').format(parsedDate);

                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                      child: SizedBox(
                        width: 200, // Increased width for better visibility
                        child: Card(
                          color: const Color(0xFFE4E7EF),
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    if (remarks[reverseIndex] == 'Passed')
                                      const Icon(Icons.check_circle,
                                          color: Colors.green)
                                    else
                                      const Icon(Icons.cancel,
                                          color: Colors.red),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      remarks[reverseIndex],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: <Widget>[
                                          Text(
                                            '${scores[reverseIndex]}',
                                            style: const TextStyle(
                                              fontSize: 56,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ' / $itemCount',
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 8,
                                                right: 8),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 194, 224, 158),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Text(
                                              formattedTime,
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    final style = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final text = value.toInt().toString();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    if (itemCount <= 10) {
      text = value.toInt().toString();
    } else {
      text = (value).toInt().toString();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}

class AppColors {
  static const Color primary = Colors.blue;
  static const Color contentColorGreen = Colors.green;
  static const Color contentColorPink = Colors.pink;
  static const Color contentColorCyan = Color(0xff87a8d0);
  static const Color contentColorBlue = Color(0xff92e9dc);
  static const Color mainGridLineColor = Color(0xff37434d);
}
