import 'package:flutter/material.dart';

void main() {
  runApp(const Answer3());
}

class Answer3 extends StatelessWidget {
  const Answer3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 255, 38),
        ),
        useMaterial3: true,
      ),
      home: const ProductLayoutExample(),
    );
  }
}

class ProductLayoutExample extends StatelessWidget {
  const ProductLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Layout'),
        backgroundColor: const Color.fromARGB(255, 116, 255, 82),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Category: Electronics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Product rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProductItem(
                imageUrl:
                    'https://imageio.forbes.com/specials-images/imageserve/6076fda9c9e7907b23b68268/0x0.png?format=png&height=900&width=1600&fit=bounds',
                name: 'Laptop',
                price: '999 THB',
              ),
              ProductItem(
                imageUrl:
                    'https://chumley.barstoolsports.com/union/2020/12/02/motorola-razr-foldable-phone-comeback-01.62d89627.jpg?fit=bounds&format=pjpg&auto=webp&quality=85%2C75',
                name: 'Smartphone',
                price: '699 THB',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProductItem(
                imageUrl:
                    'https://i.pinimg.com/736x/52/00/b9/5200b979c2cc951b28623552902f1e58.jpg',
                name: 'Tablet',
                price: '499 THB',
              ),
              ProductItem(
                imageUrl:
                    'https://media.tenor.com/o6SO0T0uaqkAAAAe/camera-carl.png',
                name: 'Camera',
                price: '299 THB',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;

  const ProductItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          imageUrl,
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
