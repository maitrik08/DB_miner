import 'package:db_miner/Categorydetail.dart';
import 'package:db_miner/ModelClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteQuateScreen extends StatefulWidget {
  const FavouriteQuateScreen({super.key});

  @override
  State<FavouriteQuateScreen> createState() => _FavouriteQuateScreenState();
}
RxList<String> FavoriteCategory = RxList([]);
class _FavouriteQuateScreenState extends State<FavouriteQuateScreen> {
  RxList<bool> open = RxList([]);
  @override
  void initState() {
    for(int i = 0; i <FavoriteCategory.length; i++) {
      open.add(false);
    }
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Quotes'),
      ),
      body: ListView.builder(
        itemCount: FavoriteCategory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Color(0x30A1D0F6)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FavoriteCategory[index],
                            style: TextStyle(
                             fontSize: 18
                            ),
                          ),
                          Obx(() =>
                            IconButton(
                                onPressed: () {
                                  open[index]=!open[index];
                                },
                                icon: Icon(open[index]?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_sharp)
                            )
                          )
                        ],
                      ),
                      Obx(() => open[index] ? LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: Categoryquote(Category: FavoriteCategory[index]).length,
                              itemBuilder: (context, i) {
                                ModelClass quote = Categoryquote(Category: FavoriteCategory[index])[i];
                                return Column(
                                  children: [
                                    Divider(),
                                    Text(quote.quote),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('-${quote.author}'),
                                      ],
                                    ),

                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ) : SizedBox()),

                    ],
                  )
                ),
              ),
            );
          },
      ),
    );
  }
  List<ModelClass> Categoryquote({required String Category}){
    List<ModelClass> Quote =[];
    for(int i = 0; i <FavouriteQuote.length;i++){
      if(FavouriteQuote[i].category == Category){
        Quote.add(FavouriteQuote[i]);
      }
    }
    return Quote;
  }
}
