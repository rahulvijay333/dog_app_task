import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/application/history/history_bloc.dart';

class ScreenHistory extends StatelessWidget {
  const ScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // BlocProvider.of<HistoryBloc>(context).add(ShowHistoryEvent());
    return Column(
      children: [
        Container(
          width: size.width,
          height: 70,
          color: Colors.blue,
          child: Center(
            child: Text(
              'View History',
              style: TextStyle(
                  fontSize: size.width > 500 ? 23 : size.width * 0.05,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: () {
              
              BlocProvider.of<HistoryBloc>(context).add(ClearHistory());
            },
            child: ClearButtonWidget(size: size)),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                );
              } else if (state is HistorySuccess) {
                if (state.history.isEmpty) {
                  return const Center(
                    child: Text('No history'),
                  );
                }

                return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: size.width * 0.7,
                            height: size.height * 0.2,
                            child: Image.network(
                              state.history[index].imageUrl,
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
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: state.history.length);
              }

              return const Center(
                child: Text('Nothing to show'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ClearButtonWidget extends StatelessWidget {
  const ClearButtonWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.04,
      child: Row(
        children: [
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.blue.shade200,
                child: const Text('Clear History')),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
