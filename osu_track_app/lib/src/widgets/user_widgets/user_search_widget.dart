import 'package:flutter/material.dart';
import '../../pages/user_tab_page.dart';

class UserSearchWidget extends StatelessWidget {

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 225,
        height: 35,
        child: TextField(
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: "Username",
            labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Exo 2',
                color: Colors.white),
            prefixIcon: Icon(Icons.search, size: 22, color: Colors.white),
            hintText: "Enter username",
            hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Exo 2',
                color: Colors.white54),
          ),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Exo 2',
              color: Colors.white),
          keyboardType: TextInputType.text,
          controller: textController,
          // onSubmitted: (_) => context.read<UserCubit>().loadUser(textController.text, 'osu'),
          onSubmitted: (_) => Navigator.push(context, MaterialPageRoute(builder: (context) => UserTabPage(username: textController.text))),
        ));

  }
}