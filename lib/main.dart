import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:naruto/core/common/network/connection_checker.dart';
import 'package:naruto/features/list_profiles/data/datasources/profile_list_remote_datasource.dart';
import 'package:naruto/features/list_profiles/data/repositories/profile_list_repo_impl.dart';
import 'package:naruto/features/list_profiles/domain/usecases/profile_list_usecase.dart';
import 'package:naruto/features/list_profiles/presentation/bloc/list_profiles_bloc.dart';
import 'features/list_profiles/presentation/pages/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => ListProfilesBloc(
              profileListUseCase: ProfileListUseCase(
                  profileListRepo: ProfileListRepoImpl(
                      profileRemoteDataSource: ProfileRemoteDataSourceImpl(),
                      connectionChecker:
                          ConnectionCheckerImpl(InternetConnection())))))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naruto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Naruto'),
    );
  }
}
