import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:beautifulsoup/beautifulsoup.dart';
import '../models/product.dart';

class ScraperService {
  Future<List<Product>> scrapeAmazon(String url, double minPrice, double maxPrice, double minRating) async {
    List<Product> products = [];

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        Beautifulsoup soup = Beautifulsoup(document.outerHtml);

        // Example of selecting elements by class
        var productElements = soup.find_all(".s-result-item");

        for (var productElement in productElements) {
          String title = productElement.attributes['data-title'] ?? '';

          String priceStr = productElement.attributes['data-price'] ?? '0';
          double price = double.tryParse(priceStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

          String ratingStr = productElement.attributes['data-rating'] ?? '0';
          double rating = double.tryParse(ratingStr.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

          String imageUrl = productElement.attributes['data-image-url'] ?? '';

          if (price >= minPrice && price <= maxPrice && rating >= minRating) {
            products.add(Product(
              title: title,
              price: price,
              rating: rating,
              imageUrl: imageUrl,
            ));
          }
        }
      } else {
        throw Exception('Failed to load Amazon page');
      }
    } catch (e) {
      print('Error: $e');
    }
    print('Products: ${jsonEncode(products)}');
    return products;
  }
}
