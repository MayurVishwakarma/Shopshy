import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.orange, borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.yellow, borderRadius: BorderRadius.circular(8)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.27,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(8)),
            )
          ],
        ));
  }
}
