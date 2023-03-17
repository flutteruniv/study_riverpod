import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../references.dart';

final postsProvider = StreamProvider((_) {
  return postsReferenceWithConverter.orderBy('createdAt').snapshots();
});