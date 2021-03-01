import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_delegate_firebase_example/list_item.dart';
import 'package:search_delegate_firebase_example/search.dart';

class MainPage extends StatelessWidget {
  final CollectionReference countryNameCollection =
      FirebaseFirestore.instance.collection("Countries");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search_delegate_example"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: countryNameCollection.snapshots(),
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

          List<String> names = [];

          for (var data in doc.data()["Name"]) {
            names.add(data);
          }

          return names.length > 0
              ? ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    return ListItem(name: names[index]);
                  },
                )
              : Center(
                child: Text("Empty"),
              );
        },
      ),
    );
  }
}


