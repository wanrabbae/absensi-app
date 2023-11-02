import 'package:app/components/component_custom.dart';
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
                      'assets/icons/illustration-stop-working.webp',
                      width: 255,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Anda dapat menggunakan Hora kembali\n'
                      'dengan undangan Admin perusahaan.\n'
                      'Terima kasih.',
                      style: TextStyle(
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
        child: buttonBlue('Oke', onTap: () => Navigator.pop(context)),
      ),
    );
  }
}
