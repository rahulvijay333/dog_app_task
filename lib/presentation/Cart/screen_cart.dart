import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/application/cart/cart_bloc.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width,
          height: 70,
          color: Colors.blue,
          child: Center(
            child: Text(
              'View Cart',
              style: TextStyle(
                  fontSize: size.width > 500 ? 23 : size.width * 0.05,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Expanded(
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartSuccess) {
              if (state.cartlist.isEmpty) {
                return const Center(child: Text('Cart is empty'));
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 50,
                        color: Colors.amber.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total : ',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${state.cartlist[0].cost! * state.cartlist.length} Rs',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: Colors.blue.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: SizedBox(
                                          width: size.width * 0.35,
                                          height: size.width * 0.3,
                                          child: Image.network(
                                            state.cartlist[index].imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Icons.error);
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${state.cartlist[index].cost.toString()} Rs',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            BlocProvider.of<CartBloc>(context)
                                                .add(DeleteFromCartEvent(
                                                    key: state.cartlist[index]
                                                        .imageUrl));
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: state.cartlist.length),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox(
              child: Center(child: Text('Cart is Empty')),
            );
          }),
        )
      ],
    );
  }
}
