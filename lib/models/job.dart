class JobModel {
  final String id;
  final String title;
  final String description;
  final String company;
  final String location;
  final int startingSalary;
  final int endingSalary;
  final List<String> tags;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.startingSalary,
    required this.endingSalary,
    required this.tags,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    company: json["company"],
    location: json["location"],
    startingSalary: json["starting_salary_range"],
    endingSalary: json["ending_salary_range"],
    tags: List<String>.from(json["tags"]),
  );
}
