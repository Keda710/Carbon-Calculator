import 'package:flutter/material.dart';
import 'package:campus_carbon/decorators/text_field.dart';
import 'package:campus_carbon/decorators/button.dart';
import 'package:campus_carbon/pages/adv_output_page.dart';

class TextStyle2 extends StatelessWidget {
  const TextStyle2({super.key, required this.fieldName, this.type = 0});
  final String fieldName;
  // 0 - normal 1 - sub heading 2 - heading
  final int type;
  static const List<List<dynamic>> specs = [
    [16.0, 0.5, FontWeight.w400],
    [25.0, 1.2, FontWeight.w600],
    [40.0, 10.0, FontWeight.w900]
  ];
  @override
  Widget build(BuildContext context) {
    if (type != 2) {
      return Padding(
        padding: const EdgeInsets.only(left: 25, bottom: 15, right: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                fieldName,
                style: TextStyle(
                    fontSize: specs[type][0],
                    color: Colors.grey[900],
                    letterSpacing: specs[type][1],
                    fontWeight: specs[type][2]),
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      fieldName,
      style: TextStyle(
          color: Colors.grey[900],
          fontWeight: FontWeight.w900,
          fontSize: 40,
          letterSpacing: 10),
    );
  }
}

class AdvCalculator extends StatefulWidget {
  final String email;
  const AdvCalculator({super.key, required this.email});

  @override
  State<AdvCalculator> createState() => _AdvCalculatorState();
}

class _AdvCalculatorState extends State<AdvCalculator>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool datePage = true;

  int numText = 20; //No. of text fields
  int numDropDowns = 4; //No. of Dropdowns

  late List<TextEditingController> _controllers;
  late List<int> _dropDowns;

  late TabController _tabBarController;

  void next() {
    setState(() {
      _tabBarController.index = _tabBarController.index + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(numText, (index) => TextEditingController());
    _dropDowns = List.generate(numDropDowns, (index) => 0);
    _tabBarController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    void togglePages() {
      setState(() {
        datePage = !datePage;
      });
    }

    if (datePage) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  MyDateField(
                      controller: _controllers[18], valueText: "Start Date"),
                  const SizedBox(
                    height: 30,
                  ),
                  MyDateField(
                      controller: _controllers[19], valueText: "End Date"),
                  const SizedBox(
                    height: 70,
                  ),
                  MyButton(onTap: () => togglePages(), strValue: "Next"),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: TabBar(
          controller: _tabBarController,
          tabAlignment: TabAlignment.fill,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[600],
          isScrollable: false,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: const [
            Tab(
              icon: Icon(Icons.electric_bolt),
              //text: 'Power',
            ),
            Tab(
              icon: Icon(Icons.emoji_transportation),
              //text: 'Vehicles',
            ),
            Tab(
              icon: Icon(Icons.airplanemode_active),
              //text: 'Flights',
            ),
            Tab(
              icon: Icon(Icons.train),
              //text: 'Travel',
            ),
            Tab(
              icon: Icon(Icons.shopping_bag),
              //text: 'Secondary',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabBarController,
          children: [
            ElectricScreen(
              controllers: _controllers,
              choice: _dropDowns,
              next: next,
              email: widget.email,
            ),
            TransportScreen(
              controllers: _controllers,
              choice: _dropDowns,
              next: next,
              email: widget.email,
            ),
            PlaneScreen(
              controllers: _controllers,
              choice: _dropDowns,
              next: next,
              email: widget.email,
            ),
            TravelScreen(
              controllers: _controllers,
              choice: _dropDowns,
              next: next,
              email: widget.email,
            ),
            SecondaryScreen(
              controllers: _controllers,
              choice: _dropDowns,
              next: next,
              email: widget.email,
            ),
            //ElectricScreen(controllers: _controllers, choice: _dropDowns,),
          ],
        ),
      );
    }
  }
}

class ElectricScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<int> choice;
  final Function next;
  final String email;

  const ElectricScreen(
      {super.key,
      required this.controllers,
      required this.choice,
      required this.next,
      required this.email});

  @override
  State<ElectricScreen> createState() => _ElectricScreenState();
}

class _ElectricScreenState extends State<ElectricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const TextStyle2(fieldName: "POWER", type: 2,),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Electricity Consumption: "),
              MyTextField(
                  controller: widget.controllers[0],
                  hintText: "(in KWh)",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "At Factor of \n(Average emission factor in India is 0.716): "),
              MyTextField(
                  controller: widget.controllers[1],
                  hintText: "(in kgCO2e/kWh)",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Coal Consumption: "),
              MyTextField(
                  controller: widget.controllers[2], //  2.42 per kg
                  hintText: "(in Kgs)",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "LPG / Propane Consumption: "),
              MyTextField(
                  controller: widget.controllers[3], //  3 per kg
                  hintText: "(in Kgs)",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Heating Oil Consumption: "),
              MyTextField(
                  controller: widget.controllers[4], //  2.52 per litre
                  hintText: "(in Litre)",
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              MyButton(onTap: () => widget.next(), strValue: "Next"),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  onTap: () => _calculate(
                        widget.controllers,
                        widget.choice,
                        widget.email,
                        context,
                      ),
                  strValue: "Calculate"),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransportScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<int> choice;
  final Function next;
  final String email;

  const TransportScreen(
      {super.key,
      required this.controllers,
      required this.choice,
      required this.next,
      required this.email});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  List<String> fuels = ['Petrol', 'Diesel', 'CNG'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const TextStyle2(fieldName: "VEHICLES", type: 2,),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "CAR: ", type: 1,),
              const TextStyle2(fieldName: "Mileage: "),
              MyTextField(
                  controller: widget.controllers[5],
                  hintText: "(in kms)", // Mileage
                  obscureText: false),

              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Fuel Economy: "),
              MyTextField(
                  controller: widget.controllers[6],
                  hintText: "(in  L / 100 km)", //Efficiency
                  obscureText: false),
              //Petrol: 2.39
              //Diesel: 2.64
              //CNG: 2.66

              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Fuel Type: "),
              MyDropDown(
                items: fuels,
                initialValue: widget.choice[0],
                onChanged: (int newValue) {
                  setState(() {
                    widget.choice[0] = newValue;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              const TextStyle2(fieldName: "BIKE: ", type: 1,),
              const TextStyle2(fieldName: "Mileage: "),
              MyTextField(
                  controller: widget.controllers[7],
                  hintText: "(in kms)", // Mileage
                  obscureText: false),

              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Fuel Economy: "),
              MyTextField(
                  controller: widget.controllers[8],
                  hintText: "(in  L / 100 km)", //Efficiency
                  obscureText: false),
              //Petrol: 2.39
              //Diesel: 2.64


              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Fuel Type: "),
              MyDropDown(
                items: fuels.sublist(0, 2),
                initialValue: widget.choice[1],
                onChanged: (int newValue) {
                  setState(() {
                    widget.choice[1] = newValue;
                  });
                },
              ),

              const SizedBox(
                height: 50,
              ),
              MyButton(onTap: () => widget.next(), strValue: "Next"),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  onTap: () => _calculate(
                        widget.controllers,
                        widget.choice,
                        widget.email,
                        context,
                      ),
                  strValue: "Calculate"),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TravelScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final Function next;
  final String email;
  const TravelScreen(
      {super.key,
      required this.controllers,
      required this.choice,
      required this.next,
      required this.email});
  final List<int> choice;

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const TextStyle2(fieldName: "TRANSPORT", type: 2,),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Distance Travelled by Bus: "),
              MyTextField(
                  controller: widget.controllers[10],
                  hintText: "(in Km)", //Bus 0.089
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Distance Travelled by Metro: "),
              MyTextField(
                  controller: widget.controllers[11],
                  hintText: "(in Km)", //Metro 0.0324
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Distance Travelled by Train: "),
              MyTextField(
                  controller: widget.controllers[12], //  2.42 per kg
                  hintText: "(in Km)", //Train 0.033
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              MyButton(onTap: () => widget.next(), strValue: "Next"),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  onTap: () => _calculate(
                        widget.controllers,
                        widget.choice,
                        widget.email,
                        context,
                      ),
                  strValue: "Calculate"),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaneScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<int> choice;
  final Function next;
  final String email;
  const PlaneScreen(
      {super.key,
      required this.controllers,
      required this.choice,
      required this.next,
      required this.email});

  @override
  State<PlaneScreen> createState() => _PlaneScreenState();
}

class _PlaneScreenState extends State<PlaneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const TextStyle2(fieldName: "FLIGHTS", type: 2,),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Short Haul Flights (<1000km): "),
              MyTextField(
                  controller: widget.controllers[13],
                  hintText: "(in Km)", //0.20
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Long Haul Flights (>=1000km): "),
              MyTextField(
                  controller: widget.controllers[14],
                  hintText: "(in Km)", //0.121
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              MyButton(onTap: () => widget.next(), strValue: "Next"),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                  onTap: () => _calculate(
                        widget.controllers,
                        widget.choice,
                        widget.email,
                        context,
                      ),
                  strValue: "Calculate"),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondaryScreen extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<int> choice;
  final Function next;
  final String email;
  const SecondaryScreen(
      {super.key,
      required this.controllers,
      required this.choice,
      required this.next,
      required this.email});

  @override
  State<SecondaryScreen> createState() => _SecondaryScreenState();
}

class _SecondaryScreenState extends State<SecondaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const TextStyle2(fieldName: "SECONDARY", type: 2,),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Type: "),
              MyDropDown(
                items: const [
                  "Vegan",
                  "Vegetarian",
                  "Meat Eater",
                  "Heavy Meat Eater"
                ], // 2.8, 3.9, 7.2, 10.24
                initialValue: widget.choice[2],
                onChanged: (int newValue) {
                  setState(() {
                    widget.choice[2] = newValue;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Amount Spent on Textile / Shoes: "),
              MyTextField(
                  controller: widget.controllers[15],
                  hintText: "(in Rupees)", //0.00827
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Amount Spent on Paper / Wood Products: "),
              MyTextField(
                  controller: widget.controllers[16],
                  hintText: "(in Rupees)", //0.0064
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              const TextStyle2(fieldName: "Amount Spent on Other Services: "),
              MyTextField(
                  controller: widget.controllers[17],
                  hintText: "(in Rupees)", //0.0034
                  obscureText: false),
              const SizedBox(
                height: 50,
              ),
              MyButton(
                  onTap: () => _calculate(
                      widget.controllers, widget.choice, widget.email, context),
                  strValue: "Calculate"),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _calculate(List<TextEditingController> controllers, List<int> choice,
    String email, BuildContext context) {
  List<double> values = [];
  List values2 = [];
  List<DateTime> dates = [];

  dates.add(DateTime.parse(controllers[18].text));
  dates.add(DateTime.parse(controllers[19].text));

  Duration difference = dates[1].difference(dates[0]);
  // Calculate the number of days
  int days = difference.inDays + 1;

  const List<double> fuelToCarbon = [2.39, 2.64, 2.66];
  // 2.8, 3.9, 7.2, 10.24
  const List<double> foodToCarbon = [2.8, 3.9, 7.2, 10.24];

  for (int i = 0; i < controllers.length; i++) {
    String text = controllers[i].text.trim();

    if (text.isNotEmpty) {
      try {
        double value = double.parse(text);
        values.add(value);
      } catch (e) {
        //print("Error parsing value for controller $i: $e");
        values.add(0);
      }
    } else {
      values.add(0);
    }
  }

  double calculator(
    List<double> vals,
  ) {
    if (vals.length == 20) {
      double ans = vals[0] * vals[1];
      ans += vals[2] * 2.42;
      ans += vals[3] * 3;
      ans += vals[4] * 2.52;
      values2.add(ans);

      ans += vals[5] / 100 * vals[6] * fuelToCarbon[choice[0]];
      ans += vals[7] / 100 * vals[8] * fuelToCarbon[choice[1]];
      values2.add(ans - values2[0]);

      ans += vals[10] * 0.089;
      ans += vals[11] * 0.0324;
      ans += vals[12] * 0.033;
      values2.add(ans - values2[0] - values2[1]);

      ans += vals[13] * 0.2;
      ans += vals[14] * 0.121;

      values2.add(ans - values2[0] - values2[1] - values2[2]);

      ans += foodToCarbon[choice[2]] * days;

      values2.add(ans - values2[0] - values2[1] - values2[2] - values2[3]);


      ans += vals[15] * 0.00827;
      ans += vals[16] * 0.0064;
      ans += vals[16] * 0.0034;

      values2.add(ans - values2[0] - values2[1] - values2[2] - values2[3] - values2[4]);

      for (int i = 0; i < values2.length; i++) {
        values2[i] = values2[i] / 1000;
      }

      ans /= 1000;
      return ans;
    } else {
      return 0.0;
    }
  }

  double totalEmission = calculator(values);
  values2.add(DateTime.parse(controllers[18].text));
  values2.add(DateTime.parse(controllers[19].text));
  //_showResultDialog(totalEmission, context);
  _showOutput(totalEmission, context, values2, email);
}

void _showResultDialog(double totalEmissions, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Total Emissions"),
        content: Text("The total emissions are: $totalEmissions tons of CO2"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok, I will suicide to reduce my footprint"),
          ),
        ],
      );
    },
  );
}

void _showOutput(
    double totalEmissions, BuildContext context, List values, String email) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OutputPage(
              totalEmissions: totalEmissions, values: values, email: email)));
}
