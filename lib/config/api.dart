class ApiConfig {
  static String baseUrl = "http://127.0.0.1:5000";

  static String signup = "$baseUrl/auth/signup";
  static String signin = "$baseUrl/auth/signin";
  static String verify = "$baseUrl/auth/verify";

  static String addJob = "$baseUrl/jobs/add";
  static String getJobs = "$baseUrl/jobs/get";
  static String deleteJob(String id) => "$baseUrl/jobs/delete/$id";
  static String updateJob(String id) => "$baseUrl/jobs/update/$id";
  static String searchJobs = "$baseUrl/jobs/search";

  static String apply = "$baseUrl/application/apply";
  static String uploadPdf = "$baseUrl/application/uploadPdf";
  static String updateApplication(String id) => "$baseUrl/application/$id";
  static String jobApplications(String id) =>
      "$baseUrl/application/$id";
  static String myApplications = "$baseUrl/application/my-applications";

  static String profile = "$baseUrl/user/profile";
}
