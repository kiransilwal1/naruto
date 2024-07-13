import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:naruto/core/common/theme/app_theme.dart';
import 'package:naruto/features/list_profiles/presentation/bloc/list_profiles_bloc.dart';
import 'features/list_profiles/presentation/pages/home_page.dart';
import 'dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  await GetIt.instance.allReady();
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => getIt<ListProfilesBloc>())],
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
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.saropa600),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Naruto'),
    );
  }
}
