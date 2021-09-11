import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fishing_match/freezed/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddbookScreen extends StatefulWidget {
  static const routeName = '/add';
  @override
  _AddbookScreenState createState() => _AddbookScreenState();
}

class _AddbookScreenState extends State<AddbookScreen> {
  File? pickedImage;
  bool isRequireTool = true;
  DateTime? leaveDay;
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController targetCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController numCtrl = TextEditingController();
  TextEditingController capacityCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();

  Future _getImageFromCamera() async {
    try {
      final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImageFile != null) {
        _cropImage(pickedImageFile.path);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future _cropImage(filepath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filepath,
      maxWidth: 800,
      maxHeight: 500,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 0.625),
    );
    if (croppedImage != null) {
      pickedImage = croppedImage;
      setState(() {});
    }
  }

  Book? newBook() {
    try {
      final book = Book(
        id: Uuid().v4(),
        title: titleCtrl.text,
        owner: 'takeshi',
        leaveDay: leaveDay!,
        price: int.parse(priceCtrl.text),
        address: addressCtrl.text,
        requireNumber: int.parse(numCtrl.text),
        capacity: int.parse(capacityCtrl.text),
        target: targetCtrl.text,
        memberList: ['takeshiId'],
        ownerId: 'takeshiId',
        isRequireTool: isRequireTool,
      );
      return book;
    } catch (e) {
      return null;
    }
  }

  Future<void> uploadData(Book book) async {
    await FirebaseFirestore.instance.collection('books').doc(book.id).set(book.toJson());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text('作成', style: TextStyle(color: Colors.black87)),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_circle_up, color: Colors.teal),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: Text('募集を出しますか？'),
                  actions: [
                    TextButton(
                      child: Text('キャンセル'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: Text('募集を出す'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        final book = newBook();
                        if (book != null) {
                          uploadData(book);
                        } else {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              content: Text('入力に不備があります。'),
                              actions: [TextButton(child: Text('閉じる'), onPressed: () => Navigator.pop(ctx))],
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 120,
                    height: 75,
                    decoration: pickedImage != null
                        ? null
                        : BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400, width: .5),
                          ),
                    child: pickedImage != null
                        ? Image.file(pickedImage!)
                        : Image.asset('assets/images/noimage.png', fit: BoxFit.cover),
                  ),
                  SizedBox(width: 24),
                  TextButton.icon(
                    onPressed: _getImageFromCamera,
                    icon: Icon(Icons.camera_alt),
                    label: Text('写真'),
                  ),
                ],
              ),
              Divider(),
              StrTextField(titleCtrl: titleCtrl, label: 'タイトル'),
              SizedBox(height: 16),
              StrTextField(titleCtrl: addressCtrl, label: '集合場所'),
              SizedBox(height: 16),
              StrTextField(titleCtrl: targetCtrl, label: '狙い(魚)'),
              SizedBox(height: 16),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: _width / 4, child: NumTextField(ctrl: priceCtrl, label: '価格')),
                    Container(width: _width / 4, child: NumTextField(ctrl: numCtrl, label: '募集人数')),
                    Container(width: _width / 4, child: NumTextField(ctrl: capacityCtrl, label: '定員')),
                  ],
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: noteCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400, width: .5),
                  ),
                  labelText: '備考(空白可)',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              SizedBox(height: 8),
              CheckboxListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text('釣具は必要ですか？', style: TextStyle(fontSize: 14)),
                value: isRequireTool,
                onChanged: (value) {
                  isRequireTool = value!;
                  setState(() {});
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('日付を設定する'),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      final now = DateTime.now();
                      final date = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year, now.month, now.day),
                        lastDate: DateTime(now.year + 2),
                      );

                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (time != null) {
                          final finalDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                          leaveDay = finalDate;
                          setState(() {});
                        }
                      }
                    },
                  ),
                  if (leaveDay != null) Text(DateFormat('yyyy年MM月dd日 HH:mm').format(leaveDay!)),
                ],
              ),
              Divider(),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 48),
              //   child: ElevatedButton(child: Text('募集を出す'), onPressed: () {}),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class StrTextField extends StatelessWidget {
  const StrTextField({
    Key? key,
    required this.titleCtrl,
    required this.label,
  }) : super(key: key);

  final TextEditingController titleCtrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleCtrl,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: .5),
        ),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

class NumTextField extends StatelessWidget {
  const NumTextField({
    Key? key,
    required this.ctrl,
    required this.label,
  }) : super(key: key);

  final TextEditingController ctrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: .5),
        ),
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
