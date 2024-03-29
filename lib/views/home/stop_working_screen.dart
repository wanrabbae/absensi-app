import 'package:app/components/component_custom.dart';
import 'package:app/controllers/splash_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StopWorkingScreen extends StatelessWidget {
  const StopWorkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SafeArea(
              minimum: EdgeInsets.only(top: 96),
              child: Text(
                'Oops...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'images/illustration-invitation.gif',
                      width: 255,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      tr('stop_working_description'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: buttonBlue(
          tr('profile_logout'),
          onTap: () => SplashController().removeData(),
        ),
      ),
    );
  }
}
