import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class CarbonData {
  final String id;
  final String email;
  final List<Map<String, dynamic>> carbonData;

  CarbonData({
    required this.id,
    required this.email,
    required this.carbonData,
  });

  factory CarbonData.fromJson(Map<String, dynamic> json) {
    return CarbonData(
      id: json['_id'],
      email: json['email'],
      carbonData: List<Map<String, dynamic>>.from(json['carbonData']),
    );
  }
}

class UserData extends StatefulWidget {
  final String email;
  const UserData({super.key, required this.email});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool dataPage = false;
  String jsonData = '';



  void togglePages() {
    setState(() {
      dataPage = !dataPage;
    });
  }

  void _getData(String email, BuildContext context) async {
    String apiUrl = 'http://172.16.14.142:3000/get-data?email=$email';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      //_showResultDialog("Data sent successfully ${response.body}", context);
      togglePages();
      setState(() {
        jsonData = response.body;
      });
    } else {
      _showResultDialog(
          "Failed to retrieve data. Error: ${response.statusCode}", context);
    }
  }

  void _showResultDialog(String totalEmissions, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Status"),
          content: Text(totalEmissions),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (!dataPage) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => _getData(widget.email, context),
                  child: const Text("Get")),
            ],
          ),
        ),
      );
    } else {
      final Map<String, dynamic> parsedJson = jsonDecode(jsonData);
      final carbonData = CarbonData.fromJson(parsedJson['data']);
      return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: const Text('Carbon Data'),
        ),
        body: ListView.builder(
          itemCount: carbonData.carbonData.length,
          itemBuilder: (context, index) {
            // carbonData.carbonData[index]["endDate"] =
            //     DateTime.parse(carbonData.carbonData[index]["endDate"]);
            // carbonData.carbonData[index]["startDate"] =
            //     DateTime.parse(carbonData.carbonData[index]["startDate"]);
            carbonData.carbonData[index]["endDate"] =
                carbonData.carbonData[index]["endDate"].toString();
            carbonData.carbonData[index]["startDate"] =
                carbonData.carbonData[index]["startDate"].toString();
            final values = carbonData.carbonData[index];
            return ListTile(
              //title: Text('Carbon Data ${index + 1}'),
              subtitle: Card(
                color: Colors.grey[300],
                elevation: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/12, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "Start Date: ",
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                  Text(
                                    //"${values["startDate"].day}/${values["startDate"].month}/${values["startDate"].year}",
                                    "${values["startDate"].substring(0,10)}",
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "End Date: ",
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                  Text(
                                      style: TextStyle(
                                        color: Colors.grey[100],
                                      ),
                                      //"${values["endDate"].day}/${values["endDate"].month}/${values["endDate"].year}"
                                    "${values["endDate"].substring(0,10)}"
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Due to Power and Electricity: "),
                          Text(values["power"].toStringAsPrecision(5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Due to Vehicles: "),
                          Text(values["vehicle"].toStringAsPrecision(5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Due to Public Transportation: "),
                          Text(
                              values["publicTransport"].toStringAsPrecision(5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Due to Flights: "),
                          Text(values["flight"].toStringAsPrecision(5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Due to Food: "),
                          Text(values["food"].toStringAsPrecision(5)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Due to Secondary: "),
                          Text(values["secondary"].toStringAsPrecision(5)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
