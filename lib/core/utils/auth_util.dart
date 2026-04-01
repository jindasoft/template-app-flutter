import 'package:template_app_flutter/core/widgets/dialogs/sign_in_required_dialog.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthUtils {
  /// Check if user is signed in, if not show signin required dialog
  /// Returns true if user is signed in, false otherwise
  static Future<bool> checkSigninStatus(BuildContext context) async {
    final authBloc = context.read<AuthBloc>();
    await authBloc.initialized;
    if (!context.mounted) {
      return false;
    }
    if (!authBloc.isSignedIn) {
      SigninRequiredDialog.show(context);
      return false;
    }
    return true;
  }
}
