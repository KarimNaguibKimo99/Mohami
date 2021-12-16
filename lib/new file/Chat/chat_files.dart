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
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatFiles extends StatefulWidget {
  static String routeName = '/chatFiles';
  final Customer customer;
  ChatFiles({Key key, this.customer});
  @override
  _ChatFilesState createState() => _ChatFilesState();
}

class _ChatFilesState extends State<ChatFiles> {
  final TextEditingController message = new TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  File file;
  String fileUrl;
  String filePath;
  bool isLoading;
  String adminId = '1';
  String fileExtension;
  String chatId;
  SharedPreferences preferences;
  String id;
  var listFiles;
  bool loading = false;
  String dir;
  final Dio dio = Dio();
  double progress = 0.0;
  Future<bool> saveFile(
      String url, String fileName, String documentId, String chatId) async {
    Directory directory;
    try {
      if (await _requestPermission(Permission.storage)) {
        directory = await getExternalStorageDirectory();

        String newPath = '';
        List<String> folders = directory.path.split('/');
        for (int x = 1; x < folders.length; x++) {
          String folder = folders[x];
          if (folder != 'Android') {
            newPath += '/' + folder;
          } else {
            break;
          }
        }
        newPath = newPath + '/El mohami';
        directory = Directory(newPath);
        print(directory.path);
      } else {
        return false;
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + '/$fileName');
        FirebaseFirestore.instance
            .collection('files')
            .doc(chatId)
            .collection(chatId)
            .doc(documentId)
            .update({'path': '${saveFile.path}'});
        await dio.download(url, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
          setState(() {
            progress = downloaded / totalSize;
          });
        });
        return true;
      }
    } catch (e) {}
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;

    chatId = '';
    readLocal();
    final fbm = FirebaseMessaging.instance;
    fbm.getToken();
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
      //chatId = '$id-$adminId';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تبادل ملفات',
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
                                .collection('files')
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
                                listFiles = snapshot.data.docs;
                                print(listFiles.length);
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
                  ),
                  Container(
                    child: Row(
                      children: [
                        // pick Image
                        Material(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                            child: IconButton(
                              icon: Icon(Icons.upload_rounded),
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
        ],
      ),
    );
  }

  Widget createItem(int index, DocumentSnapshot document) {
    // my messages - Right side
    if (document.get('idFrom') == id) {
      return Row(
        children: [
          GestureDetector(
            onTap: () async {
              setState(() {
                loading = true;
              });
              bool downloaded = await saveFile(
                  document.get('content'),
                  '${document.get('timestamp')}.${document.get('extension')}',
                  document.id,
                  chatId);
              if (downloaded) {
                Fluttertoast.showToast(msg: 'تم التحميل بنجاح');
                await OpenFile.open(document.get('path'));
              } else {
                Fluttertoast.showToast(msg: 'حدث خطأ حاول مجددا');
              }
              setState(() {
                loading = false;
              });
              /* print(document.get('content'));
              PdftronFlutter.openDocument(document.get('content')); */
              /* await canLaunch(document.get('content'))
                  ? await launch(document.get('content'))
                  : print('حدث خطأ'); */
              //await OpenFile.open(document.get('content'));
            },
            child: Container(
              height: 200.0,
              width: 200.0,
              child: ClipRRect(
                child: Image.asset(
                  document.get('extension') == 'pdf'
                      ? 'images/pdf.png'
                      : document.get('extension') == 'doc'
                          ? 'images/doc.png'
                          : document.get('extension') == 'ppt'
                              ? 'images/ppt.png'
                              : document.get('extension') == 'xlsx'
                                  ? 'images/xlsx.png'
                                  : 'images/file.webp',
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.only(
                bottom: isLastMsgRight(index) ? 20.0 : 10.0,
              ),
            ),
          )
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
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    bool downloaded = await saveFile(
                        document.get('content'),
                        '${document.get('timestamp')}.${document.get('extension')}',
                        document.id,
                        chatId);
                    if (downloaded) {
                      Fluttertoast.showToast(msg: 'تم التحميل بنجاح');
                      await OpenFile.open(document.get('path'));
                    } else {
                      Fluttertoast.showToast(msg: 'حدث خطأ حاول مجددا');
                    }
                    setState(() {
                      loading = false;
                    });
                    /* print(document.get('content'));
              PdftronFlutter.openDocument(document.get('content')); */
                    /* await canLaunch(document.get('content'))
                  ? await launch(document.get('content'))
                  : print('حدث خطأ'); */
                    //await OpenFile.open(document.get('content'));
                  },
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    child: ClipRRect(
                      child: Image.asset(
                        document.get('extension') == 'pdf'
                            ? 'images/pdf.png'
                            : document.get('extension') == 'doc'
                                ? 'images/doc.png'
                                : document.get('extension') == 'ppt'
                                    ? 'images/ppt.png'
                                    : document.get('extension') == 'xlsx'
                                        ? 'images/xlsx.png'
                                        : 'images/file.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin: EdgeInsets.only(
                      left: 10.0,
                    ),
                  ),
                )
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
            listFiles != null &&
            listFiles[index - 1]['idFrom'] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMsgLeft(int index) {
    if ((index > 0 &&
            listFiles != null &&
            listFiles[index - 1]['idFrom'] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future getImage() async {
    /* final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    file = File(pickedFile.path); */
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'xlsx', 'ppt'],
      allowMultiple: true,
    );
    if (result != null) {
      PlatformFile platformFile = result.files.first;
      file = File(result.files.single.path);
      isLoading = true;
      print(platformFile.name);
      print(platformFile.bytes);
      print(platformFile.size);
      print(platformFile.extension);
      fileExtension = platformFile.extension;
      print('file extension  ' + fileExtension);
    }
    uploadImageFile();
  }

  void onSendMessage(String msgContent, int type, String extension) {
    // type 0 it's text message
    // type 1 it's image
    if (msgContent != '') {
      message.clear();
      var docRef = FirebaseFirestore.instance
          .collection('files')
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
            'extension': extension,
            'path': '',
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
        FirebaseStorage.instance.ref().child('Chat Files').child(fileName);
    UploadTask uploadTask = storageReference.putFile(file);
    uploadTask.then((res) async {
      fileUrl = await res.ref.getDownloadURL();
      print('fileUrl : $fileUrl');
      setState(() {
        isLoading = false;
        onSendMessage(fileUrl, 1, fileExtension);
      });
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      print('Error: $error');
      Fluttertoast.showToast(msg: 'Error: $error');
    });
  }
}
