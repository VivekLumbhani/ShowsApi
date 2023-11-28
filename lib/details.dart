import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class detailsOfShow extends StatefulWidget {
  final int id;

  const detailsOfShow({required this.id});

  @override
  State<detailsOfShow> createState() => _detailsOfShowState();
}

class _detailsOfShowState extends State<detailsOfShow> {
  var mapstrresp;

  late String title;

  late String summary;

  @override
  void initState() {
    var idof = widget.id;
    print("id of current movie is ${widget.id}");
    // TODO: implement initState
    apicall(idof);
    super.initState();
  }

  Future<String> apicall(idof) async {
    http.Response response;
    response = await http.get(Uri.parse("https://api.tvmaze.com/shows/${idof}"));
    if (response.statusCode == 200) {
      mapstrresp=response.body;

      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Detail Page"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(

          future: apicall(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              Map<String, dynamic> showData =
              json.decode(snapshot.data.toString());
              String imageUrl = showData['image']['medium'];
              title = showData['name'];
              summary = showData['summary'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.play_arrow,
                              size: 50, color: Colors.red),
                          onPressed: () {

                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      summary,
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }


}
