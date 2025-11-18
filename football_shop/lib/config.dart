// Edit this file to point your Flutter app to your Django backend.
// This file chooses a sensible default depending on the platform:
// - Web: uses http://localhost:8000 (assumes Django running locally)
// - Non-web (Android emulator): uses http://10.0.2.2:8000 which maps to host localhost
// If you deploy the backend, replace with your production URL.

import 'package:flutter/foundation.dart';

// For web builds we want to talk to localhost:8000. For Android emulators,
// the emulator's `localhost` is itself, so we use 10.0.2.2 to reach the host machine.
// You can override this by editing the constants here.
final String backendBase = kIsWeb ? 'http://localhost:8000' : 'http://10.0.2.2:8000';
