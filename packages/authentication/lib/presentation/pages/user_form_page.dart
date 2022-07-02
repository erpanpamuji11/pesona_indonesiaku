// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/pages/ParentPage.dart';
import 'package:core/widgets/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({Key? key}) : super(key: key);

  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final List<String> _gender = ["Laki-laki", "Wanita", "Lainnya"];
  String _selectedGender = "Laki-laki";

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  Future sendUserDataToDB() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;

      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("users-form-data");
      return _collectionRef
          .doc(currentUser!.email)
          .set({
            "name": _nameController.text,
            "nickName": _nickNameController.text,
            "phone": _phoneController.text,
            "dob": _dobController.text,
            "gender": _selectedGender,
            "age": _ageController.text,
          })
          .then((value) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const ParentPage())))
          .catchError((error) => print("something is wrong. $error"));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nickNameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Masukan Data Diri Anda",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Kami tidak akan menyebarluaskan informasi yang diberikan kepada siapapun.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                buildTextField(_nameController, "Nama Lengkap",
                    "Masukan Nama Lengkap", TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                buildTextField(_nickNameController, "Nama Panggilan",
                    "Masukan Nama Panggilan", TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                buildTextField(_phoneController, "Nomor Telephone",
                    "Masukan Nomor Telephone", TextInputType.number),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Tanggal Lahir",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: const Icon(Icons.calendar_today_outlined,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildDropDown("Jenis Kalamin", _gender),
                const SizedBox(
                  height: 20,
                ),
                buildTextField(_ageController, "Umur", "Masukan Umur",
                    TextInputType.number),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () => sendUserDataToDB(),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      width: double.maxFinite,
                        child: const Center(child: Text('Simpan Data'))
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDropDown(String hinText, List<String> dataList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hinText,
            style: const TextStyle(fontSize: 17, color: Colors.grey),
          ),
          value: _selectedGender,
          iconSize: 25,
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
          items: dataList.map((location) {
            return DropdownMenuItem(
              child: Text(location),
              value: location,
            );
          }).toList(),
        ),
      ),
    );
  }
}
