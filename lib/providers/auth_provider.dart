import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider((ref) {
  return FirebaseAuth.instance;
});

final userProvider = StreamProvider((ref) {
  final firebaseAuth = ref.read(authProvider);
  return firebaseAuth.userChanges();
});

final uidProvider = StreamProvider((ref) {
  return ref.watch(userProvider.stream).map((user) => user?.uid);
});