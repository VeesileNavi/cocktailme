import 'package:cocktailme/api/cocktaildb_api.dart';
import 'package:cocktailme/hive/hive_interface.dart';
import 'package:cocktailme/stringbuilder/stringbuilder.dart';
import 'package:cocktailme/widgets/coctail_info.dart';
import 'package:cocktailme/widgets/glassmorphic_widget.dart';
import 'package:cocktailme/widgets/heart_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/cocktail_model.dart';
import '../transitions/slidetoproute.dart';

class RandomPage extends StatefulWidget {
  RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CocktailDbApi().getRandom(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          CocktailModel randomCocktail = snapshot.data;
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height / 10,
              backgroundColor: Colors.black,
              shadowColor: Colors.transparent,
              title: Center(
                  child: Text(randomCocktail.name,
                      )),
              leading: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh),
              ),
              actions: [StarButton(cocktailModel: randomCocktail)],
            ),
            body: Stack(children: [
              SvgPicture.asset(
                "lib/assets/images/HomeScreen.svg",
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //Cocktail Image
                          GlassmorphicContainer(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Image.network(randomCocktail.image!),
                            ),
                          ),
                          //Spacer
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 24,
                          ),
                          //Cocktail ingredients
                          GlassmorphicContainer(
                            child: Text(
                              "Ingredients:\n\n${buildStringFromList(randomCocktail.ingredients)}",
                            ),
                          ),
                          //Spacer
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 24,
                          ),
                          //Cocktail description
                          GlassmorphicContainer(
                            child: Text(
                              "Instructions:\n\n${randomCocktail.instructions}",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: Color.fromRGBO(236, 117, 255, 1),));
        }
      },
    );
  }
}
