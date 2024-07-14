import 'package:fpdart/fpdart.dart';
import 'package:naruto/core/common/error/failures.dart';
import 'package:naruto/core/common/network/connection_checker.dart';
import 'package:naruto/features/contacts/data/datasources/contacts_local_datasource.dart';
import 'package:naruto/features/contacts/domain/repositories/contact_load_repo.dart';
import 'package:naruto/features/list_profiles/domain/entities/profile.dart';

import '../../../../core/constants/constants.dart';

class ContactLoadRepoImpl implements ContactLoadRepo {
  final ContactsLocalDatasource contactsLocalDatasource;
  final ConnectionChecker connectionChecker;

  ContactLoadRepoImpl(
      {required this.contactsLocalDatasource, required this.connectionChecker});
  @override
  Future<Either<Failure, List<Profile>>> getContacts() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final result = await contactsLocalDatasource.loadContacts();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> getContactsById(String id) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final result = await contactsLocalDatasource.getContactById(id);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
