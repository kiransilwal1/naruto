import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naruto/core/common/theme/app_theme.dart';
import 'package:naruto/core/common/widgets/alert.dart';
import 'package:naruto/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    context.read<ContactsBloc>().add(ContactLoad());
    super.initState();
  }

  final List filters = [
    {
      'icon': const Icon(
        Icons.phone,
        color: AppTheme.neutral400,
      ),
      'text': 'Phone'
    },
    {
      'icon': const Icon(
        Icons.email,
        color: AppTheme.neutral400,
      ),
      'text': 'Email'
    },
    {
      'icon': const Icon(
        Icons.map,
        color: AppTheme.neutral400,
      ),
      'text': 'Address'
    },
    {
      'icon': const Icon(
        Icons.window,
        color: AppTheme.neutral400,
      ),
      'text': 'Website'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsBloc, ContactsState>(
      listener: (context, state) {
        if (state is ContactsFailure) {
          showErrorPopup(context, state.message, 'Ok');
        }
      },
      builder: (context, state) {
        if (state is ContactsSuccess) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            body: Column(
              children: [
                Material(
                  elevation: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.saropa900,
                      gradient: LinearGradient(
                        colors: [AppTheme.saropa900, AppTheme.saropa500],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        CircleAvatar(
                                            radius: 20,
                                            backgroundColor: AppTheme.saropa100,
                                            backgroundImage: const NetworkImage(
                                              'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                                            ),
                                            onBackgroundImageError: (_, __) {}),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Icon(
                                          Icons.search_rounded,
                                          color: AppTheme.neutral400,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                focusColor: Colors.white,
                                                border: InputBorder.none,
                                                labelText: 'Search',
                                                labelStyle: AppTheme.body300
                                                    .copyWith(
                                                        color: AppTheme
                                                            .neutral400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: Icon(
                                      Icons.history,
                                      color: AppTheme.neutral400,
                                      size: 30,
                                      weight: 2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (Map items in filters)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 0),
                                      child: Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: AppTheme.neutral400,
                                              style: BorderStyle.solid,
                                              width: 2.0),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: FilterCards(
                                          icon: items['icon'],
                                          text: items['text'],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.profiles.length,
                    itemBuilder: (context, index) {
                      final contact = state.profiles[index];
                      return ListTile(
                        onTap: () {
                          context.read<ContactsBloc>().add(ContactDetails(
                              id: state.profiles[index].id.toString()));
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return BlocConsumer<ContactsBloc, ContactsState>(
                                listener: (context, state) {
                                  showErrorPopup(
                                      context, 'Something went wrong!', 'Ok');
                                },
                                builder: (context, state) {
                                  if (state is ContactsByIdSuccess) {
                                    List<String> releases =
                                        state.profile.natureType ?? [];
                                    List<String> affiliations =
                                        state.profile.affiliations ?? [];
                                    List<String> classifications =
                                        state.profile.classification ?? [];
                                    List<Map<String, String>> listOfMaps = [];

                                    for (var release in releases) {
                                      listOfMaps.add({
                                        "type": "Release",
                                        "value": release
                                      });
                                    }

                                    for (var affiliation in affiliations) {
                                      listOfMaps.add({
                                        "type": "Affiliations",
                                        "value": affiliation
                                      });
                                    }

                                    for (var classification
                                        in classifications) {
                                      listOfMaps.add({
                                        "type": "Class",
                                        "value": classification
                                      });
                                    }

                                    print(state.profile);
                                    return Center(
                                      child: Container(
                                        height: size.height * 0.9,
                                        width: size.width * 0.8,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TopBar(profile: state.profile),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 16, 16, 0),
                                              child: SizedBox(
                                                height: 400,
                                                child: GridView.builder(
                                                  itemCount: listOfMaps.length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount:
                                                              size.width ~/ 150,
                                                          mainAxisExtent: 140,
                                                          crossAxisSpacing: 30,
                                                          mainAxisSpacing: 30),
                                                  itemBuilder: (_, index) {
                                                    return GestureDetector(
                                                        onTap: () {},
                                                        child: Material(
                                                          elevation: 8,
                                                          child: Container(
                                                              height: 120,
                                                              width: 100,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            16)),
                                                              ),
                                                              child:
                                                                  ContactAttributeCards(
                                                                title: listOfMaps[
                                                                        index]
                                                                    ['type']!,
                                                                value: listOfMaps[
                                                                        index]
                                                                    ['value']!,
                                                              )),
                                                        ));
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const Scaffold(
                                      body: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        leading: SizedBox(
                          width: size.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppTheme.saropa500,
                                    child: Text(
                                      state.profiles[index].name[0].toString(),
                                      style: AppTheme.body300
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppTheme.saropa100,
                                      foregroundImage: NetworkImage(
                                        state.profiles[index].imageUrl ??
                                            'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                                      ),
                                      backgroundImage: const NetworkImage(
                                        'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                                      ),
                                      onBackgroundImageError: (_, __) {}),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          contact.name,
                          style: AppTheme.body300,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ContactAttributeCards extends StatelessWidget {
  const ContactAttributeCards({
    required this.title,
    required this.value,
    super.key,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.receipt),
        Text(
          title,
          style: AppTheme.headline300,
        ),
        Text(
          value,
          style: AppTheme.body100,
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
          ),
          gradient: LinearGradient(
              colors: [AppTheme.saropa900, AppTheme.saropa500],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 4, 8),
        child: Column(
          children: [
            const TopIconRows(),
            CircleAvatar(
                radius: 60,
                backgroundColor: AppTheme.saropa100,
                foregroundImage: NetworkImage(
                  profile.imageUrl ??
                      'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                ),
                backgroundImage: const NetworkImage(
                  'https://publicdomainvectors.org/tn_img/fb_stormshadow.webp',
                ),
                onBackgroundImageError: (_, __) {}),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                text: TextSpan(
                  style: AppTheme.headline300.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: profile.name,
                      style: AppTheme.headline500
                          .copyWith(height: 1.2, color: Colors.white),
                    ),
                    profile.age != null
                        ? TextSpan(
                            text: '\n${profile.age} Yrs Old',
                            style: AppTheme.body200.copyWith(
                                height: 1.5, color: AppTheme.neutral300),
                          )
                        : TextSpan(
                            text: '',
                            style: AppTheme.body200,
                          ),
                    profile.affiliations.isNotEmpty
                        ? TextSpan(
                            text: '\n${profile.affiliations.join(' ')}',
                            style: AppTheme.body200.copyWith(
                                height: 1.5, color: AppTheme.neutral300),
                          )
                        : TextSpan(
                            text: '',
                            style: AppTheme.body200.copyWith(
                                height: 1.5, color: AppTheme.neutral300),
                          ),
                    TextSpan(
                      text: '\n${profile.occupations}',
                      style: AppTheme.body200
                          .copyWith(height: 1.5, color: AppTheme.neutral300),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopIconRows extends StatelessWidget {
  const TopIconRows({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            context.read<ContactsBloc>().add(ContactLoad());
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.flag,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}

class FilterCards extends StatelessWidget {
  const FilterCards({
    super.key,
    required this.icon,
    required this.text,
  });
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        icon,
        Text(
          text,
          style: AppTheme.body300.copyWith(color: AppTheme.neutral400),
        )
      ]),
    );
  }
}
