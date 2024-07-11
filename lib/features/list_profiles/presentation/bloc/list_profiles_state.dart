part of 'list_profiles_bloc.dart';

sealed class ListProfilesState {}

class ListProfilesInitial extends ListProfilesState {}

class ListProfilesFailure extends ListProfilesState {
  final String message;

  ListProfilesFailure({required this.message});
}

class ListProfilesSuccess extends ListProfilesState {
  final List<Profile> profiles;

  ListProfilesSuccess({required this.profiles});
}
