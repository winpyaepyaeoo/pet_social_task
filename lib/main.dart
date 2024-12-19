import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_social_task/bloc/get/cubit/get_posts_cubit.dart';
import 'package:pet_social_task/data/api/api_service.dart';
import 'package:pet_social_task/screen/home_screen.dart';

import 'screen/splash_screen.dart';

void main() async {
  //locator();
  await Hive.initFlutter();
  await Hive.openBox('tokenBox');
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<GetPostsCubit>(
        create: (context) => GetPostsCubit(apiService: ApiService()),
        child: const SplashScreen(),
      ),
    );
  }
}
