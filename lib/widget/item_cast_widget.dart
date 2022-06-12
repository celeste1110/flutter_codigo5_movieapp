
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/models/cast_model.dart';

class ItemCastWidget extends StatelessWidget {
  CastModel castModel;
  ItemCastWidget({required this.castModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
             castModel.profilePath!='' ?'http://image.tmdb.org/t/p/w500${castModel.profilePath}':'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            castModel.originalName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            castModel.character,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
