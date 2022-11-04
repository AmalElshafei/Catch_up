import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Helper/ConstHelper/ConstHelper.dart';

import 'Chatting.dart';

class Groups extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const Groups({Key? key, required this.userName, required this.groupId, required this.groupName}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      navigateToNextScreen(
          context,
          ChatPage(
            groupId: widget.groupId,
            groupName: widget.groupName,
            userName: widget.userName,
          ));
    },
   child:   Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: ConstantColors.pr,
          child: Text(
            widget.groupName.substring(0, 1).toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        title: Text(
          widget.groupName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Join the conversation as ${widget.userName}",
          style: const TextStyle(fontSize: 13),
        ),
      ),

    ));

}
  }

