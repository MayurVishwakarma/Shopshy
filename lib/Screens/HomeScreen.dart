import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopshy/Bloc/Product/Product_bloc.dart';
import 'package:shopshy/Core/Utils/imports.dart';
import 'package:shopshy/Core/Utils/text_builder.dart';
import 'package:shopshy/Repository/Product_repository.dart';
import 'package:shopshy/Screens/LoginScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(productRepository: ProductRepository())
        ..add(FetchProducts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              var filteredProducts = state.products
                  .where((product) => product['title']!
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: textEditingController,
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5 / 4,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: filteredProducts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    product['image'],
                                    height: MediaQuery.sizeOf(context).height,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                    colorBlendMode: BlendMode.overlay,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: TextBuilder(
                                        text: product['title']!,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        maxLines: 3,
                                        textOverflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: SizedBox(
                                        // height: 50,
                                        width: double.infinity,
                                        child: RatingBar.builder(
                                          initialRating: double.tryParse(
                                              product['rating']['rate']
                                                  .toString())!,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          itemSize: 15,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2, right: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const TextBuilder(
                                                text: '₹ ',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 24,
                                              ),
                                              TextBuilder(
                                                text: product['price']!
                                                    .round()
                                                    .toString(),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue.shade700,
                                                foregroundColor: Colors.white,
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                padding:
                                                    const EdgeInsets.all(5),
                                              ),
                                              child: const Text('Cart')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No products'));
          },
        ),
      ),
    );
  }
}
