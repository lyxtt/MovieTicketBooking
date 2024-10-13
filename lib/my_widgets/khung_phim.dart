
import 'package:flutter/material.dart';

import '../models.dart';

Widget khungPhim(Phim phim, {double? w = 150, double? h = 200}){
  return Column(
    children: [
      Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                image: NetworkImage(phim.poster),
                fit: BoxFit.cover
            )
        ),
      ),
      Container(
          width: w,
          child: Text("${phim.tenPhim}", style: TextStyle(fontWeight: FontWeight.bold), softWrap: true, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,)
      )
    ],
  );
}