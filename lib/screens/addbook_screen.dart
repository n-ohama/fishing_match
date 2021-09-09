import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddbookScreen extends StatefulWidget {
  static const routeName = '/add';
  @override
  _AddbookScreenState createState() => _AddbookScreenState();
}

class _AddbookScreenState extends State<AddbookScreen> {
  bool isRequireTool = true;
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    print(_width);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text('作成', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 8),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('タイトル'),
                Container(
                  width: 240,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('集合場所'),
                Container(
                  width: 240,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('狙い(魚)'),
                Container(
                  width: 240,
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
              ],
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _width / 5,
                    child: Column(
                      children: [
                        Text('料金', textAlign: TextAlign.left),
                        TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _width / 5,
                    child: Column(
                      children: [
                        Text('募集人数'),
                        TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _width / 5,
                    child: Column(
                      children: [
                        Text('定員'),
                        TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            CheckboxListTile(
              title: Text('釣具は必要ですか？'),
              value: isRequireTool,
              onChanged: (value) {
                isRequireTool = value!;
                setState(() {});
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';

// import 'package:fishing_match/models/book.dart';
// import 'package:fishing_match/models/books.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

// class AddbookScreen extends StatefulWidget {
//   final String uid;
//   AddbookScreen(this.uid);
//   @override
//   _AddbookScreenState createState() => _AddbookScreenState();
// }

// class _AddbookScreenState extends State<AddbookScreen> {
//   bool _isLoading = false;

//   String? title;
//   String? owner;
//   int? price;
//   String? address;
//   String? leaveDay;
//   int? requireNumber;
//   int? capacity;
//   String? target;
//   String note = '';
//   bool isRequiredTool = true;

//   File? _pickedImage;

//   DateTime? pickDay;
//   TimeOfDay? pickTime;
//   final now = DateTime.now();

//   final titleController = TextEditingController();
//   final ownerController = TextEditingController();
//   final priceController = TextEditingController();
//   final addressController = TextEditingController();
//   final requireNumberController = TextEditingController();
//   final capacityController = TextEditingController();
//   final targetController = TextEditingController();
//   final noteController = TextEditingController();

//   void onSaveForm() {
//     setState(() {
//       if (titleController.text.isNotEmpty) {
//         title = titleController.text;
//       }
//       if (ownerController.text.isNotEmpty) {
//         owner = ownerController.text;
//       }
//       if (addressController.text.isNotEmpty) {
//         address = addressController.text;
//       }
//       if (priceController.text.isNotEmpty) {
//         price = int.parse(priceController.text);
//       }
//       if (requireNumberController.text.isNotEmpty) {
//         requireNumber = int.parse(requireNumberController.text);
//       }
//       if (capacityController.text.isNotEmpty) {
//         capacity = int.parse(capacityController.text);
//       }
//       if (targetController.text.isNotEmpty) {
//         target = targetController.text;
//       }
//       note = noteController.text;
//     });
//   }

//   Future _getImageFromCamera() async {
//     try {
//       final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedImageFile != null) {
//         _cropImage(pickedImageFile.path);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future _cropImage(filepath) async {
//     File? croppedImage = await ImageCropper.cropImage(
//       sourcePath: filepath,
//       maxWidth: 800,
//       maxHeight: 500,
//       aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 0.625),
//     );
//     if (croppedImage != null) {
//       _pickedImage = croppedImage;
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     ownerController.dispose();
//     priceController.dispose();
//     addressController.dispose();
//     requireNumberController.dispose();
//     capacityController.dispose();
//     targetController.dispose();
//     noteController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
//     final bookProvider = Provider.of<Books>(context, listen: false);
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       padding: EdgeInsets.only(top: 8, right: 8, bottom: bottomSpace, left: 8),
//       child: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(width: 48),
//                     Text(
//                       '予約',
//                       style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 75,
//                       decoration: _pickedImage != null ? null : BoxDecoration(border: Border.all()),
//                       child: _pickedImage != null
//                           ? Image.file(_pickedImage!)
//                           : Image.asset('assets/images/noimage.png', fit: BoxFit.cover),
//                     ),
//                     TextButton.icon(
//                       onPressed: _getImageFromCamera,
//                       icon: Icon(Icons.camera_alt),
//                       label: Text('写真'),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(hintText: '料金', labelText: '料金'),
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                         controller: priceController,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(hintText: '募集人数', labelText: '募集人数'),
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                         controller: requireNumberController,
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(hintText: '定員', labelText: '定員'),
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                         controller: capacityController,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 4),
//                 Text('※料金、募集人数、定員は数字のみ入力。'),
//                 SizedBox(height: 8),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'タイトル',
//                     labelText: 'タイトル',
//                   ),
//                   controller: titleController,
//                 ),
//                 SizedBox(height: 8),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: '投稿者名',
//                     labelText: '投稿者名',
//                   ),
//                   controller: ownerController,
//                 ),
//                 SizedBox(height: 8),
//                 TextField(
//                   decoration: InputDecoration(hintText: '集合場所', labelText: '集合場所'),
//                   controller: addressController,
//                 ),
//                 SizedBox(height: 16),
//                 Text('集合時間', style: TextStyle(color: Colors.black54, fontSize: 16)),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       width: 150,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           FocusScope.of(context).unfocus();
//                           final pickedDay = await showDatePicker(
//                             context: context,
//                             locale: const Locale("ja"),
//                             initialDate: pickDay ?? DateTime.now(),
//                             firstDate: DateTime(now.year),
//                             lastDate: DateTime(now.year + 1),
//                           );
//                           if (pickedDay != null) {
//                             setState(() {
//                               pickDay = pickedDay;
//                             });
//                           }
//                         },
//                         child: Text('日付'),
//                         style: ElevatedButton.styleFrom(primary: Colors.grey),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 150,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           FocusScope.of(context).unfocus();
//                           final pickedTime = await showTimePicker(
//                             context: context,
//                             initialTime: pickTime ?? TimeOfDay.now(),
//                           );
//                           if (pickedTime != null) {
//                             setState(() {
//                               pickTime = pickedTime;
//                             });
//                           }
//                         },
//                         child: Text('時間'),
//                         style: ElevatedButton.styleFrom(primary: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                         pickDay == null
//                             ? Text('日付を選択してください',
//                                 style: TextStyle(color: Colors.black54, fontSize: 12))
//                             : Text('${DateFormat('yyyy年MM月dd日').format(pickDay!)}'),
//                         Container(
//                           width: 150,
//                           child: Divider(
//                             thickness: 1,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         pickTime == null
//                             ? Text('時間を選択してください',
//                                 style: TextStyle(color: Colors.black54, fontSize: 12))
//                             : Text(
//                                 '${DateFormat('HH時mm分').format(DateTime(0, 0, 0, pickTime!.hour, pickTime!.minute))}',
//                               ),
//                         Container(
//                           width: 150,
//                           child: Divider(
//                             thickness: 1,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 TextField(
//                   decoration: InputDecoration(hintText: '狙い(魚名)', labelText: '狙い(魚名)'),
//                   controller: targetController,
//                 ),
//                 SizedBox(height: 8),
//                 TextField(
//                   decoration: InputDecoration(hintText: '備考(空白でも大丈夫です)', labelText: '備考'),
//                   controller: noteController,
//                 ),
//                 SizedBox(height: 16),
//                 CheckboxListTile(
//                   title: Text('釣具は持参ですか？'),
//                   value: isRequiredTool,
//                   onChanged: (value) {
//                     setState(() {
//                       isRequiredTool = value!;
//                     });
//                   },
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     onSaveForm();
//                     final id = Uuid().v1();
//                     final pickDateTime = DateTime(pickDay!.year, pickDay!.month, pickDay!.day,
//                         pickTime!.hour, pickTime!.minute);
//                     if (pickDay != null && pickTime != null) {
//                       setState(() {
//                         leaveDay = DateFormat('MM月dd日 - HH:mm').format(pickDateTime);
//                       });
//                     }
//                     final List nullCheckList = [
//                       title,
//                       owner,
//                       price,
//                       address,
//                       leaveDay,
//                       requireNumber,
//                       capacity,
//                       target
//                     ];
//                     if (nullCheckList.contains(null)) {
//                       showDialog(
//                         context: context,
//                         builder: (ctx) => AlertDialog(
//                           title: Text('入力に不備があります。'),
//                         ),
//                       );
//                     } else {
//                       setState(() {
//                         _isLoading = true;
//                       });
//                       final Book formBook = Book(
//                         id: id,
//                         title: title!,
//                         owner: owner!,
//                         leaveDay: leaveDay!,
//                         leaveDateTime: pickDateTime,
//                         price: price!,
//                         address: address!,
//                         requireNumber: requireNumber!,
//                         capacity: capacity!,
//                         target: target!,
//                         note: note,
//                         isRequiredTool: isRequiredTool,
//                         memberList: [widget.uid],
//                         ownerId: widget.uid,
//                       );
//                       await bookProvider.addBook(formBook, _pickedImage);
//                       setState(() {
//                         _isLoading = false;
//                       });
//                       Navigator.of(context).pop();
//                     }
//                   },
//                   child: Text('予約する', style: TextStyle(fontSize: 20)),
//                 ),
//                 SizedBox(height: 16)
//               ],
//             ),
//     );
//   }
// }
