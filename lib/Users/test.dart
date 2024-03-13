import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nested ListViews Example'),
        ),
        body: Column(
          children: [
            Container(
              width: 400.0,
              height: 180.0,
              child: Image.asset(
                'assets/images/banner.jpg', // Replace with your image asset path
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Center(
                child: Text(
                  'منسق الحفلات',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              height: 400.0, // Set a fixed height or adjust as needed
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          data[index]['image']!,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          data[index]['title']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          data[index]['subtitle']!,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Your data list here
  final List<Map<String, String>> data = [
    {'title': 'Item 1', 'subtitle': 'Subtitle 1', 'image': 'assets/image1.jpg'},
    {'title': 'Item 2', 'subtitle': 'Subtitle 2', 'image': 'assets/image2.jpg'},
    {'title': 'Item 3', 'subtitle': 'Subtitle 3', 'image': 'assets/image3.jpg'},
    // Add more items as needed
  ];
}
