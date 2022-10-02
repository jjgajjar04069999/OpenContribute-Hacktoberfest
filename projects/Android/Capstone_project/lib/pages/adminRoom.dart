import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/Service/preference.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminRoom extends StatefulWidget {
  @override
  State<AdminRoom> createState() => _AdminRoomState();
}

class _AdminRoomState extends State<AdminRoom> {
  List chats = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _message = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  getChats(id) async {
    await _firestore
        .collection('admin')
        .doc('admin')
        .get()
        .then((value) => setState(() {
              chats = value.get('chat');
            }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? uid = preferenceHelper.preferences.getString('uid');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Admin Room'),
        backgroundColor: Color(0xff252331),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: _firestore.collection('admin').doc('admin').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot doc = snapshot.data;
                    chats = doc.get('chat');
                  } else {
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: chats.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.account_circle_rounded),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(top: 2, bottom: 2),
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 20, right: 20),
                                child: AutoSizeText(
                                  chats[index],
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.workSans(
                                      fontSize: 20, color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xff343145),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _message.dispose();
  }
}
