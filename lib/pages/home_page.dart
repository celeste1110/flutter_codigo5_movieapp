import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/models/movie_model.dart';
import 'package:http/http.dart' as http;

import '../models/genre_model.dart';
import '../services/api_services.dart';
import '../ui/general/colors.dart';
import '../widget/item_filter_widget.dart';
import '../widget/item_movie_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];
  List<MovieModel> movieList = [];
  List<MovieModel> moviesListAux = [];
  List<GenreModel> genresList = [];
  APIService _apiService=APIService();
  int indexFilter = 0;

  @override
  initState() {
    super.initState();
    getData();
    // getMovies();
  }
  getData() async{
    // _apiService.getMovies().then((value) {
    //   movieList=value;
    //   setState(() {
    //
    //   });
    // });
    movieList = await _apiService.getMovies();
    moviesListAux = movieList;
    genresList = await _apiService.getGenres();
    genresList.insert(0, GenreModel(id: 0, name: "All", selected: true));
    indexFilter = genresList[0].id;
    setState(() {});

  }
  filterMovie(){
    movieList = moviesListAux;
    if(indexFilter != 0){
      movieList = movieList.where((element) => element.genreIds.contains(indexFilter)).toList();
    }
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Welcome, Luis',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xff23dec3),
                        shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff5de09c),
                              Color(0xff23dec3),
                            ],
                          ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: genresList
                        .map(
                          (e) => ItemFilterWidget(
                        textFilter: e.name,
                        isSelected: indexFilter == e.id,
                        onTap: (){
                          indexFilter = e.id;
                          print(indexFilter);
                          filterMovie();
                        },
                      ),
                    )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: movieList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemMovieListWidget(
                      movieModel: movieList[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
