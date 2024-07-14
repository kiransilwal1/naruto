import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/core/common/usecase/usecase.dart';
import 'package:naruto/features/contacts/domain/usecases/contact_load_use_case.dart';
import 'package:naruto/features/contacts/domain/usecases/contacts_by_id_usecase.dart';

import '../../../list_profiles/domain/entities/profile.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final ContactLoadUseCase _contactLoadUseCase;
  final ContactsByIdUseCase _contactsByIdUseCase;
  ContactsBloc({
    required ContactLoadUseCase contactLoadUseCase,
    required ContactsByIdUseCase contactsByIdUseCase,
  })  : _contactLoadUseCase = contactLoadUseCase,
        _contactsByIdUseCase = contactsByIdUseCase,
        super(ContactsInitial()) {
    on<ContactsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ContactLoad>(getContacts);
    on<ContactDetails>(getContactDetails);
  }

  FutureOr<void> getContacts(
      ContactLoad event, Emitter<ContactsState> emit) async {
    final res = await _contactLoadUseCase(NoParams());
    res.fold((l) => emit(ContactsFailure(message: l.message)),
        (r) => emit(ContactsSuccess(profiles: r)));
  }

  FutureOr<void> getContactDetails(
      ContactDetails event, Emitter<ContactsState> emit) async {
    final res = await _contactsByIdUseCase(event.id);
    res.fold((l) => emit(ContactsFailure(message: l.message)),
        (r) => emit(ContactsByIdSuccess(profile: r)));
  }
}
