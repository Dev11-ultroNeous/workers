import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List newsList;
  const NewsList({Key? key,required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              key: const Key('article_list_item'),
              margin: const EdgeInsets.only(
                bottom: 16,
                left: 24,
                right: 24,
              ),
              child: Row(children: [
                SizedBox(
                  width: 110,
                  height: 80,
                  child: CachedNetworkImage(
                    imageUrl: newsList[index]["urlToImage"] ?? '',
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
                        newsList[index]["title"] ?? 'No Title',
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(newsList[index]["author"] ?? 'No Author',
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
