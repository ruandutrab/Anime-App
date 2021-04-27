import 'package:anime_app/app/ui/android/model/data_model.dart';
import 'package:anime_app/app/ui/android/model/firestore_search.dart';
import 'package:anime_app/app/ui/android/model/sub_bar.dart';
import 'package:flutter/material.dart';

class SearchAnime extends StatefulWidget {
  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchAnime> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return FirestoreSearchScaffold(
        appBarBottom: AppBar(
          backgroundColor: Colors.black.withOpacity(1.0),
          actions: [
            Container(
              width: MediaQuery.of(context).size.width / 1,
              child: Stack(
                children: [
                  Positioned(child: SubBar()),
                ],
              ),
            )
          ],
        ),
        scaffoldBackgroundColor: Colors.black,
        firestoreCollectionName: 'animes_list',
        searchBy: 'nome_search',
        dataListFromSnapshot: DataModel().dataListFromSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DataModel> dataList = snapshot.data;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 3.4 / 4,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20),

              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: orientation == Orientation.portrait ? 3 : 5,
              // ),
              itemCount: dataList?.length ?? 0,
              itemBuilder: (context, index) {
                final DataModel data = dataList[index];

                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              child: Image.network(
                                '${data?.img_card ?? ''}',
                                height: 150,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(2),
                              // alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                '${data?.nome ?? ''}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        scaffoldBody: Container(
          child: Column(
            children: [],
          ),
        ),
      );
    });
  }
}
