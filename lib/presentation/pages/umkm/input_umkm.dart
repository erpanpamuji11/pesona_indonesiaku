import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class InputUmkmPage extends StatefulWidget {
  static const routeName = '/InputUMKM';
  const InputUmkmPage({Key? key}) : super(key: key);

  @override
  State<InputUmkmPage> createState() => _InputUmkmPageState();
}

class _InputUmkmPageState extends State<InputUmkmPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  //Kategori
  final List<String> _category = [
    "Kuliner",
    "Kerajinan",
    "Olah Raga",
    "Souvenir"
  ];
  String _selectedCategory = "Kuliner";

  String imageName = '';
  String collectionName = "umkm";
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  bool _isLoading = false;

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }
  }

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var uniqueKey = firestoreRef.collection(collectionName).doc();
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.totalBytes.toString() +
          "\t" +
          event.bytesTransferred.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      //now here will insert record inside database regard url
      if (uploadPath.isNotEmpty) {
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
          'name': nameController.text,
          'address': addressController.text,
          'category': _selectedCategory,
          'description': deskripsiController.text,
          'imgUrl': uploadPath
        }).then((value) => _showMessage("Wisata baru berhasil ditambahkan"));
      } else {
        _showMessage("Something while uploading image");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Input UMKM'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: [
                    _buildTextField(
                        nameController, "Nama UMKM", "Masukan Nama UMKM"),
                    const SizedBox(height: 10),
                    _buildTextField(addressController, "Alamat Lengkap",
                        "Masukan Alamat Lengkap"),
                    const SizedBox(height: 10),
                    _buildTextField(addressController, "Deskripsi Singkat",
                        "Tuliskan Deskripsi Singkat Mengenai Wisata Anda"),
                    const SizedBox(height: 10),
                    _buildDropDownCategory(),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => imagePicker(),
                      child: Container(
                        width: double.maxFinite,
                        height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload_file,
                              color: Colors.grey,
                            ),
                            Text(
                              'Upload Foto',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          autofocus: true,
                          child: const Text(
                            'Simpan Wisata',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {}),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  _buildTextField(
      TextEditingController controller, String labelText, String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black, fontSize: 17),
        validator: (value) {
          if (value!.isEmpty) {
            return "it is empty";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 17),
            labelStyle: const TextStyle(color: Colors.grey),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  _buildDropDownCategory() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text(
            "Masukan Kategori",
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          value: _selectedCategory,
          iconSize: 25,
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value!;
            });
          },
          items: _category.map((location) {
            return DropdownMenuItem(
              child: Text(location),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }

  _buildTextFieldParagraf(
      TextEditingController controller, String labelText, String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        maxLines: 5,
        controller: controller,
        style: const TextStyle(color: Colors.black, fontSize: 17),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 17),
            labelStyle: const TextStyle(color: Colors.grey),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}
