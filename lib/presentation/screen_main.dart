import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/application/cart/cart_bloc.dart';
import 'package:machine_test/application/history/history_bloc.dart';
import 'package:machine_test/presentation/Cart/screen_cart.dart';
import 'package:machine_test/presentation/History/screen_history.dart';
import 'package:machine_test/presentation/Home/screen_home.dart';

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});

  final ValueNotifier<int> navBarIndexNotifier = ValueNotifier(0);

  final _pages = [ScreenHome(), ScreenHistory(), ScreenCart()];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navBarIndexNotifier,
      builder: (context, value, child) {
        return SafeArea(
          child: Scaffold(
            body: _pages[value],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: navBarIndexNotifier.value,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                onTap: (value) {
                  navBarIndexNotifier.value = value;
        
                  if (value == 1) {
                    BlocProvider.of<HistoryBloc>(context).add(ShowHistoryEvent());
                  } else if(value ==2){
                    BlocProvider.of<CartBloc>(context).add(GetCartDetails());
                  }
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.history), label: 'History'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_bag), label: 'Shoping cart'),
                ]),
          ),
        );
      },
    );
  }
}
