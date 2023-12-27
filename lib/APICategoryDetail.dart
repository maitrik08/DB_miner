import 'dart:convert';
import 'dart:ffi';
import 'package:db_miner/Categorydetail.dart';
import 'package:db_miner/FavouriteQuateScreen.dart';
import 'package:db_miner/ModelClass.dart';
import 'package:db_miner/Quatedetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class APICategoryDetail extends StatefulWidget {
   APICategoryDetail({Key? key,required this.Category_Name}) : super(key: key);
  String Category_Name = '';

  @override
  State<APICategoryDetail> createState() => _APICategoryDetailState(Category_Name: Category_Name);
}

class _APICategoryDetailState extends State<APICategoryDetail> {
  _APICategoryDetailState({required this.Category_Name});
  List<ModelClass> quoteList = [];
  late Database database;
  String Category_Name = '';
  @override
  void initState() {
    super.initState();
    print(Category_Name);
    openDatabaseAndFetchData();
  }

  Future<void> openDatabaseAndFetchData() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'quotes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, quote TEXT, author TEXT)',
        );
      },
      version: 1,
    );
    await fetchDataFromAPI();
  }
  Future<void> deleteAllData() async {
    try {
      await database.delete('quotes');
      print('All data deleted successfully.');
    } catch (error) {
      print('Error deleting data: $error');
    }
  }

  Future<void> fetchDataFromAPI() async {
    var apiKey = '9PeOWi/rY86tzaUgTTepqA==tUKwHrndNJ06hxsF';

    try {
      for (int i = 0; i < 10; i++) {
        var response = await http.get(
          Uri.parse('https://api.api-ninjas.com/v1/quotes?category=$Category_Name'),
          headers: {'X-API-KEY': apiKey},
        );

        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body) as List<dynamic>;

          for (var item in jsonData) {
            ModelClass modelClass = ModelClass.fromJson(item);
            quoteList.add(modelClass);
            await database.insert('quotes', {
              'quote': modelClass.quote,
              'author': modelClass.author,
            });
          }
        } else {
          print('Request failed with status: ${response.statusCode}.');
          print('Response body: ${response.body}');
        }
      }

      setState(() {}); // Trigger a rebuild with the new data
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Category_Name),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            deleteAllData();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                 Get.to(FavouriteQuateScreen());
              },
              icon: Icon(Icons.favorite_border)
          )
        ],
      ),
      body:  ListView.builder(
        itemCount: quoteList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: InkWell(
              onTap: () {
                Quote = quoteList[index].quote;
                Author = quoteList[index].author;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Quatedetail()));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Color(0x30A1D0F6)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            quoteList[index].quote,
                          ),
                        )
                      ),
                      Obx(() =>
                          IconButton(
                            onPressed: () {
                              FavouriteQuote.contains(quoteList[index])
                                  ? FavouriteQuote.remove(quoteList[index])
                                  : FavouriteQuote.add(quoteList[index]);

                              print(FavouriteQuote);
                              if(FavoriteCategory.contains(quoteList[index].category)){

                              }else{
                                FavoriteCategory.add(quoteList[index].category);
                              }
                            },
                            icon: FavouriteQuote.contains(quoteList[index])
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border),
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }

}

