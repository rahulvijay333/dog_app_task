import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:machine_test/application/cart/cart_bloc.dart';
import 'package:machine_test/application/history/history_bloc.dart';
import 'package:machine_test/application/home/home_bloc.dart';
import 'package:machine_test/domain/hive_model/hive_db_model.dart';
import 'package:machine_test/infrastructure/cart/cart_service.dart';
import 'package:machine_test/infrastructure/history/history_db.dart';
import 'package:machine_test/infrastructure/home/home_service.dart';
import 'package:machine_test/presentation/Home/screen_home.dart';
import 'package:machine_test/presentation/screen_main.dart';

final get_it = GetIt.instance;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(HiveHistoryDbAdapter().typeId)) {
    Hive.registerAdapter(HiveHistoryDbAdapter());
  }

  if (!Hive.isAdapterRegistered(HiveCartDbAdapter().typeId)) {
    Hive.registerAdapter(HiveCartDbAdapter());
  }

  runApp(const MyApp());

  get_it.registerSingleton<HomeService>(HomeService());
  get_it.registerSingleton<HistoryDbOp>(HistoryDbOp());
  get_it.registerSingleton<CartDbService>(CartDbService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeBloc(get_it<HomeService>(), get_it<HistoryDbOp>()),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(get_it<HistoryDbOp>()),
        ),
        BlocProvider(
          create: (context) => CartBloc(get_it<CartDbService>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenMain(),
      ),
    );
  }
}
