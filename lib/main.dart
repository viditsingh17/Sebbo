/*import 'package:flutter/material.dart';
import 'package:sebbo/screens/home_screen.dart';
import 'package:sebbo/screens/product_view_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductView(),
    );
  }
}*/
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sebbo/services/auth.dart';
import 'package:sebbo/services/auth_widget.dart';
import 'package:sebbo/services/auth_widget_builder.dart';
import 'package:sebbo/widgets/splashScreen.dart';
import 'helper/customRouteTransition.dart';
import 'login/loginScreen.dart';

var feed = [];
var a = {};
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(
          create: (_) => Data(),
        ),
        Provider<AuthBase>(
          create: (context) => Auth(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

String isLogin =
    ' '; // ' ' it is necessary so that error will not occur because of null value
bool splashScreen = true;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*final postRef = FirebaseFirestore.instance.collection('post');
  getPost() async {
    QuerySnapshot snapshot = await postRef.get();
    List<PostCard> posts = Conversion().mapToPostCard(snapshot.docs);
//    snapshot.documents.map((doc) => PostCard.fromDocument(doc)).toList();
    setState(() {
      feed = posts;
    });
  }
  @override
  void initState() {
    getPost();
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage(
          "assets/images/logo.png",
        ),
        context);
    precacheImage(
        AssetImage(
          "assets/images/bg_book_plant.jpg",
        ),
        context);
    precacheImage(
        AssetImage(
          "assets/images/bg_diary.png",
        ),
        context);
    return AuthWidgetBuilder(builder: (context, userSnapshot) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sebbo',
        theme: ThemeData(
          primaryColor: Color(0xFFE3F2FD),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionsBuilder(),
              TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            },
          ),
        ),
//      home: SplashScreen.navigate(
//        name: 'assets/splash.flr',
//        next: (context) {
//          return AuthService().handleAuth();
//        },
//        startAnimation: 'Untitled',
//        until: () => Future.delayed(Duration(seconds: 4)),
//        backgroundColor: Colors.white,
//      ),

        /*This is the routes table. Add all the route names used inside the app here
      Add the route name where the route is made as static const String, so as to you don't need to remember anything.
       */
        routes: {
          //the route name / stands for home / first route in the app.
          '/': (ctx) => splashScreen
              ? CustomSplashScreen()
              : AuthWidget(
                  userSnapshot: userSnapshot,
                ),
          LoginScreen.loginRoute: (ctx) => LoginScreen()
        },
      );
    });
  }
}

class Data extends ChangeNotifier {
  List<String> myRealData = [];
  void changeMyData(List<String> value) {
    myRealData = value;
    notifyListeners();
  }
}
