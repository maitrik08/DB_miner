import 'package:db_miner/Database_helper.dart';
import 'package:db_miner/FavouriteQuateScreen.dart';
import 'package:db_miner/ModelClass.dart';
import 'package:db_miner/Quatedetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatefulWidget {
  CategoryDetail({Key? key, required this.CategoryName});
  String CategoryName = '';

  @override
  State<CategoryDetail> createState() => _CategoryDetailState(CategoryName: CategoryName);
}

final RxList<ModelClass> FavouriteQuote = <ModelClass>[].obs;

class _CategoryDetailState extends State<CategoryDetail> {
  _CategoryDetailState({required this.CategoryName});
  String CategoryName = '';
  List<Map<String, dynamic>> quotes = [];

  @override
  void initState() {
    GetQuate();
    super.initState();
  }

  Future<void> GetQuate() async {
    quotes = await QuoteHelper().getQuotesByCategory(CategoryName);
    print(quotes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CategoryName),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(FavouriteQuateScreen());
            },
            icon: Icon(Icons.favorite_border),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: InkWell(
              onTap: () {
                Quote = quotes[index]['quote'] ?? '';
                Author = quotes[index]['author'] ?? '';
                print('$Quote $Author');
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Quatedetail()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Color(0x30A1D0F6),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            quotes[index]['quote'] ?? '',
                          ),
                        ),
                      ),
                    ),
                    Obx(() => IconButton(
                      onPressed: () {
                        final category = quotes[index]['category'];
                        if (category != null && category is String) {
                          FavouriteQuote.contains(ModelClass(
                              quote: quotes[index]['quote'] ?? '',
                              author: quotes[index]['author'] ?? '',
                              category: category))
                              ? FavouriteQuote.remove(ModelClass(
                              quote: quotes[index]['quote'] ?? '',
                              author: quotes[index]['author'] ?? '',
                              category: category))
                              : FavouriteQuote.add(ModelClass(
                              quote: quotes[index]['quote'] ?? '',
                              author: quotes[index]['author'] ?? '',
                              category: category));
                          print(FavouriteQuote);

                          if (!FavoriteCategory.contains(category)) {
                            FavoriteCategory.add(category);
                          }
                          print(FavoriteCategory);
                        }
                      },
                      icon: FavouriteQuote.contains(ModelClass(
                          quote: quotes[index]['quote'] ?? '',
                          author: quotes[index]['author'] ?? '',
                          category: quotes[index]['category'] ?? ''))
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
