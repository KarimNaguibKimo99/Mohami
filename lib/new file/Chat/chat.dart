import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_mohami/models/customer.dart';
import 'package:el_mohami/services/el_mohami.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:el_mohami/pages/full_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Chat extends StatefulWidget {
  static String routeName = '/chat';
  final Customer customer;
  Chat({Key key, this.customer});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController message = new TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  File imageFile;
  String imageUrl;
  bool isLoading;
  String adminId = '1';

  String chatId;
  SharedPreferences preferences;
  String id;
  var listMessage;
  @override
  void initState() {
    super.initState();
    //focusNode.addListener(onFocusChange);
    isLoading = false;

    chatId = '';
    readLocal();
    final fbm = FirebaseMessaging.instance;
    fbm.getToken();
    /* fbm.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        Navigator.pushNamed(
          context,
          Chat.routeName,
        );
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification);
    });*/
  }

  readLocal() async {
    preferences = await SharedPreferences.getInstance();
    id = preferences.getString(Elmohami.userUID) ?? '';

    if (id == adminId) {
      if (id.hashCode <= widget.customer.id.hashCode) {
        chatId = '$id-${widget.customer.id}';
      } else {
        chatId = '${widget.customer.id}-$id';
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'chattingWith': widget.customer.id});
      setState(() {});
    } else {
      if (id.hashCode <= adminId.hashCode) {
        chatId = '$id-$adminId';
      } else {
        chatId = '$adminId-$id';
      }
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'chattingWith': adminId});
      setState(() {});
    }
  }

  /* onFocusChange(){
      if(focusNode.hasFocus){
        setState(() {
                  isDisplaySticker = false;
                });
      }
    } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          id == adminId ? widget.customer.name : 'الشات',
          softWrap: false,
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/chat.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: chatId == ''
                        ? Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.lightBlueAccent,
                              ),
                            ),
                          )
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('messages')
                                .doc(chatId)
                                .collection(chatId)
                                .orderBy('timestamp', descending: true)
                                //.limit(20)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.lightBlueAccent,
                                    ),
                                  ),
                                );
                              } else {
                                listMessage = snapshot.data.docs;
                                print(listMessage.length);
                                return ListView.builder(
                                  padding: EdgeInsets.all(10.0),
                                  itemBuilder: (context, index) {
                                    return createItem(
                                        index, snapshot.data.docs[index]);
                                  },
                                  itemCount: snapshot.data.docs.length,
                                  reverse: true,
                                  controller: listScrollController,
                                );
                              }
                            }),
                    /* child: , */
                  ),
                  Container(
                    child: Row(
                      children: [
                        // send message
                        Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Colors.lightBlueAccent,
                              ),
                              onPressed: () => onSendMessage(message.text, 0),
                            ),
                          ),
                          color: Colors.white,
                        ),

                        // Text Field
                        Flexible(
                          child: Container(
                            child: TextField(
                              maxLines: null,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                              controller: message,
                              decoration: InputDecoration.collapsed(
                                hintText: 'اكتب رسالتك',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              focusNode: focusNode,
                            ),
                          ),
                        ),
                        // pick Imoji
                        /* Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            child: IconButton(
                              icon: Icon(Icons.face),
                              color: Colors.lightBlueAccent,
                              onPressed: getImageeFromGallery,
                            ),
                          ),
                          color: Colors.white,
                        ), */
                        // pick Image
                        Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            child: IconButton(
                              icon: Icon(Icons.image),
                              color: Colors.lightBlueAccent,
                              onPressed: getImage,
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          /* SafeArea(
            child: Container(
                child: Column(
              children: <Widget>[
                Divider(
                  height: 0,
                  color: Colors.black54,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    color: Colors.white,
                    height: 60,
                    child: TextField(
                      maxLines: 100,
                      controller: text,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.0),
                          ),
                          hintText: 'اكتب رسالتك',
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                )
              ],
            )),
          ), */
        ],
      ),
    );
  }

  Widget createItem(int index, DocumentSnapshot document) {
    // my messages - Right side
    if (document.get('idFrom') == id) {
      return Row(
        children: [
          document.get('type') == 0
              ? Container(
                  child: Text(
                    document.get('content'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  margin: EdgeInsets.only(
                    bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                    right: 10.0,
                  ),
                )
              : Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullPhoto(
                            url: document.get('content'),
                          ),
                        ),
                      );
                    },
                    child: Material(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.lightBlueAccent),
                          ),
                          height: 200.0,
                          width: 200.0,
                          padding: EdgeInsets.all(70.0),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8.0,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Material(
                          child: Image.asset(
                            'images/img_not_available.jpeg',
                            height: 200.0,
                            width: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        imageUrl: document.get('content'),
                        height: 200.0,
                        width: 200.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                    ),
                  ),
                  margin: EdgeInsets.only(
                    bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                  ),
                ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    }
    // reciever messages - Left side
    else {
      return Container(
        child: Column(
          children: [
            Row(
              children: [
                document.get('type') == 0
                    ? Container(
                        child: Text(
                          document.get('content'),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 10.0,
                        ),
                      )
                    : Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullPhoto(
                                  url: document.get('content'),
                                ),
                              ),
                            );
                          },
                          child: Material(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.lightBlueAccent),
                                ),
                                height: 200.0,
                                width: 200.0,
                                padding: EdgeInsets.all(70.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Material(
                                child: Image.asset(
                                  'images/img_not_available.jpeg',
                                  height: 200.0,
                                  width: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    8.0,
                                  ),
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                              imageUrl: document.get('content'),
                              height: 200.0,
                              width: 200.0,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8.0,
                              ),
                            ),
                            clipBehavior: Clip.hardEdge,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 10.0,
                        ),
                      ),
              ],
            ),
            isLastMsgLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMMM, yyyy - hh:mm:aa').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(
                            document.get('timestamp'),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    margin: EdgeInsets.only(
                      top: 5.0,
                      left: 5.0,
                      bottom: 5.0,
                    ),
                  )
                : Container(),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(
          bottom: 10.0,
        ),
      );
    }
  }

  bool isLastMsgRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMsgLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      isLoading = true;
    }
    uploadImageFile();
  }

  void onSendMessage(String msgContent, int type) {
    // type 0 it's text message
    // type 1 it's image
    if (msgContent != '') {
      message.clear();
      var docRef = FirebaseFirestore.instance
          .collection('messages')
          .doc(chatId)
          .collection(chatId)
          .doc(DateTime.now().microsecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          docRef,
          {
            'idFrom': id,
            'idTo': id == adminId ? widget.customer.id : adminId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': msgContent,
            'type': type,
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  Future uploadImageFile() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('Chat Images').child(fileName);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    uploadTask.then((res) async {
      imageUrl = await res.ref.getDownloadURL();
      print('imageUrl : $imageUrl');
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      print('Error: $error');
      Fluttertoast.showToast(msg: 'Error: $error');
    });
    /* TaskSnapshot storageTaskSnapshot =
        await uploadTask.then((val) => val.ref.getDownloadURL().then((value) {
              imageUrl = value;
            }));
    setState(() {
      isLoading = false;
    }); */
  }
}
