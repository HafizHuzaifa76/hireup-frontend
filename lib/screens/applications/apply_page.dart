import 'dart:typed_data';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/application_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class ApplyPage extends ConsumerStatefulWidget {
  final String jobId;
  const ApplyPage({super.key, required this.jobId});

  @override
  ConsumerState createState() => _ApplyPageState();
}

class _ApplyPageState extends ConsumerState<ApplyPage> {
  Uint8List? pdfBytes;
  String? uploadedUrl;

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(applicationControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Apply for Job")),
      body: Center(
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Upload Resume", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),

              NeuButton(
                text: pdfBytes == null ? "Choose PDF" : "PDF Selected",
                onTap:()=> pickPdf(context),
              ),

              const SizedBox(height: 20),

              if (uploadedUrl != null)
                Text("Uploaded Successfully", style: TextStyle(color: Colors.green)),

              const SizedBox(height: 30),

              NeuButton(
                text: loading ? "Applying..." : "Apply",
                onTap: uploadedUrl == null
                    ? () => showError("Upload PDF First")
                    : () async {
                  await ref.read(applicationControllerProvider.notifier)
                      .apply(widget.jobId, uploadedUrl!, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickPdf(BuildContext context) async {
    final input = FileUploadInputElement();
    input.accept = ".pdf";
    input.click();

    input.onChange.listen((event) async {
      final file = input.files!.first;
      print('file.name');
      print(file.name);
      final reader = FileReader();

      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) async {
        pdfBytes = reader.result as Uint8List;
        print('pdfBytes');

        final res = await ref.read(applicationControllerProvider.notifier)
            .uploadPdfAndGetUrl(pdfBytes ?? Uint8List(0), file.name, context);

        print('res');
        print(res);
        setState(() => uploadedUrl = res);
      });
    });
  }

  void showError(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}
