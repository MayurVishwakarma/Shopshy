// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shopshy/Models/ProductMasterModel.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductMasterModel? product;
  ProductDetailsScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(5)),
            child: Hero(
              tag: 'product_${product?.id}',
              child: Image.network(
                product?.image ?? '',
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(3),
                  child: const Text(
                    "Free Shipping",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                const Icon(Icons.favorite_border_outlined)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${product?.title}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${product?.description}",
              style:
                  const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Text(
              "₹ ${((product?.price ?? 0.0) * 83.65).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
