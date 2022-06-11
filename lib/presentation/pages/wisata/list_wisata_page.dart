import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';
import 'package:pesona_indonesiaku_app/presentation/bloc/wisata/wisata_bloc.dart';
import 'package:pesona_indonesiaku_app/widgets/wisata_list.dart';

class ListWisataPage extends StatelessWidget {
  static const routeName = '/listWisata';
  const ListWisataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.lightBlue,
          elevation: 0,
          title: Text("Wisata Favoritmu"),
        ),
        body: Container(
            margin: EdgeInsets.all(15),
            child:
                BlocBuilder<WisataBloc, WisataState>(builder: (context, state) {
              if (state is WisataLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WisataLoaded) {
                return WisataList(wisata: state.wisata.toList());
              } else {
                return Text("Something went wrong");
              }
            })));
  }
}

class HeroCarousCard extends StatelessWidget {
  final Wisata wisata;

  const HeroCarousCard({Key? key, required this.wisata}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(
              wisata.imgUrl,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  wisata.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
