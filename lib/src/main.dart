import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/services/scraper_service.dart';
import 'src/widgets/input_form.dart';
import 'src/widgets/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Scraper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ScraperService(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Amazon Scraper'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                InputForm(),
                ProductList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

