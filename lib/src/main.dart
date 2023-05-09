import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/services/scraper_service.dart';
import 'src/widgets/input_form.dart';
import 'src/widgets/product_list.dart';
import 'src/models/product.dart';

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
          body: AmazonScraper(),
        ),
      ),
    );
  }
}

class AmazonScraper extends StatefulWidget {
  @override
  _AmazonScraperState createState() => _AmazonScraperState();
}

class _AmazonScraperState extends State<AmazonScraper> {
  List<Product> _products = [];

  void _handleInput(String url, double minPrice, double maxPrice, double minRating) async {
    final scraperService = Provider.of<ScraperService>(context, listen: false);
    List<Product> scrapedProducts = await scraperService.scrapeAmazon(url, minPrice, maxPrice, minRating);
    setState(() {
      _products = scrapedProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InputForm(onSubmit: _handleInput),
          SizedBox(height: 16),
          _products.isNotEmpty
              ? ProductList(products: _products)
              : Center(child: Text('No products to display')),
        ],
      ),
    );
  }
}
