import 'package:fpdart/fpdart.dart';

import '../../../../core/common/error/failures.dart';
import '../../../list_profiles/domain/entities/profile.dart';

abstract interface class ContactLoadRepo {
  Future<Either<Failure, List<Profile>>> getContacts();
  Future<Either<Failure, Profile>> getContactsById(String id);
}
