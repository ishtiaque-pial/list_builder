import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as ew;

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<ew.WordPair> words = [];
  List<ew.WordPair> favWord = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    words = ew.generateWordPairs().take(100).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List page'),
      ),
      body: buildListView(_selectedIndex==1),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'Favorite')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:  Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  ListView buildListView(bool isFav) {
    return ListView.builder(
        itemCount: isFav? favWord.length: words.length,
        itemBuilder: (context, index) {
          final pair = isFav? favWord[index]: words[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              tileColor: Colors.blueGrey.shade900,
              title: RichText(
                text: TextSpan(
                    text: pair.first,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    children: [
                      TextSpan(
                          text: pair.second,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber))
                    ]),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (favWord.contains(pair)) {
                      favWord.remove(pair);
                    } else {
                      favWord.add(pair);
                    }
                  });
                },
                icon: favWord.contains(pair)
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border, color: Colors.white),
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }
}
