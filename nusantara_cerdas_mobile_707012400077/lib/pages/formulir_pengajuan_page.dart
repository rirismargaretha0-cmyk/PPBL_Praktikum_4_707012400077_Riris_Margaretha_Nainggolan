import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/form_pengajuan.dart';

class FormulirPengajuanPage extends StatelessWidget {
  const FormulirPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengajuan Baru')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.line),
              ),
              child: const Padding(
                padding: EdgeInsets.all(22),
                child: FormPengajuan(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
