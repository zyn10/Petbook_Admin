import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petbook_admin/resources/firestore_methods.dart';
import 'package:petbook_admin/screens/home.dart';
import 'package:petbook_admin/utils/utils.dart';

class PetShowInfo extends StatefulWidget {
  const PetShowInfo({Key? key}) : super(key: key);

  @override
  State<PetShowInfo> createState() => _PetShowInfoState();
}

class _PetShowInfoState extends State<PetShowInfo> {
  bool _isloading = false;
  Uint8List? _image;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Future<void> push() async {
    setState(() {
      _isloading = true;
    });
    String output = await FireStoreMethods().uploadPetShowInfo(
        name: _nameController.text,
        location: _locationController.text,
        date: _dateController.text,
        time: _timeController.text,
        description: _descController.text,
        image: _image);
    setState(() {
      _isloading = false;
    });
    if (output != 'success') {
      // ignore: use_build_context_synchronously
      showSnackBar(context, output);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = getScreenSize();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Add Pet Show",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Form(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    "https://t3.ftcdn.net/jpg/02/10/49/86/360_F_210498655_ywivjjUe6cgyt52n4BxktRgDCfFg8lKx.jpg"),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.title_outlined),
                      hintText: "Title of the Petshow",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      if (value.length < 3 || value.length > 30) {
                        return 'Title should be between 3 to 30 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_pin),
                      hintText: "Location",
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Show Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      hintText: "Date",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      final dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                      if (!dateRegExp.hasMatch(value)) {
                        return 'Please enter a valid date in the format of yyyy-MM-dd';
                      }
                      try {
                        DateTime.parse(value);
                      } catch (e) {
                        return 'Please enter a valid date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.timer),
                      hintText: "Time",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a time';
                      }
                      final timeRegExp = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
                      if (!timeRegExp.hasMatch(value)) {
                        return 'Please enter a valid time in the format of HH:mm';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.edit_note_rounded),
                      hintText: "Description",
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: push,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(350, 50)),
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Add pet show'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
