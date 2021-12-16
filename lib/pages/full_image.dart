import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullPhoto extends StatefulWidget {
  final String url;
  FullPhoto({Key key, @required this.url}) : super(key: key);

  @override
  _FullPhotoState createState() => _FullPhotoState();
}

class _FullPhotoState extends State<FullPhoto> {
  bool loading = false;
  final Dio dio = Dio();
  double progress = 0.0;
  Future<bool> saveFile(String url, String fileName) async {
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
        await dio.download(widget.url, saveFile.path,
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text('Full Image'),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  bool downloaded = await saveFile(widget.url, 'el mohami.jpg');
                  if (downloaded) {
                    Fluttertoast.showToast(msg: 'تم التحميل بنجاح');
                  } else {
                    Fluttertoast.showToast(msg: 'حدث خطأ حاول مجددا');
                  }
                  setState(() {
                    loading = false;
                  });
                },
                /* onTap: () async {
                try {
                  var imageId = await ImageDownloader.downloadImage(url)
                      .whenComplete(() =>
                          Fluttertoast.showToast(msg: 'تم التحميل بنجاح'));
                } on PlatformException catch (error) {
                  Fluttertoast.showToast(msg: 'حدث خطأ حاول مجددا');
                }
              }, */
                child: Icon(Icons.file_download))
          ],
        ),
        body: FullPhotoScreen(url: this.widget.url));
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String url;

  FullPhotoScreen({Key key, @required this.url}) : super(key: key);

  @override
  State createState() => FullPhotoScreenState();
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: NetworkImage(widget.url),
      ),
    );
  }
}
