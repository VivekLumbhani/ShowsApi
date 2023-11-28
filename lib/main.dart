import 'package:api_test/details.dart';
import 'package:api_test/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> mapstrresp = [];
  int curIIndex = 0;

  Future<void> apicall() async {
    http.Response response;
    response =
    await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=all"));
    if (response.statusCode == 200) {
      setState(() {
        mapstrresp = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curIIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.red,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            backgroundColor: Colors.red,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            backgroundColor: Colors.yellow,
            label: 'Search',
          ),
        ],
        onTap: (index) {
          setState(() {
            curIIndex = index;
          });
        },
      ),
      body: curIIndex == 0
          ? MyMovies(mapstrresp: mapstrresp)
          : const search_screen(),
    );
  }
}

class MyMovies extends StatelessWidget {
  const MyMovies({Key? key, required this.mapstrresp}) : super(key: key);

  final List<dynamic> mapstrresp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'All Shows',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (mapstrresp.length > index && mapstrresp[index] != null) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return detailsOfShow(
                                id:mapstrresp[index]['show']['id'] ?? '',
                              );
                            },
                          ),
                        );
                        // mapstrresp[index]['show']['name'] ?? '',

                      },
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.network(
                                mapstrresp[index]['show']['image'] != null &&
                                    mapstrresp[index]['show']['image']['medium'] != null
                                    ? mapstrresp[index]['show']['image']['medium']
                                    : 'https://example.com/default-image.jpg', // Provide a default image URL
                              ),

                            ),
                            Text(
                              mapstrresp[index]['show']['name'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: mapstrresp?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

