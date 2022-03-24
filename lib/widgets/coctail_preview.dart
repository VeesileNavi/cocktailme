import 'package:cocktailme/models/cocktail_model.dart';
import 'package:cocktailme/widgets/glassmorphic_widget.dart';
import 'package:flutter/material.dart';

class CocktailPreview extends StatelessWidget {
  final CocktailModel cocktailModel;
  final IconButton? icon;

  const CocktailPreview( {Key? key, required this.cocktailModel, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24.0),
        child: GlassmorphicContainer(
          height: MediaQuery.of(context).size.height / 8,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Image.network(cocktailModel.image!)),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: SizedBox(
                  width: MediaQuery.of(context).size.width/3,
                      child: Text(cocktailModel.name,
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Container(child: icon, width: MediaQuery.of(context).size.height/18,),
                )
              ],
            ),
          ),
        ));
  }
}
