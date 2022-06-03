import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class InputWisataPage extends StatefulWidget {
  static const routeName = '/InputWisata';
  const InputWisataPage({Key? key}) : super(key: key);

  @override
  State<InputWisataPage> createState() => _InputWisataPageState();
}

class _InputWisataPageState extends State<InputWisataPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  //provnicy
  final List<String> _provincy = [
    "Aceh",
    "Sumatera Utara",
    "Sumatera Barat",
    "Riau",
    "Kepulauan Riau",
    "Jambi",
    "Sumatera Selatan",
    "Kepulauan Bangka Belitung",
    "Bengkulu",
    "Lampung",
    "DKI Jakarta",
    "Banten",
    "Jawa Barat",
    "Jawa Tengah",
    "DI Yogyakarta",
    "Jawa Timur",
    "Bali",
    "Nusa Tenggara Barat",
    "Nusa Tenggara Timur",
    "Kalimantan Barat",
    "Kalimantan Tengah",
    "Kalimantan Selatan",
    "Kalimantan Timur",
    "Kalimantan Utara",
    "Sulawesi Utara",
    "Gorontal",
    "Sulawesi Tenga",
    "Sulawesi Barat",
    "Provinsi Sulawesi Selatan",
    "Sulawesi Tenggara",
    "Maluku",
    "Maluku Utara",
    "Papua Barat",
    "Papua"
  ];
  String _selectedProvincy = 'Jawa Tengah';

  //Kategori
  final List<String> _category = ["Alam", "Budaya", "Edukasi", "Sport"];
  String _selectedCategory = "Alam";

  String imageName = '';
  String collectionName = "wisata";
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
          'provincy': _selectedProvincy,
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
        style: TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Input Wisata'),
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: [
                    _buildTextField(
                        nameController, "Nama Wisata", "Masukan Nama Wisata"),
                    const SizedBox(height: 10),
                    _buildTextField(addressController, "Alamat Lengkap",
                        "Masukan Alamat Lengkap"),
                    const SizedBox(height: 10),
                    _buildDropDownprovincy(),
                    const SizedBox(height: 10),
                    _buildDropDownCategory(),
                    const SizedBox(height: 20),
                    _buildTextFieldParagraf(
                        deskripsiController,
                        "Deskripsi Singkat",
                        "Tuliskan Deskripsi Singkat Mengenai Wisata Anda"),
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
                          children: [
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
                          onPressed: () {
                            _uploadImage();
                          }),
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

  _buildDropDownprovincy() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text(
            "Masukan Provinsi",
            style: TextStyle(fontSize: 17, color: Colors.grey),
          ),
          value: _selectedProvincy,
          iconSize: 25,
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              _selectedProvincy = value!;
            });
          },
          items: _provincy.map((location) {
            return DropdownMenuItem(
              child: Text(location),
              value: location,
            );
          }).toList(),
        ),
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
