import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_delegate_firebase_example/list_item.dart';

class Search extends SearchDelegate {
  String get searchFieldLabel => "Search By Country Name";

  @override
  TextStyle get searchFieldStyle => TextStyle(
    color: Colors.white,
    fontSize: 18.0,
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.blue,
      textTheme: TextTheme(
        // ignore: deprecated_member_use
        title: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close,color: Colors.white,),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    CollectionReference nameSnapshot =
        FirebaseFirestore.instance.collection("Countries");
    return StreamBuilder(
      stream: nameSnapshot.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final doc = snapshot.data.docs[0];
        final List<String> countryNames = [];
        for (var data in doc.data()["Name"]) {
          countryNames.add(data);
        }
        final names = query.isEmpty
            ? []
            : countryNames.where((name) {
                return name.toLowerCase().startsWith(query) ||
                    name.toUpperCase().startsWith(query);
              }).toList();
        return names.length > 0
            ? ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    name: names[index],
                  );
                },
              )
            : Center(
                child: Text("Country Name not found"),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    CollectionReference nameSnapshot =
        FirebaseFirestore.instance.collection("Countries");
    return StreamBuilder(
      stream: nameSnapshot.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final doc = snapshot.data.docs[0];
        final List<String> countryNames = [];
        for (var data in doc.data()["Name"]) {
          countryNames.add(data);
        }
        final names = query.isEmpty
            ? []
            : countryNames.where((name) {
                return name.toLowerCase().startsWith(query) ||
                    name.toUpperCase().startsWith(query);
              }).toList();
        return names.length > 0
            ? ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    name: names[index],
                  );
                },
              )
            : Center(
                child: query.isEmpty
                    ? Text("Search Country Name")
                    : Text("Country Name not found"),
              );
      },
    );
  }
}
