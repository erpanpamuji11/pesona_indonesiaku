import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
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

  Future updateData() async {
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("users-form-data");
      return _collectionRef
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        "name": _nameController.text,
        "nickName": _nickNameController.text,
        "phone": _phoneController.text,
        "dob": _dobController.text,
        "gender": _selectedGender,
        "age": _ageController.text,
      }).then((value) => print("Updated Successfully"));
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
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Edit Profil',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users-form-data")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.email!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        _nameController =
                            TextEditingController(text: data['name']),
                        'Nama User',
                        data['name'],
                        TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        _nickNameController =
                            TextEditingController(text: data['nickName']),
                        'Nama Panggilan',
                        data['nickName'],
                        TextInputType.text),
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        _phoneController =
                            TextEditingController(text: data['phone']),
                        'Nomor Telephone',
                        data['phone'],
                        TextInputType.number),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: data['dob'],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: IconButton(
                          onPressed: () => _selectDateFromPicker(context),
                          icon: const Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _buildDropDown("Jenis Kalamin", _gender, _selectedGender),
                    const SizedBox(
                      height: 15,
                    ),
                    textFormField(
                        _ageController =
                            TextEditingController(text: data['age']),
                        'Umur',
                        data['age'],
                        TextInputType.number),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => updateData(),
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Center(child: Text('Perbaruhi Data'))))
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget textFormField(TextEditingController controller, String labelText,
      String hintText, TextInputType inputType) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black, fontSize: 17),
      validator: (value) {
        if (value!.isEmpty) {
          return "it is empty";
        } else {
          return null;
        }
      },
      keyboardType: inputType,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 17),
          labelStyle: const TextStyle(color: Colors.grey),
          // prefix: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  _buildDropDown(String hinText, List<String> dataList, String dataDB) {
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
          value: dataDB,
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
