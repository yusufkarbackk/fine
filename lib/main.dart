import 'package:fine/providers/fine_user_provider.dart';
import 'package:fine/screens/screens.dart';
import 'package:fine/services/Services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.firebaseUserStream,
        child: MultiProvider(
          providers: [
            Provider<FineUserProvider>(create: (context) => FineUserProvider())
          ],
          builder: (context, widget) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
            );
          },
        ));
  }
}
