import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/core/services/public_auth.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_bloc.dart';
import 'package:template_app_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildAppBlocProviders() {
  return [
    BlocProvider(
      create: (context) =>
          AuthBloc(AuthRepository(publicAuth: PublicAuth(context: context))),
    ),
  ];
}
