part of 'contacts_bloc.dart';

sealed class ContactsState {}

class ContactsInitial extends ContactsState {}

class ContactsFailure extends ContactsState {
  final String message;
  ContactsFailure({required this.message});
}

class ContactsSuccess extends ContactsState {
  final List<Profile> profiles;

  ContactsSuccess({required this.profiles});
}

class ContactsByIdSuccess extends ContactsState {
  final Profile profile;

  ContactsByIdSuccess({required this.profile});
}
