import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/application/cart/cart_bloc.dart';
import 'package:machine_test/application/history/history_bloc.dart';
import 'package:machine_test/application/home/home_bloc.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final ValueNotifier<String> urlNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          AppBarCustom(size: size),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeImageSuccess) {
                      urlNotifier.value = state.imageUrl;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: size.width * 0.7,
                              height: size.height * 0.30,
                              child: Image.network(
                                state.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            'Cost : 5000 Rs',
                            style: TextStyle(
                                fontSize:
                                    size.width > 500 ? 25 : size.width * 0.05,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    } else if (state is HomeImageFailed) {
                      return Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.30,
                            child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [const Icon(Icons.error_outline,size: 35,color: Colors.red,),
                                Text(state.errorMessage),
                              ],
                            )),
                            
                          ), SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                fontSize:
                                    size.width > 500 ? 25 : size.width * 0.05,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    } else if (state is HomeLoading) {
                      return PlaceHolderSpace(size: size);
                    } else {
                      return PlaceHolderDefault(size: size);
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(ShowImageEvent());
                        },
                        child: Container(
                          height: 40,
                          width: size.width * 0.3,
                          color: Colors.blue,
                          child: const Center(
                              child: Text(
                            'new image',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BlocListener<CartBloc, CartState>(
                        listener: (context, state) {
                          if (state is CartAddSucess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text('Added to Cart')));
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            if (urlNotifier.value.isNotEmpty) {
                              BlocProvider.of<CartBloc>(context).add(
                                  AddtoCartEvent(imageUrl: urlNotifier.value));
                            } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text('Nothing to add')));
                            }
                          },
                          child: Container(
                            width: 70,
                            height: 50,
                            color: Colors.amber,
                            child: const Icon(Icons.add_shopping_cart),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceHolderDefault extends StatelessWidget {
  const PlaceHolderDefault({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.30,
          child: const Center(child: Text('Click to see image')),
        ),SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          '',
          style: TextStyle(
              fontSize:
                  size.width > 500 ? 25 : size.width * 0.05,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class PlaceHolderSpace extends StatelessWidget {
  const PlaceHolderSpace({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.30,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              backgroundColor: Colors.black,
            ),
          ),
        ), SizedBox(
          height: size.height * 0.01,
        ),
        Text(
          '',
          style: TextStyle(
              fontSize:
                  size.width > 500 ? 25 : size.width * 0.05,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 70,
      color: Colors.blue,
      child: Center(
        child: Text(
          'View dogs',
          style: TextStyle(
              fontSize: size.width > 500 ? 23 : size.width * 0.05,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
