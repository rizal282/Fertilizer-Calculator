import 'package:flutter/material.dart';

Future<bool> onWillPop(BuildContext context) async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text(
            'Apakah Anda yakin ingin kembali? Data tidak akan tersimpan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // batal
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true), // konfirmasi
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Kembali', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
    return shouldPop ?? false;
  }