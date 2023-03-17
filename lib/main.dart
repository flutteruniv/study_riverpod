import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'pages/chat_page.dart';
import 'pages/sing_in_page.dart';
import 'providers/firestore_provider.dart';

Future<void> main() async {
  // main 関数でも async が使えます
  WidgetsFlutterBinding.ensureInitialized(); // runApp 前に何かを実行したいときはこれが必要です。
  await Firebase.initializeApp(
    // これが Firebase の初期化処理です。
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ///Riverpodを使うために必要
      ProviderScope(
        overrides: [
          ///これだけでFirebaseFirestoreモックを注入できる。
          firestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
        ],
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // currentUser が null であればログインしていない
    if (FirebaseAuth.instance.currentUser == null) {
      // 未ログイン
      return MaterialApp(
        theme: ThemeData(),
        home: const SignInPage(),
      );
    } else {
      // ログイン中
      return MaterialApp(
        theme: ThemeData(),
        home: const ChatPage(),
      );
    }
  }
}
