import 'package:dio/dio.dart';

import '../../../core/exceptions/repository_exception.dart';
import '../../../core/fp/fp.dart';
import '../../../core/rest_client/rest_client.dart';
import '../../models/barbershop_model.dart';
import '../../models/user_model.dart';
import 'i_barbershop_repository.dart';

class BarbershopRepository implements IBarbershopRepository {
  final RestClient _restClient;

  BarbershopRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel user) async {
    switch (user) {
      case UserAdmModel():
        final Response(data: List(first: data)) = await _restClient.authRequest.get(
          '/barbershop',
          queryParameters: {
            'user_id': '#userAuthRef',
          },
        );

        return Success(BarbershopModel.fromMap(data));

      case UserEmployeeModel():
        final Response(:data) =
            await _restClient.authRequest.get('/barbershop/${user.barbershopId}');

        return Success(BarbershopModel.fromMap(data));
    }
  }
}
