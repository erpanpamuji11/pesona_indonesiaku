import 'package:flutter/material.dart';

class BannerUmkm extends StatelessWidget {
  const BannerUmkm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pentingnya UMKM di Indonesia'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(
            children: [
              Container(
                child: Text('paragraf'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
