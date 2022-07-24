import 'package:flutter/material.dart';
import 'package:haber_app/data/new_service.dart';
import 'package:haber_app/models/articles.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Articles> articles = [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haberler'),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(articles[index].urlToImage!),
                      ListTile(
                        leading: Icon(Icons.arrow_drop_down_circle),
                        title: Text(articles[index].title!),
                        subtitle: Text(articles[index].author!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            'açıklama açıklama açıklamaaçıklama açıklamaaçıklama'),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                await launchUrl(articles[index].url);
                              },
                              child: Text('Habere git'))
                        ],
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
