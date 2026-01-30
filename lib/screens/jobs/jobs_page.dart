import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hire_up_web/screens/jobs/widgets/job_card.dart';
import 'package:hire_up_web/widgets/primary_button.dart';
import '../../models/job.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../widgets/app_text_field.dart';
import '../applications/apply_page.dart';
import 'job_detail_page.dart';

class JobsPage extends ConsumerStatefulWidget {
  const JobsPage({super.key});

  @override
  ConsumerState<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<JobsPage> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';
  final List<String> _filters = ['all', 'remote', 'full-time', 'part-time'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(jobControllerProvider.notifier).loadJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobListProvider);
    final user = ref.watch(authControllerProvider.notifier).user;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Find Your Dream Job",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      floatingActionButton: user?.role == "employer"
          ? FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/add-job'),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Post Job"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      )
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 1200 ? 120 : 24,
          vertical: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Browse Opportunities",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Discover jobs that match your skills",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Search and Filter Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _searchController,
                            hintText: "Search jobs, companies, or keywords",
                            prefixIcon: Icon(Icons.search),
                            onChanged: (value) {
                              ref.read(jobControllerProvider.notifier).searchJobs(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        PrimaryButton(
                          text: "Search",
                          icon: Icons.search,
                          onPressed: () {
                            ref.read(jobControllerProvider.notifier)
                                .searchJobs(_searchController.text);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filters.map((filter) {
                          final isSelected = _selectedFilter == filter;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: FilterChip(
                              label: Text(
                                filter == 'all'
                                    ? 'All Jobs'
                                    : filter.replaceAll(' - ', ' ').titleCase,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = selected ? filter : 'all';
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
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Jobs Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${jobs.length} Jobs Found",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.filter_list_outlined),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'newest',
                        child: Text("Newest First"),
                      ),
                      const PopupMenuItem(
                        value: 'salary',
                        child: Text("Highest Salary"),
                      ),
                      const PopupMenuItem(
                        value: 'relevant',
                        child: Text("Most Relevant"),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Jobs Grid
              jobs.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_outline,
                      size: 80,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "No jobs found",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Try adjusting your search or filter",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 1200 ? 3 :
                  screenWidth > 768 ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return JobCard(
                    job: jobs[index],
                    onTap: () => _showJobDetail(context, jobs[index]),
                    onApply: user?.role == "job_seeker"
                        ? () => _applyForJob(context, jobs[index].id)
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJobDetail(BuildContext context, JobModel job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobDetailPage(job: job),
      ),
    );
  }

  void _applyForJob(BuildContext context, String jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplyPage(jobId: jobId),
      ),
    );
  }
}

// Extension for title case
extension StringExtension on String {
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}