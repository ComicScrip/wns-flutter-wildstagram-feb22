import 'package:flutter/material.dart';
import 'package:flutter_application_1/picture.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class SavedPicturesScreen extends StatefulWidget {
  SavedPicturesScreen({Key? key});

  @override
  _SavedPicturesScreenState createState() => _SavedPicturesScreenState();
}

class _SavedPicturesScreenState extends State<SavedPicturesScreen>
    with AutomaticKeepAliveClientMixin<SavedPicturesScreen> {
  List<File> _images = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _update();
    Timer.periodic(new Duration(seconds: 4), (timer) {
      _update();
    });
  }

  _update() async {
    String folderPath = (await getApplicationDocumentsDirectory()).path;
    var images =
        Directory("$folderPath/pictures").listSync().whereType<File>().toList();
    images.sort((a, b) => a.path.compareTo(b.path));
    _images = images;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: this._images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PictureScreen(path: this._images[index].path),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                this._images[index],
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
