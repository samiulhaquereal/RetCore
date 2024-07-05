import 'package:retcore/src/config/imports.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CustomErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.bug_report_outlined,
                color: tRed,
                size: 50,
              ),
              const SizedBox(height: 10),
              const Text(
                tErrorHandle,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> initializeRetCoreErrorHandling() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => SafeArea(
    child: Scaffold(
      body: CustomErrorWidget(errorMessage: details.exceptionAsString()),
    ),
  );
}
