import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Locale pour les dates en français
  await initializeDateFormatting('fr_FR', null);

  // Portrait uniquement
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    const ProviderScope(
      child: CaloTrackApp(),
    ),
  );
}
