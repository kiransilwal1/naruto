import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/core/common/usecase/usecase.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';
import 'package:naruto/features/list_profiles/domain/usecases/add_profile_usecase.dart';
import 'package:naruto/features/list_profiles/domain/usecases/profile_list_usecase.dart';

part 'list_profiles_event.dart';
part 'list_profiles_state.dart';

class ListProfilesBloc extends Bloc<ListProfilesEvent, ListProfilesState> {
  final ProfileListUseCase _profileListUseCase;
  final ProfileAddUseCase _profileAddUseCase;
  ListProfilesBloc(
      {required ProfileListUseCase profileListUseCase,
      required ProfileAddUseCase profileAddUseCase})
      : _profileListUseCase = profileListUseCase,
        _profileAddUseCase = profileAddUseCase,
        super(ListProfilesInitial()) {
    on<ListProfilesEvent>((event, emit) {});
    on<ListProfileInitiated>(getProfiles);
    on<AddProfileEvent>(addProfile);
  }

  FutureOr<void> getProfiles(
      ListProfileInitiated event, Emitter<ListProfilesState> emit) async {
    final res = await _profileListUseCase(NoParams());
    res.fold((l) => emit(ListProfilesFailure(message: l.message)),
        (r) => emit(ListProfilesSuccess(profiles: r)));
  }

  FutureOr<void> addProfile(
      AddProfileEvent event, Emitter<ListProfilesState> emit) async {
    final res = await _profileAddUseCase(event.profile);
    res.fold((l) => emit(ListProfilesFailure(message: l.message)),
        (r) => emit(ListProfilesSuccess(profiles: event.profiles)));
  }
}
