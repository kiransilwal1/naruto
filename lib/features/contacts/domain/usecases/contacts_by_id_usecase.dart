import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/usecase/usecase.dart';
import 'package:naruto/features/contacts/domain/repositories/contact_load_repo.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';

class ContactsByIdUseCase implements UseCase<Profile, String> {
  final ContactLoadRepo contactLoadRepo;

  ContactsByIdUseCase({required this.contactLoadRepo});
  @override
  Future<Either<Failure, Profile>> call(String params) async {
    final result = await contactLoadRepo.getContactsById(params);
    return result;
  }
}
