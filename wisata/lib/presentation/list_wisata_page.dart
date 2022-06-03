import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/utils/database_services.dart';
import 'package:flutter/material.dart';

class ListWisataPage extends StatelessWidget {
  static const routeName = '/listWisata';
  const ListWisataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wisata Favoritmu"),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: FutureBuilder<QuerySnapshot>(
          future: DatabaseServices().firestoreRef.collection('wisata').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.length > 0) {
              List<DocumentSnapshot> arrData = snapshot.data!.docs;
              print(arrData.length);
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: arrData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(
                                      3.0,
                                      3.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                ]),
                          ),
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Image.network(
                                      arrData[index]['imgUrl'],
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      fit: BoxFit.fitHeight,
                                      scale: 1.0,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, bottom: 10, top: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        arrData[index]['name'],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        arrData[index]['provincy'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ));
                },
              );
            } else {
              return const Center(
                child: Text('Data not found'),
              );
            }
          },
        ),
      ),
    );
  }
}
