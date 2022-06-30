import 'package:core/data/models/umkm_model.dart';
import 'package:flutter/material.dart';

class DetailUmkmPage extends StatelessWidget {
  static const routeName = "/detailUmkmPage";
  final Umkm umkm;
  const DetailUmkmPage({Key? key, required this.umkm}) : super(key: key);
  static Route route({required Umkm umkm}) {
    return MaterialPageRoute(
      // ignore: prefer_const_constructors
      settings: RouteSettings(name: routeName),
      // ignore: prefer_const_constructors
      builder: (_) => DetailUmkmPage(
        umkm: umkm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [],
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black38,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.lightBlue,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                umkm.imgUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(umkm.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 10,
                    ),
                    IconName(
                      text: umkm.category,
                      icon: Icons.local_cafe,
                    ),
                    IconName(
                      text: umkm.address,
                      icon: Icons.pin_drop_outlined,
                    ),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.maxFinite,
                    child: Text(
                      umkm.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class IconName extends StatelessWidget {
  final String text;
  final IconData? icon;
  const IconName({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 22,
          color: Colors.lightBlue,
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 290,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
