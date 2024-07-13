part of 'list_profiles_bloc.dart';

sealed class ListProfilesEvent {}

final class ListProfileInitiated extends ListProfilesEvent {}

final class AddProfileEvent extends ListProfilesEvent {
  final Profile profile;
  final List<Profile> profiles;

  AddProfileEvent({required this.profile, required this.profiles});
}
