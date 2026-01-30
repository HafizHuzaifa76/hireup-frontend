import 'dart:typed_data';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hire_up_web/widgets/primary_button.dart';
import '../../providers/application_provider.dart';

class ApplyPage extends ConsumerStatefulWidget {
  final String jobId;
  const ApplyPage({super.key, required this.jobId});

  @override
  ConsumerState<ApplyPage> createState() => _ApplyPageState();
}

class _ApplyPageState extends ConsumerState<ApplyPage> {
  Uint8List? _pdfBytes;
  String? _uploadedUrl;
  String? _fileName;
  bool _isUploading = false;
  final _coverLetterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(applicationControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apply for Job",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 768 ? 120 : 24,
          vertical: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              "Submit Your Application",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Complete the following steps to apply for this position",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 40),

            // Steps Indicator
            _buildStepsIndicator(),
            const SizedBox(height: 40),

            // Resume Upload Section
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.insert_drive_file_outlined,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Upload Resume",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              "Upload your resume in PDF format (max 5MB)",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Upload Area
                  InkWell(
                    onTap: _isUploading ? null : _pickPdf,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: _pdfBytes == null
                            ? const Color(0xFFF8FAFC)
                            : const Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _pdfBytes == null
                              ? Colors.grey.shade300
                              : const Color(0xFF86EFAC),
                          width: 2,
                        ),
                      ),
                      child: _pdfBytes == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Click to upload your resume",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "PDF format only • Max 5MB",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 60,
                            color: const Color(0xFF10B981),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _fileName ?? "Resume.pdf",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Successfully uploaded",
                            style: TextStyle(
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: _isUploading ? null : _pickPdf,
                            child: const Text("Upload Different File"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (_isUploading) ...[
                    const SizedBox(height: 20),
                    const LinearProgressIndicator(
                      backgroundColor: Color(0xFFE5E7EB),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Uploading...",
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Cover Letter Section
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cover Letter",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              "Tell the employer why you're a great fit (optional)",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _coverLetterController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: "Write your cover letter here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Submit Application Button
            PrimaryButton(
              text: loading ? "Submitting..." : "Submit Application",
              isLoading: loading,
              icon: Icons.send_outlined,
              width: double.infinity,
              height: 56,
              onPressed: _uploadedUrl == null
                  ? null
                  : () async {
                await ref.read(applicationControllerProvider.notifier)
                    .apply(
                  widget.jobId,
                  _uploadedUrl!,
                  context,
                );
              },
            ),
            const SizedBox(height: 20),

            // Cancel Button
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel Application",
                  style: TextStyle(
                    color: Color(0xFFEF4444),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsIndicator() {
    return Row(
      children: [
        _buildStep(1, "Resume", _pdfBytes != null),
        Expanded(
          child: Container(
            height: 2,
            color: _pdfBytes != null
                ? const Color(0xFF2563EB)
                : Colors.grey.shade300,
          ),
        ),
        _buildStep(2, "Review", false),
        Expanded(
          child: Container(
            height: 2,
            color: Colors.grey.shade300,
          ),
        ),
        _buildStep(3, "Submit", false),
      ],
    );
  }

  Widget _buildStep(int number, String label, bool completed) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: completed
                ? const Color(0xFF2563EB)
                : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: completed
                ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 20,
            )
                : Text(
              number.toString(),
              style: TextStyle(
                color: completed
                    ? Colors.white
                    : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: completed
                ? const Color(0xFF2563EB)
                : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Future<void> _pickPdf() async {
    final input = FileUploadInputElement();
    input.accept = ".pdf";
    input.click();

    input.onChange.listen((event) async {
      final file = input.files!.first;

      if (file.size > 5 * 1024 * 1024) { // 5MB limit
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("File size must be less than 5MB"),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
        return;
      }

      setState(() {
        _isUploading = true;
        _fileName = file.name;
      });

      final reader = FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((event) async {
        _pdfBytes = reader.result as Uint8List;

        try {
          final res = await ref.read(applicationControllerProvider.notifier)
              .uploadPdfAndGetUrl(_pdfBytes!, file.name, context);

          setState(() {
            _uploadedUrl = res;
            _isUploading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Resume uploaded successfully"),
              backgroundColor: Color(0xFF10B981),
            ),
          );
        } catch (e) {
          setState(() {
            _isUploading = false;
            _pdfBytes = null;
            _fileName = null;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Upload failed: $e"),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      });
    });
  }
}