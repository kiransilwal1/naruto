import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/usecase/usecase.dart';
import 'package:naruto/features/contacts/domain/repositories/contact_load_repo.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';

class ContactLoadUseCase implements UseCase<List<Profile>, void> {
  final ContactLoadRepo contactLoadRepo;

  ContactLoadUseCase({required this.contactLoadRepo});
  @override
  Future<Either<Failure, List<Profile>>> call(void params) async {
    final result = await contactLoadRepo.getContacts();
    return result;
  }
}
