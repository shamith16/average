import 'package:average/app_exports.dart';

void main() {
  runApp(const AverageApp());
}

class AverageApp extends StatelessWidget {
  const AverageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Average App',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => WorkoutLogProvider(),
        child: const WorkoutLogScreen(),
      ),
    );
  }
}
