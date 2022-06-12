import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_movieapp/models/cast_detail_model.dart';
import 'package:flutter_codigo5_movieapp/models/cast_model.dart';
import 'package:flutter_codigo5_movieapp/models/movie_detail_model.dart';

import '../models/image_model.dart';
import '../models/review_model.dart';
import '../services/api_services.dart';
import '../ui/general/colors.dart';
import '../widget/item_cast_widget.dart';
import '../widget/item_review_widget.dart';
import '../widget/loading_indicator_widget.dart';
import '../widget/tlitle_description_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import 'cast_detail_page.dart';
import 'new_page.dart';

class MovieDetailPage extends StatefulWidget {
  int movieId;
  MovieDetailPage({required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetailModel? movieDetail;

  APIService _apiService = APIService();
  bool isLoading = true;
  List<CastModel> castList = [];
  List<ReviewModel> reviewList = [];
  List<ImageModel> images = [];
  int castId = 0;
String imagen='';
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    movieDetail = await _apiService.getMovie(widget.movieId);
    castList = await _apiService.getCast(widget.movieId);
    reviewList = await _apiService.getReview(widget.movieId);
    images = await _apiService.getImages(widget.movieId);
    isLoading = false;
    // print(castDetail!.id);
    setState(() {});
  }

  showDetailCast() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CastDetailPage(
          castId: castId,
        );
      },
    );
  }
  showImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: kBrandPrimaryColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),

          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imagen,
                  // "https://image.tmdb.org/t/p/w500${castDetailModel!.profilePath}",
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: isLoading
          ? const LoadingIndicatorWidget()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    movieDetail!.originalTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  centerTitle: true,
                  expandedHeight: 240,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    // title: Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 50),
                    //   child: Text(
                    //     'Diego',
                    //     maxLines: 1,
                    //     style: TextStyle(
                    //       fontSize: 13,
                    //     ),
                    //   ),
                    // ),
                    //titlePadding: const EdgeInsets.symmetric(horizontal: 50),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'http://image.tmdb.org/t/p/w500${movieDetail!.backdropPath}',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kBrandPrimaryColor.withOpacity(1),
                                kBrandPrimaryColor.withOpacity(0.0),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  floating: false,
                  snap: false,
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 160,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    'http://image.tmdb.org/t/p/w500${movieDetail!.posterPath}',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.white54,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        movieDetail!.releaseDate
                                            .toString()
                                            .substring(0, 10),
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    movieDetail!.originalTitle,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Colors.white54,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '${movieDetail!.runtime} min',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> NewPage()));
                        },
                        child: Text(
                          "New page",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleDescriptionWidget(
                              title: 'Overview',
                            ),
                            Text(
                              movieDetail!.overview,
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  launchUrl(
                                      Uri.parse(movieDetail!.homepage));
                                },
                                icon: Icon(
                                  Icons.link,
                                  color: kBrandPrimaryColor,
                                ),
                                label: Text(
                                  'Home page',
                                  style: TextStyle(
                                    color: kBrandPrimaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: kBrandSecondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleDescriptionWidget(
                              title: 'Genres',
                            ),
                            Wrap(
                              spacing: 8,
                              children: movieDetail!.genres
                                  .map(
                                    (e) => Chip(
                                      label: Text(e.name),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleDescriptionWidget(
                              title: 'Cast',
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: castList
                                    .map(
                                      (e) => GestureDetector(
                                        onTap: () {
                                          castId = e.id;
                                          showDetailCast();
                                        },
                                        child: ItemCastWidget(castModel: e),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TitleDescriptionWidget(
                              title: "Images",
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              padding: EdgeInsets.zero,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              children: images
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: (){
                                        imagen="https://image.tmdb.org/t/p/w500${e.filePath}";
                                        showImage();
                                      },
                                      child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${e.filePath}",
                                  fit: BoxFit.cover,
                                ),
                                    ),
                              )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TitleDescriptionWidget(
                              title: 'Reviews',
                            ),
                            const SizedBox(
                              height: 10,
                            ),


                            // ItemReviewWidget(),
                            Column(
                              children: reviewList
                                  .map(
                                    (e) => ItemReviewWidget(reviewModel: e),
                                  )
                                  .toList(),
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
