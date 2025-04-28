import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hug_app/meal/data/dummy_data.dart';

import '../data/dummy_items.dart';

final groceryProvider = Provider((ref) {
  return groceryItems;
},);