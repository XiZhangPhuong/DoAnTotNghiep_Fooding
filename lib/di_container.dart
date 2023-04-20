import 'package:fooding_project/repository/auth_repository.dart';
import 'package:fooding_project/repository/category_repository.dart';
import 'package:fooding_project/repository/products_repository.dart';
import 'package:fooding_project/repository/user_repository.dart';
import 'package:fooding_project/sharedpref/shared_preference_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/izi_size.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(sharedPreferences));
  sl.registerSingleton<IZISize>(IZISize());

  // Auth Repository.
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // User Repository.
  sl.registerLazySingleton<UserRepository>(() => UserRepository());

  // Category Repository
   sl.registerLazySingleton<CategoryRepository>(() => CategoryRepository());

   // Product Repository
   sl.registerLazySingleton<ProductsRepository>(() => ProductsRepository());
}
