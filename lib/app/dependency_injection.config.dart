// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/database/db_helper.dart' as _i3;
import '../data/models/tier_list.dart' as _i4;
import '../data/tier_list_repo.dart' as _i6;
import '../presentation/providers/editor_provider.dart' as _i5;
import '../presentation/providers/tier_lists_provider.dart' as _i7;
import 'app_module.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.DBHelper>(
      () => appModule.provideDBHelper(),
      preResolve: true,
    );
    gh.lazySingleton<List<_i4.TierList>>(() => appModule.popularTierLists);
    gh.factoryParam<_i5.EditorProvider, _i4.TierList?, dynamic>((
      existingTierList,
      _,
    ) =>
        _i5.EditorProvider(existingTierList));
    gh.singleton<_i6.TierListRepository>(() => _i6.TierListRepository(
          gh<_i3.DBHelper>(),
          gh<List<_i4.TierList>>(),
        ));
    gh.singleton<_i7.TierListsProvider>(
        () => _i7.TierListsProvider(gh<_i6.TierListRepository>()));
    return this;
  }
}

class _$AppModule extends _i8.AppModule {}
