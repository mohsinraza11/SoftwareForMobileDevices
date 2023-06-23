import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({Key? key}) : super(key: key);

  @override
  _MeScreenState createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  List<Map<String, dynamic>> catDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchCatData();
  }

  Future<void> _fetchCatData() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('cats').get();

      final List<Map<String, dynamic>> fetchedData = [];
      snapshot.docs.forEach((doc) {
        fetchedData.add(doc.data());
      });

      setState(() {
        catDataList = fetchedData;
      });
    } catch (error) {
      print('Error fetching cat data: $error');
    }
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

  Widget _buildCatTile(int index) {
    final catData = catDataList[index];

    return IntrinsicHeight(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCatImage(catData['imageUrl']),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCatDetails(catData['name'], catData['description']),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.center,
                      child: _buildAddButton(index),
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

  Widget _buildCatImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.network(
        imageUrl,
        height: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCatDetails(String name, String description) {
    return ListTile(
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAddButton(int index) {
    return Container(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            // Remove the details and tile
            catDataList.removeAt(index);
          });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.grey,
        ),
        child: const Text('Remove'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(),
            const SizedBox(height: 8.0),
            _buildTitle2(),
            const SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: catDataList.length,
              itemBuilder: (context, index) {
                return _buildCatTile(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}