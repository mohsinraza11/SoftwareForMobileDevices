import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'me_screen.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({Key? key}) : super(key: key);

  @override
  _CatScreenState createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  bool showTile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(),
            _buildCatTile(),
            _buildCatTile(),
            _buildTitle2(),
            _buildCatTile(),
            _buildCatTile(),
            _buildCatTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0, bottom: 20.0, left: 20.0),
      child: Text(
        'Featured',
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2.0,
              offset: const Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle2() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20.0, left: 20.0),
      child: Text(
        'All cats',
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: 1.2,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2.0,
              offset: const Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatTile() {
    return IntrinsicHeight(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the desired border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCatImage(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCatDetails(),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: _buildAddButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0), // Set the desired border radius
      child: const Image(
        image: NetworkImage(
          'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQ5pAUkFjASncLgVEsqVbwyTj0LP1ObO85jakWZEibYYmjHzzQux9-C1zQ2DXiZnAldF_l5_EXyZXQqQf4',
        ),
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCatDetails() {
    return const ListTile(
      title: Text(
        'Awesome Cat',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Very nice cat with cute ears',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 200, // Set the desired width
      child: ElevatedButton(
        onPressed: () {
          _sendCatDataToFirestore();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.orange,
        ),
        child: const Text('Add'),
      ),
    );
  }

  void _sendCatDataToFirestore() {
    final catData = {
      'imageUrl': 'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQ5pAUkFjASncLgVEsqVbwyTj0LP1ObO85jakWZEibYYmjHzzQux9-C1zQ2DXiZnAldF_l5_EXyZXQqQf4',
      'name': 'Awesome Cat',
      'description': 'Very nice cat with cute ears',
    };

    FirebaseFirestore.instance
        .collection('cats') 
        .add(catData)
        .then((_) {
      // Success! Data added to Firestore
      print('Cat data sent to Firestore successfully!');
    })
    .catchError((error) {
      // Error occurred while sending data to Firestore
      print('Error sending cat data to Firestore: $error');
    });
  }
}