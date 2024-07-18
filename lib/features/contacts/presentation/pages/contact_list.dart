import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/core/common/theme/app_theme.dart';
import 'package:naruto/core/common/widgets/alert.dart';
import 'package:naruto/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:naruto/features/contacts/presentation/widgets/custom_search_bar.dart';
import '../widgets/contact_attributes.dart';
import '../widgets/topbar_contact.dart';

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
                // TODO: Need to implement the search bar
                CustomSearchBar(filters: filters),
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
                                  if (state is ContactsFailure) {
                                    showErrorPopup(
                                        context, 'Something went wrong!', 'Ok');
                                  }
                                },
                                builder: (context, state) {
                                  if (state is ContactsByIdSuccess) {
                                    List<String> releases =
                                        state.profile.natureType ?? [];
                                    List<String> affiliations =
                                        state.profile.affiliations;
                                    List<String> classifications =
                                        state.profile.classification ?? [];
                                    List<Map<String, String>> listOfMaps = [];
                                    // If the state is success, prepare data that needs ot be siplayed in the pop up.
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
                                      offset: const Offset(0, 3),
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
                                      offset: const Offset(0, 3),
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
          return Scaffold(
              body: Center(
                  child: Column(
            children: [
              CustomSearchBar(
                filters: filters,
              ),
            ],
          )));
        }
      },
    );
  }
}
