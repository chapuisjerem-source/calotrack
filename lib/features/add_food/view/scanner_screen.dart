import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/errors/failures.dart';
import '../viewmodel/scanner_viewmodel.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  late final MobileScannerController _ctrl;
  String? _lastBarcode;
  DateTime? _lastScanAt;

  @override
  void initState() {
    super.initState();
    _ctrl = MobileScannerController(
      formats: const [
        BarcodeFormat.ean13,
        BarcodeFormat.ean8,
        BarcodeFormat.upcA,
        BarcodeFormat.upcE,
      ],
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (capture.barcodes.isEmpty) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    // Débounce 2 secondes
    final now = DateTime.now();
    if (_lastBarcode == code &&
        _lastScanAt != null &&
        now.difference(_lastScanAt!) < const Duration(seconds: 2)) {
      return;
    }
    _lastBarcode = code;
    _lastScanAt = now;
    HapticFeedback.lightImpact();
    ref.read(scannerViewModelProvider.notifier).handleBarcode(code);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ScannerState>(scannerViewModelProvider, (prev, next) {
      if (next is ScannerSuccess) {
        _showSuccess(next);
      } else if (next is ScannerError) {
        _showError(next.failure);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _ctrl.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _ctrl.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _ctrl, onDetect: _onDetect),
          // Overlay
          IgnorePointer(
            child: Center(
              child: Container(
                width: 260,
                height: 160,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text(
                  'Centrez le code-barres dans le cadre',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccess(ScannerSuccess s) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 8),
            Text(s.food.name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            if (s.food.brand != null) Text(s.food.brand!),
            const SizedBox(height: 8),
            Text('${s.food.kcalPer100g.toStringAsFixed(0)} kcal / 100 g'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref.read(scannerViewModelProvider.notifier).reset();
                    },
                    child: const Text('Scanner autre'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.replace('/add-food/quantity/${s.food.id}');
                    },
                    child: const Text('Ajouter'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showError(Failure f) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(f.message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref.read(scannerViewModelProvider.notifier).reset();
                    },
                    child: const Text('Réessayer'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.replace('/add-food/manual');
                    },
                    child: const Text('Saisir manuellement'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
