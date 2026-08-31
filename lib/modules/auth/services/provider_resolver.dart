import 'package:firebase_auth/firebase_auth.dart';

import '../repositories/provider_apple_repository.dart';
import '../repositories/provider_google_repository.dart';
import '../repositories/provider_repository.dart';

// Resolves which sign-in provider the current Firebase user authenticated with.
ProviderRepository getProviderRepository() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.providerData.isNotEmpty) {
    final providerId = user.providerData.first.providerId;
    if (providerId == 'google.com') {
      return ProviderGoogleRepository();
    } else if (providerId == 'apple.com') {
      return ProviderAppleRepository();
    }
  }
  // fallback
  return ProviderGoogleRepository();
}
