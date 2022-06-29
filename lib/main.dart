import 'package:authentication/presentation/pages/login_page.dart';
import 'package:authentication/presentation/pages/signup_page.dart';
import 'package:authentication/presentation/pages/user_form_page.dart';
import 'package:core/data/models/umkm_model.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/data/repository/wisata_repository.dart';
import 'package:core/presentation/bloc/my_theme/bloc/theme_bloc.dart';
import 'package:core/presentation/pages/ParentPage.dart';
import 'package:core/presentation/pages/akun/settings_page.dart';
import 'package:core/presentation/pages/bridge_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/pick_wisata.dart';
import 'package:core/presentation/pages/profile_page.dart';
import 'package:core/widgets/permission_notifucation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:umkm/presentation/pages/detail_umkm_page.dart';
import 'package:umkm/presentation/pages/input_umkm.dart';
import 'package:wisata/presentation/bloc/wisata_bloc.dart';
import 'package:wisata/presentation/pages/detail_wisata_page.dart';
import 'package:wisata/presentation/pages/input_wisata_page.dart';
import 'package:wisata/presentation/pages/list_wisata_page.dart';
import 'package:wishlist/presentation/pages/wishlist_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermision();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
                ..add(LoadWisata())),
          BlocProvider(
            create: (_) => ThemeBloc(),
          )
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: "Pesona Indonesiaku",
              theme: state.themeData,
              home: const BridgePage(),
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case ParentPage.ROUTE_NAME:
                    return MaterialPageRoute(
                        builder: (_) => const ParentPage());
                  case HomePage.routeName:
                    return MaterialPageRoute(builder: (_) => const HomePage());
                  case ListWisataPage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const ListWisataPage());
                  case DetailWisataPage.routeName:
                    return DetailWisataPage.route(
                        wisata: settings.arguments as Wisata);
                  case LoginPage.routeName:
                    return MaterialPageRoute(builder: (_) => const LoginPage());
                  case BridgePage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const BridgePage());
                  case SignUpPage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const SignUpPage());
                  case SearchPage.routeName:
                    return MaterialPageRoute(builder: (_) => SearchPage());
                  case WishlistPage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const WishlistPage());
                  case InputWisataPage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const InputWisataPage());
                  case InputUmkmPage.routeName:
                    return InputUmkmPage.route(
                        wisata: settings.arguments as Wisata);
                  case ProfilePage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const ProfilePage());
                  case PickWisata.routeName:
                    return MaterialPageRoute(builder: (_) => PickWisata());
                  case DetailUmkmPage.routeName:
                    return DetailUmkmPage.route(
                        umkm: settings.arguments as Umkm);
                  case SettingsPage.routeName:
                    return MaterialPageRoute(
                        builder: (_) => const SettingsPage());
                }
                return null;
              },
            );
          },
        ));
  }
}
