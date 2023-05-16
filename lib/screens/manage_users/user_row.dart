import 'package:flutter/material.dart';
import 'package:petbook_admin/resources/firestore_methods.dart';
import 'package:petbook_admin/screens/manage_users/manage_users.dart';

class UserRow extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;
  const UserRow({
    super.key,
    required this.snap,
  });

  @override
  State<UserRow> createState() => _UserRowState();
}

class _UserRowState extends State<UserRow> {
  int commentLength = 0;
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
              .copyWith(right: 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  widget.snap["photoUrl"],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['fullname'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    FireStoreMethods().deleteUser(widget.snap['uid']);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManagerUser()),
                    );
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
        const Divider(
          // Add a Divider widget as a separator
          height: 1,
          color: Colors.grey,
        ),
      ]),
    );
  }
}
