import 'package:flutter/material.dart';
import 'package:petbook_admin/alerts/local_alerts.dart';
import 'package:petbook_admin/resources/firestore_methods.dart';
import 'package:petbook_admin/screens/home.dart';
import 'package:petbook_admin/utils/utils.dart';

class CreateAlert extends StatefulWidget {
  const CreateAlert({Key? key}) : super(key: key);

  @override
  State<CreateAlert> createState() => _CreateAlertState();
}

class _CreateAlertState extends State<CreateAlert> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> push() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String output = await FireStoreMethods().pushAlert(
        title: _titleController.text,
        date: _dateController.text,
        description: _descController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (output != 'success') {
        // ignore: use_build_context_synchronously
        showSnackBar(context, output);
      } else {
        NotificationService().showNotification(
          title: _titleController.text,
          body: 'Alert pushed',
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Generate Alert",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.title_outlined),
                      hintText: "Title",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
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
                      prefixIcon: Icon(Icons.description),
                      hintText: "Description",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description Empty';
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
                      hintText: "dd-mm-yy",
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
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
                      minimumSize: const Size(350, 50),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Push Alert'),
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
