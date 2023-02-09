import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List userList;
  const UserList({Key? key,required this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 16,
                left: 24,
                right: 24,
              ),
              child: Row(children: [
                CircleAvatar (
                  child: CachedNetworkImage(
                    imageUrl: userList[index]["avatar"] ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 110,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover,),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/errorimage.jpg',
                      fit: BoxFit.cover,),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userList[index]["phone_number"] ?? 'No Numbers',
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(userList[index]["username"] ?? 'No Username',
                        style: const TextStyle(fontSize: 12),)
                    ],
                  ),
                )
              ],),
            );
          }),
    );
  }
}
