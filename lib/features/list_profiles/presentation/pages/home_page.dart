import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/core/common/theme/app_theme.dart';

import '../../../../core/common/widgets/alert.dart';
import '../../domain/entities/profile.dart';
import '../bloc/list_profiles_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/expandable_view.dart';
import '../widgets/home_page_shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<ListProfilesBloc>().add(ListProfileInitiated());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              // TODO: The Asset Image of wizard with the staff. Need to replace it with a Ninja Picture if possible
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                child: Image.asset(
                  'assets/home-image.png',
                  height: size.height * 0.4,
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Ninja Suggestions'),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // TODO: Filter text field. It doesn't work now. Need to set state and make the filter dynamic.
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Filter',
                    labelStyle: AppTheme.body100,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: AppTheme.saropa200),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<ListProfilesBloc, ListProfilesState>(
                listener: (context, state) {
                  if (state is ListProfilesFailure) {
                    showErrorPopup(context, state.message, 'BACK');
                  }
                },
                builder: (context, state) {
                  if (state is ListProfilesSuccess) {
                    List<Profile> profiles = state.profiles
                        .where((profile) => profile.affiliations.length > 1)
                        .toList();
                    List<String> villages = [
                      'Kirigakure',
                      'Akatsuki',
                      'Konohagakure',
                      'Otogakure',
                      'Iwagakure',
                      'Kumogakure',
                      'Uzushiogakure',
                      'Sunagakure',
                      'Yugakure'
                    ];
                    Map<String, List<Profile>> villageNinjas = {};
                    for (String village in villages) {
                      villageNinjas[village] = profiles
                          .where((element) =>
                              element.affiliations.contains(village))
                          .toList();
                    }
                    // Expandable view with list of Ninjas in a village.
                    // TODO: Not a correct implementation for now. Later need to use villages api to get all the vilages and list Ninjas per village.
                    return Column(
                      children: [
                        for (String key in villageNinjas.keys)
                          ExpandableView(
                              size: size,
                              profiles: villageNinjas[key]!,
                              title: key),
                      ],
                    );
                  } else {
                    return HomePageShimmer(size: size);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
