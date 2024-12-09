import 'package:injectable/injectable.dart';
import 'package:tierlist/data/database/db_helper.dart';
import 'package:tierlist/data/models/tier_list.dart';
import 'package:tierlist/data/sources/popular_tier_lists.dart';

@module
abstract class AppModule {
  @lazySingleton
  List<TierList> get popularTierLists => PopularTierLists.popularTierLists;
  @preResolve
  Future<DBHelper> provideDBHelper() => DBHelper.init();
}
