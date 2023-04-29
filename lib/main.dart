import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorites List',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _favorites = prefs.getStringList('favorites') ?? [];
    });
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites);
  }

  void _toggleFavorite(String item) {
    setState(() {
      if (_favorites.contains(item)) {
        _favorites.remove(item);
      } else {
        _favorites.add(item);
      }
      _saveFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites List'),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 4',
            'Item 5',
          ].map((item) {
            return ListTile(
              title: Text(item),
              leading: Icon(
                _favorites.contains(item) ? Icons.favorite : Icons.favorite_border,
                color: _favorites.contains(item) ? Colors.red : null,
              ),
              onTap: () => _toggleFavorite(item),
            );
          }),
        ).toList(),
      ),
    );
  }
}
