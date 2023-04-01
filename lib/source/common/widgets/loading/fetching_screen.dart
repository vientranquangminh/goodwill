import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FetchingOverlay extends StatelessWidget {
  const FetchingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? appLocalizations = AppLocalizations.of(context);
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 12),
              Text(
                appLocalizations?.fetching ?? '',
              ),
            ],
          ),
        ),
      );
      }
}