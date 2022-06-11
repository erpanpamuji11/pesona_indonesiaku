import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';
import 'package:pesona_indonesiaku_app/data/repository/wisata_repository.dart';
import 'package:pesona_indonesiaku_app/presentation/bloc/wisata/wisata_bloc.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/ParentPage.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/bridge_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/favorite/favorite_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/home_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/login/pages/login_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/login/pages/signup_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/search/search_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/splash_screen.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/umkm/input_umkm.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/wisata/detail_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/wisata/input_wisata_page.dart';
import 'package:pesona_indonesiaku_app/presentation/pages/wisata/list_wisata_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => WisataBloc(wisataRepository: WisataRepository())
                ..add(LoadWisata()))
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: "Pesona Indonesiaku",
          home: const SplashScreen(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case ParentPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const ParentPage());
              case HomePage.routeName:
                return MaterialPageRoute(builder: (_) => const HomePage());
              case ListWisataPage.routeName:
                return MaterialPageRoute(
                    builder: (_) => const ListWisataPage());
              case DetailPage.routeName:
                return DetailPage.route(wisata: settings.arguments as Wisata);
              case LoginPage.routeName:
                return MaterialPageRoute(builder: (_) => const LoginPage());
              case BridgePage.routeName:
                return MaterialPageRoute(builder: (_) => const BridgePage());
              case SignUpPage.routeName:
                return MaterialPageRoute(builder: (_) => const SignUpPage());
              case SearchPage.routeName:
                return MaterialPageRoute(builder: (_) => SearchPage());
              case FavoriteApp.routeName:
                return MaterialPageRoute(builder: (_) => FavoriteApp());
              case InputWisataPage.routeName:
                return MaterialPageRoute(builder: (_) => InputWisataPage());
              case InputUmkmPage.routeName:
                return MaterialPageRoute(builder: (_) => InputUmkmPage());
            }
            return null;
          },
        ));
  }
}
