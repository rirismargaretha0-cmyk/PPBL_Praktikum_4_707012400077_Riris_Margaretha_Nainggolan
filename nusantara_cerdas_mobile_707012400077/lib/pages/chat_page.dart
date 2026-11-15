import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _pesanController = TextEditingController();

  final List<Map<String, dynamic>> _pesan = [
    {
      'teks':
          'Halo! Selamat datang di Nusantara Cerdas. Ada yang bisa dibantu?',
      'dariSaya': false,
    },
  ];

  void _kirimPesan() {
    final teks = _pesanController.text.trim();

    if (teks.isEmpty) return;

    setState(() {
      _pesan.add({'teks': teks, 'dariSaya': true});
      _pesanController.clear();
    });
  }

  @override
  void dispose() {
    _pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 880),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFE5F3F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                children: [
                  Icon(Icons.support_agent, color: AppColors.teal),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Simulasi layanan chat. Pesan tersimpan sementara.',
                      style: TextStyle(color: AppColors.ink, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(16),
                itemCount: _pesan.length,
                itemBuilder: (context, index) {
                  final data = _pesan[_pesan.length - 1 - index];

                  final dariSaya = data['dariSaya'] == true;

                  return Align(
                    alignment: dariSaya
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 330),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: dariSaya ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        border: dariSaya
                            ? null
                            : Border.all(color: AppColors.line),
                      ),
                      child: Text(
                        data['teks'] as String,
                        style: TextStyle(
                          color: dariSaya ? Colors.white : AppColors.ink,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _pesanController,
                        onSubmitted: (_) => _kirimPesan(),
                        decoration: const InputDecoration(
                          hintText: 'Tulis pesan untuk petugas...',
                          prefixIcon: Icon(Icons.chat_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _kirimPesan,
                      icon: const Icon(Icons.send_rounded),
                      tooltip: 'Kirim Pesan',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
