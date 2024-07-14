part of 'contacts_bloc.dart';

sealed class ContactsEvent {}

class ContactLoad extends ContactsEvent {}

class ContactDetails extends ContactsEvent {
  final String id;

  ContactDetails({required this.id});
}
