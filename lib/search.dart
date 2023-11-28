import 'package:api_test/details.dart';
import 'package:flutter/material.dart';

class search_screen extends StatefulWidget {
  const search_screen({Key? key}) : super(key: key);

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context,delegate: CustomDelegate());
          }, icon: Icon(Icons.search))
        ],
      ),

      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Click On Icon',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate{
  List<int> staticShowIds = [
    42181,
    34653,
    6305,
    8600,
    31147,
    31428,
    21453,
    9448,
    32110,
    65759
  ];
  List<String> staticShow = [
    "All Rise",
    "All American",
    "All That",
    "All Access",
    "All Wrong",
    "All Night",
    "All In",
    "All Stars",
    "All Souls",
    "All Stars (In Development)"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query='';
      }, icon: Icon(Icons.clear))
    ];
    
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context,null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery=[];
    for(var shows in staticShow){
      if(shows.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(shows);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var res = matchQuery[index];
        return ListTile(
          title: Text(res),
          onTap: () {
            // Redirect to detailsOfShow page with corresponding ID
            int showId = staticShowIds[staticShow.indexOf(res)];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => detailsOfShow(id: showId),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery=[];
    for(var shows in staticShow){
      if(shows.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(shows);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var res = matchQuery[index];
        return ListTile(
          title: Text(res),
          onTap: () {
            // Redirect to detailsOfShow page with corresponding ID
            int showId = staticShowIds[staticShow.indexOf(res)];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => detailsOfShow(id: showId),
              ),
            );
          },
        );
      },
    );
  }
}


