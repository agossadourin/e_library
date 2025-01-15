import 'package:e_library/core/constants/app_colors.dart';
import 'package:e_library/core/controllers/principal/principal_controller.dart';
import 'package:e_library/core/controllers/principal/shelf_details_controller.dart';
import 'package:e_library/core/controllers/splash_screen/splash_screen_controller.dart';
import 'package:e_library/data/services/api.dart';
import 'package:logger/logger.dart';

final SplashScreenController splashScreenController =
    SplashScreenController.instance;
final ApiService apiService = ApiService.instance;
final PrincipalController principalController = PrincipalController.instance;
final ShelfDetailsController shelfDetailsController =
    ShelfDetailsController.instance;

//logger config
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // Number of method calls to be displayed
    errorMethodCount: 8, // Number of method calls if stacktrace is provided
    lineLength: 120, // Width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    // Should each log print contain a timestamp
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
