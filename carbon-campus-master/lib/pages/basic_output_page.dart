import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class OutputPage extends StatelessWidget {
  final double totalEmissions;
  final List values;
  const OutputPage(
      {super.key,
        required this.values,
        required this.totalEmissions});

  @override

  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Stack(
                    children: [
                      SafeArea(
                        child: Center(
                          child: SizedBox(
                            height: height/2 + height/8,
                            width: width/1.1,
                            child: PieChart(PieChartData(sections: [
                              //Electricity
                              PieChartSectionData(
                                value: values[0],
                                title: "Power",
                                color: const Color.fromARGB(255, 221, 87, 70),
                              ),
                              PieChartSectionData(
                                value: values[1],
                                title: "Vehicles",
                                color: const Color.fromARGB(255, 255, 196, 112),
                              ),
                              PieChartSectionData(
                                value: values[3],
                                title: "Movement",
                                color: const Color.fromARGB(255, 22, 121, 171),
                              ),
                              PieChartSectionData(
                                value: values[2],
                                title: "Flights",
                                color: const Color.fromARGB(255, 188, 127, 205),
                              ),
                              PieChartSectionData(
                                value: values[4],
                                title: "Food",
                                color: Colors.red,
                              ),
                              PieChartSectionData(
                                value: values[5],
                                title: "Secondary",
                                color: const Color.fromARGB(255, 19, 93, 102),
                              ),
                            ])),
                          ),
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height/4,
                            ),
                            SizedBox(
                              width: width/1.5,
                              height: height/9,
                              child: FittedBox(
                                child: Text(
                                  totalEmissions.toStringAsPrecision(5),
                                  style: const TextStyle(
                                    fontSize: 80,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text("Tons of CO2 emission"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Power and Electricity: "),
                      Text(values[0].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Vehicles: "),
                      Text(values[1].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Public Transportation: "),
                      Text(values[3].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Flights: "),
                      Text(values[2].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Food: "),
                      Text(values[4].toStringAsPrecision(5)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Due to Secondary: "),
                      Text(values[5].toStringAsPrecision(5)),
                    ],
                  ),
                ),


                const SizedBox(
                  height: 50,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
