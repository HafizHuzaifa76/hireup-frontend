import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hire_up_web/screens/jobs/add_job_page.dart';
import 'package:hire_up_web/widgets/primary_button.dart';
import '../../models/job.dart';
import '../../providers/job_provider.dart';
import '../../widgets/app_text_field.dart';
import '../applications/job_applications_page.dart';

class UpdateJobPage extends ConsumerStatefulWidget {
  final JobModel job;

  const UpdateJobPage({super.key, required this.job});

  @override
  ConsumerState<UpdateJobPage> createState() => _UpdateJobPageState();
}

class _UpdateJobPageState extends ConsumerState<UpdateJobPage> {
  late final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(text: widget.job.title);
  late final _companyController = TextEditingController(text: widget.job.company);
  late final _locationController = TextEditingController(text: widget.job.location);
  late final _descriptionController = TextEditingController(text: widget.job.description);
  late final _startSalaryController = TextEditingController(text: widget.job.startingSalary.toString());
  late final _endSalaryController = TextEditingController(text: widget.job.endingSalary.toString());
  late final _tagsController = TextEditingController(text: widget.job.tags.join(", "));

  String _selectedEmploymentType = "full-time";
  final List<String> _employmentTypes = [
    "full-time",
    "part-time",
    "contract",
    "internship",
    "remote",
  ];

  @override
  void initState() {
    super.initState();
    // Set initial employment type from job data
    _selectedEmploymentType = "full-time";
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(jobControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Job",
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
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFF2563EB),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Update Job Listing",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Make changes to your existing job posting",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Basic Information Card
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
                        const Text(
                          "Basic Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Job Title
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Job Title *",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _titleController,
                              hintText: "e.g., Senior Flutter Developer",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a job title';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Company Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Company Name *",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _companyController,
                              hintText: "e.g., TechCorp Inc.",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter company name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Location
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Location *",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _locationController,
                              hintText: "e.g., Remote, New York, NY",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter job location';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Job Details Card
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
                        const Text(
                          "Job Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Salary Range Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Starting Salary *",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextField(
                                    controller: _startSalaryController,
                                    hintText: "e.g., 50000",
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter starting salary';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Ending Salary *",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AppTextField(
                                    controller: _endSalaryController,
                                    hintText: "e.g., 80000",
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter ending salary';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Employment Type
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Employment Type *",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: _employmentTypes.map((type) {
                                final isSelected = _selectedEmploymentType == type;
                                return ChoiceChip(
                                  label: Text(
                                    type.replaceAll('-', ' ').titleCase,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : const Color(0xFF64748B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setState(() {
                                      _selectedEmploymentType = type;
                                    });
                                  },
                                  backgroundColor: Colors.white,
                                  selectedColor: const Color(0xFF2563EB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: isSelected
                                          ? const Color(0xFF2563EB)
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Job Description
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Job Description *",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _descriptionController,
                              hintText: "Describe the job responsibilities, requirements, and benefits...",
                              maxLines: 8,
                              minLines: 6,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter job description';
                                }
                                if (value.length < 50) {
                                  return 'Description should be at least 50 characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Tags Card
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
                        const Text(
                          "Tags & Skills",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tags (comma separated)",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _tagsController,
                              hintText: "e.g., flutter, dart, mobile, ui/ux",
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.job.tags.map((tag) {
                                return Chip(
                                  label: Text(tag),
                                  backgroundColor: const Color(0xFFEFF6FF),
                                  deleteIcon: const Icon(Icons.close, size: 16),
                                  onDeleted: () {
                                    setState(() {
                                      final tags = _tagsController.text
                                          .split(",")
                                          .map((e) => e.trim())
                                          .where((t) => t != tag && t.isNotEmpty)
                                          .toList();
                                      _tagsController.text = tags.join(", ");
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: loading ? "Updating..." : "Save Changes",
                          isLoading: loading,
                          icon: Icons.save_outlined,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(jobControllerProvider.notifier).updateJob(
                                widget.job.id,
                                {
                                  "title": _titleController.text,
                                  "company": _companyController.text,
                                  "location": _locationController.text,
                                  "description": _descriptionController.text,
                                  "starting_salary_range": int.parse(_startSalaryController.text),
                                  "ending_salary_range": int.parse(_endSalaryController.text),
                                  "tags": _tagsController.text.split(",").map((e) => e.trim()).toList(),
                                  "employment_type": _selectedEmploymentType,
                                },
                                context,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      PrimaryButton(
                        text: "Preview",
                        variant: ButtonVariant.outlined,
                        icon: Icons.visibility_outlined,
                        onPressed: () {
                          // Preview functionality
                        },
                      ),
                      const SizedBox(width: 16),
                      PrimaryButton(
                        text: "Delete",
                        variant: ButtonVariant.danger,
                        icon: Icons.delete_outline,
                        onPressed: () {
                          _showDeleteDialog(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Cancel Button
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Discard Changes",
                        style: TextStyle(
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Job Listing"),
          content: const Text(
            "Are you sure you want to delete this job listing? "
                "This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement delete functionality
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Job listing deleted successfully"),
                    backgroundColor: Color(0xFF10B981),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}