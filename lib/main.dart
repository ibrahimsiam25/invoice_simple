import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice_simple/core/di/dependency_injection.dart';
import 'package:invoice_simple/core/helpers/custom_bloc_observer.dart';
import 'package:invoice_simple/my_app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await ScreenUtil.ensureScreenSize();
  await setupGetIt();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );

  Bloc.observer = CustomBlocObserver();
  runApp(const MyApp());
}
