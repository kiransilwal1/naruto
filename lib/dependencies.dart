import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:naruto/core/common/network/connection_checker.dart';
import 'package:naruto/features/contacts/data/datasources/contacts_local_datasource.dart';
import 'package:naruto/features/contacts/data/repositories/contact_load_repo_impl.dart';
import 'package:naruto/features/contacts/domain/usecases/contact_load_use_case.dart';
import 'package:naruto/features/contacts/domain/usecases/contacts_by_id_usecase.dart';
import 'package:naruto/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:naruto/features/list_profiles/data/datasources/profile_list_local_datasource.dart';
import 'package:naruto/features/list_profiles/data/datasources/profile_list_remote_datasource.dart';
import 'package:naruto/features/list_profiles/data/repositories/profile_list_repo_impl.dart';
import 'package:naruto/features/list_profiles/domain/usecases/add_profile_usecase.dart';
import 'package:naruto/features/list_profiles/domain/usecases/profile_list_usecase.dart';
import 'package:naruto/features/list_profiles/presentation/bloc/list_profiles_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.clear();
    return sharedPreferences;
  });

  getIt.registerFactory<ProfileListRepoImpl>(
    () => ProfileListRepoImpl(
        profileRemoteDataSource: ProfileRemoteDataSourceImpl(),
        connectionChecker: ConnectionCheckerImpl(
          InternetConnection(),
        ),
        profileLocalDatasource: ProfileLocalDatasourceImpl(
            sharedPreferences: getIt<SharedPreferences>())),
  );

  getIt.registerFactory<ProfileListUseCase>(
    () => ProfileListUseCase(
      profileListRepo: getIt<ProfileListRepoImpl>(),
    ),
  );

  getIt.registerFactory<ProfileAddUseCase>(
    () => ProfileAddUseCase(
      profileListRepo: getIt<ProfileListRepoImpl>(),
    ),
  );

  getIt.registerFactory<ContactsByIdUseCase>(
      () => ContactsByIdUseCase(contactLoadRepo: getIt<ContactLoadRepoImpl>()));

  getIt.registerFactory<ListProfilesBloc>(
    () => ListProfilesBloc(
      profileListUseCase: getIt<ProfileListUseCase>(),
      profileAddUseCase: getIt<ProfileAddUseCase>(),
    ),
  );

  getIt.registerFactory<ContactLoadUseCase>(
      () => ContactLoadUseCase(contactLoadRepo: getIt<ContactLoadRepoImpl>()));

  getIt.registerFactory<ContactLoadRepoImpl>(
    () => ContactLoadRepoImpl(
      contactsLocalDatasource: ContactsLocalDataSourceImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
      connectionChecker: ConnectionCheckerImpl(
        InternetConnection(),
      ),
    ),
  );

  getIt.registerFactory<ContactsBloc>(
    () => ContactsBloc(
      contactLoadUseCase: ContactLoadUseCase(
        contactLoadRepo: ContactLoadRepoImpl(
          contactsLocalDatasource: ContactsLocalDataSourceImpl(
            sharedPreferences: getIt<SharedPreferences>(),
          ),
          connectionChecker: ConnectionCheckerImpl(
            InternetConnection(),
          ),
        ),
      ),
      contactsByIdUseCase: getIt<ContactsByIdUseCase>(),
    ),
  );
}
