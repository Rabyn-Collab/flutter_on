import 'package:flutter/material.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/providers/movie_provider.dart';
import 'package:flutter_new_project/widgets/tab_bar_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class HomeScreen extends StatelessWidget {

final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child:  Consumer(
        builder: (context, ref, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple,
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 50),
                  child: TabBar(
                      onTap: (index) {
                        switch(index){
                          case 0:
                            ref.read(movieProvider.notifier).updateApi(Api.getPopularMovie);
                            break;
                          case 1:
                            ref.read(movieProvider.notifier).updateApi(Api.getTopRatedMovie);
                            break;
                          default:
                            ref.read(movieProvider.notifier).updateApi(Api.getUpcomingMovie);
                        }
                      },
                      tabs: [
                        Tab(
                          text: 'Popular Movies',
                        ),
                        Tab(
                          text: 'Top_Rated Movies',
                        ),
                        Tab(
                          text: 'UpComing Movies',
                        ),
                      ]

                  ),
                ),
              ),
              body: Column(
                children: [
                 Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 5),
                          child: TextFormField(
                            controller: searchController,
                            onFieldSubmitted: (val) {
                              searchController.clear();
                              ref.read(movieProvider.notifier).searchMovie(val);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintText: 'search for movies',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)
                                )
                            ),
                          ),
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          TabBarWidget(),
                          TabBarWidget(),
                          TabBarWidget(),
                        ]
                    ),
                  ),
                ],
              )
          );
        }
      ),
    );
  }
}