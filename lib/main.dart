import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_r/models/newbeverage.dart';
import 'package:flutter_test_r/widgets/beveragewidget.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BeverageWidget> beverages = [];
  List<BeverageWidget> allBeverages = [];
  List<NewBeverage> beverageModels = [];
  TextEditingController _searchController = TextEditingController();
  bool hasSearchforBeverage = false;

  @override
  void initState() {
    getBeveragesData();
    super.initState();
  }

  getBeveragesData() async {
    final url =
        Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a');
    try {
      final response = await http.get(url);
      final responseData =
          json.decode(response.body)["drinks"] as List<dynamic>;
      dev.log('$responseData', name: 'checking for response');
      for (var element in responseData) {
        setState(() {
          beverageModels.add(
            NewBeverage(
              id: element['idDrink'],
              name: element['strDrink'],
              instructions: element['strInstructions'],
              type: element['strCategory'],
              strGlass: element['strGlass'],
              imageUrl: element['strDrinkThumb'],
            ),
          );
        });
        dev.log('$beverageModels', name: 'checking for beverage modesl');
      }
      for (var bevergeModel in beverageModels) {
        setState(() {
          beverages.add(
            BeverageWidget(
              beverageModel: bevergeModel,
            ),
          );
          allBeverages.add(
            BeverageWidget(
              beverageModel: bevergeModel,
            ),
          );
        });
      }
      //  _beveragesList.add(
      //    ListTile(
      //      title: Text('${element['strAlcoholic']}'),
      //    ),
      //  );
      dev.log('$beverages', name: 'beverage list');
      return beverages;
    } catch (e) {
      rethrow;
    }
  }

  onSearchfieldsubmitted(String text) {
    List<BeverageWidget> filteredBeverage = beverages.where((beverage) {
      final searchValue = beverage.beverageModel.name;
      final input = text;
      return searchValue.contains(input);
    }).toList();
    return SingleChildScrollView(
      child: Column(
        children: filteredBeverage,
      ),
    );
  }

  buildCards() {
    return SingleChildScrollView(
      child: Column(
        children: beverages,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getBeveragesData(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Container(
              height: 50,
              color: Colors.white,
              child: TextFormField(
                controller: _searchController,
                onChanged: (value) {
                  if (_searchController.text.isEmpty) {
                    setState(() {
                      hasSearchforBeverage = false;
                    });
                  } else {
                    setState(() {
                      hasSearchforBeverage = true;
                    });
                  }
                  dev.log('$hasSearchforBeverage', name: 'checking for search');
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 30),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Search for your beverage here',
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.99,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.99,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: hasSearchforBeverage
              ? onSearchfieldsubmitted(_searchController.text)
              : SingleChildScrollView(
                  child: Column(
                    children: beverages,
                  ),
                ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
