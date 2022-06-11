import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/wisata_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata/presentation/bloc/wisata_bloc.dart';

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
          title: const Text("Wisata Favoritmu"),
        ),
        body: Container(
            margin: const EdgeInsets.all(15),
            child: BlocBuilder<WisataBloc, WisataState>(builder: (context, state) {
              if (state is WisataLoading) {
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              } else if (state is WisataLoaded) {
                return WisataList(wisata: state.wisata.toList());
              } else {
                return const Text("Something went wrong");
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
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  wisata.name,
                  style: const TextStyle(
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
