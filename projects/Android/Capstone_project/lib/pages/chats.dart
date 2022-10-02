import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/DatabaseManager/DatabaseManager.dart';
import 'package:flutter_login_signup/Service/AuthenticationService.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:flutter_login_signup/pages/adminRoom.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_room.dart';

class Chats extends StatefulWidget {
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List feedList = [];

  late String name;

  late String rollNo;

  dynamic uid;

  final AuthenticationService _auth = AuthenticationService();

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  Future<void> fetchDatabaseList() async {
    uid = await _auth.getCurrentUID();
    if (uid == null) {
      print("UID is NULL");
    } else {
      print("uid-$uid");
      DatabaseManager databaseManager = DatabaseManager(uid: uid);
      DocumentSnapshot resultant = await databaseManager.getUsersList();

      if (resultant == null) {
        print('Unable to retrieve');
      } else {
        setState(() {
          name = resultant.get('name');
          rollNo = resultant.get('rollNo');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String? uuid = preferenceHelper.preferences.getString('uid');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff252331),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Chats',
                        style: GoogleFonts.roboto(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showSearch(
                            context: context, delegate: NameSearch(feedList));
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(right: 8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xff252331),
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AdminRoom())),
                title: Text(
                  'Admin Messages',
                  style: GoogleFonts.openSans(fontSize: 18),
                ),
                leading: CircleAvatar(
                  backgroundColor: Color(0xff252331),
                  child: Text(
                    'AD',
                    style: GoogleFonts.roboto(color: Colors.white),
                  ),
                ),
              ),
              StreamBuilder(
                stream: firestore.collection('profile').doc(uuid).snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  DocumentSnapshot? doc = snapshot.data;
                  if (snapshot.hasData) {
                    feedList = doc!.get('feed');
                  } else {
                    return Container();
                  }
                  return ListView.builder(
                      itemCount: feedList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        if (feedList.isEmpty) {
                          return Container();
                        }
                        print(feedList[index]['uid']);
                        String feedName = feedList[index]['name'];

                        return ListTile(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChatRoom(feedList[index]['uid']))),
                          title: Text(
                            feedName,
                            style: GoogleFonts.openSans(fontSize: 18),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Color(0xff252331),
                            child: Text(
                              feedName.characters.first.toUpperCase(),
                              style: GoogleFonts.roboto(color: Colors.white),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NameSearch extends SearchDelegate {
  final List names;
  String result = '';

  NameSearch(this.names);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestion = names.where((element) {
      return element['name'].toLowerCase().contains(query.toLowerCase());
    });
    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            result = suggestion.elementAt(index)['name'];
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChatRoom(suggestion.elementAt(index)['uid'])));
          },
          title: Text(
            suggestion.elementAt(index)['name'],
            style: GoogleFonts.openSans(fontSize: 18),
          ),
          leading: CircleAvatar(
            backgroundColor: Color(0xff252331),
            child: Text(
              suggestion
                  .elementAt(index)['name']
                  .toString()
                  .characters
                  .first
                  .toUpperCase(),
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = names.where((element) {
      return element['name'].toLowerCase().contains(query.toLowerCase());
    });
    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            query = suggestion.elementAt(index)['name'];
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ChatRoom(suggestion.elementAt(index)['uid'])));
          },
          title: Text(
            suggestion.elementAt(index)['name'],
            style: GoogleFonts.openSans(fontSize: 18),
          ),
          leading: CircleAvatar(
            backgroundColor: Color(0xff252331),
            child: Text(
              suggestion
                  .elementAt(index)['name']
                  .toString()
                  .characters
                  .first
                  .toUpperCase(),
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
