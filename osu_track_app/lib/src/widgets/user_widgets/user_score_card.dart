import 'package:flutter/material.dart';

import '../../models/scores.dart';
import '../../utils/color_contrasts.dart' as my_colors;


class ScoreCardWidget extends StatelessWidget {

  final Scores _item;

  const ScoreCardWidget({Key? key, required Scores item}):
        _item = item,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery
        .of(context)
        .size
        .height;

    final List<Image> mods_icons = []; // for mods icons
    if (_item.mods != []) {
      for (int i = 0; i < _item.mods.length; i++) {
        String modeStr = "assets/icon_mods/mod_${_item.mods[i]
            .toLowerCase()}.png";
        mods_icons.add(Image.asset(modeStr, scale: 1));
      }
    }
    if (_item.mods.isEmpty == true) mods_icons.add(Image.asset(
        "assets/icon_mods/mod_nm.png", scale: 1)); // for no-mod score

    if (_item.gainedPP == null) {
      _item.gainedPP = 0;
    }
    return Card(
      color: my_colors.Palette.brown.shade100,
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Container(
        height: height / 7.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("${_item.coversJPG}"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.24), BlendMode.dstATop),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("${(_item.mapTitle)} by ${(_item.artistName)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Exo 2')
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/icon_score_types/grade_' +
                                          "${_item.mapRank}".toLowerCase() +
                                          ".png", scale: 0.75,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("[${(_item.difficultyName)}]",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: my_colors.Palette.yellow,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Exo 2')
                                ),
                                Row(
                                    children: [
                                      Image.asset(
                                          'assets/utils/yellow_star.png',
                                          scale: 30),
                                      Text("${(_item.difficultyRating)}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: my_colors.Palette.yellow,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Exo 2')
                                      ),
                                    ]
                                ),
                              ],
                            ),
                          ),
                          Text("${(_item.dateOfScore)}".substring(0, 10),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: my_colors.Palette.yellow,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Exo 2')
                          ),
                          SizedBox(width: 20,),
                          Text("${(_item.accuracy * 100).round()}%",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: my_colors.Palette.yellow,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Exo 2')
                          ),
                          SizedBox(height: 10,),
                          SizedBox(width: 20,),
                          Text("${(_item.gainedPP).round()}pp",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: my_colors.Palette.hotPink,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Exo 2')
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 15,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: mods_icons.length,
                                itemBuilder: (context, index) {
                                  return mods_icons[index];
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}