import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/pages/akun/profile_page.dart';
import 'package:core/presentation/pages/akun/widgets/button_page_profile.dart';
import 'package:core/presentation/pages/akun/widgets/form_edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  List<String> _gender = ["Laki-laki", "Wanita", "Lainnya"];
  String _selectedGender = "Laki-laki";

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController!.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  Future updateData() async {
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection("users-form-data");
      return _collectionRef
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        "name": _nameController!.text,
        "nickName": _nickNameController!.text,
        "phone": _phoneController!.text,
        "dob": _dobController!.text,
        "gender": _selectedGender,
        "age": _ageController!.text,
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.lightBlue,
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/fotoProfil.jpg'),
                          ),
                          Positioned(
                            right: -5,
                            bottom: 0,
                            child: SizedBox(
                              height: 46,
                              width: 46,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey.shade100),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side:
                                          const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: SvgPicture.asset(
                                  'assets/icons/Camera.svg',
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.email!,
                      style: TextStyle(
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
                    SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        _nickNameController =
                            TextEditingController(text: data['nickName']),
                        'Nama Panggilan',
                        data['nickName'],
                        TextInputType.text),
                    SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        _phoneController =
                            TextEditingController(text: data['phone']),
                        'Nomor Telephone',
                        data['phone'],
                        TextInputType.number),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
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
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => updateData(),
                        child: Container(
                            height: 50,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(child: Text('Perbaruhi Data'))))
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
            style: TextStyle(fontSize: 17, color: Colors.grey),
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
