import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data/new_service.dart';
import 'models/articles.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Articles> articles = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    NewsService.getNews().then((value) {
      print(value);
      setState(() {
        articles = value ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haberler'),
        centerTitle: true,
      ),
      body: Center(
          child: articles.isEmpty
              ? Text("loading or something")
              : ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          if (articles[index].urlToImage != null)
                            Image.network(articles[index].urlToImage!),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(articles[index].title ?? ""),
                            subtitle: Text(articles[index].author ?? ""),
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
                                    if (articles[index].url == null) {
                                      return;
                                    }
                                    await launchUrl(
                                        Uri.parse(articles[index].url!));
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
