// lib/presentation/screens/album_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../logic/album_bloc.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),

                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed:
                        () => context.read<AlbumBloc>().add(FetchAlbums()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: (state.albums.length / 2).ceil(),
              itemBuilder: (context, index) {
                final firstAlbum = state.albums[index * 2];
                final secondIndex = index * 2 + 1;
                final hasSecond = secondIndex < state.albums.length;
                final secondAlbum =
                    hasSecond ? state.albums[secondIndex] : null;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade50,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blueGrey, width: 2),
                        ),
                        child: InkWell(
                          onTap: () => context.push('/detail/${firstAlbum.id}'),
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: ClipRect(
                              child: Column(
                                children: [
                                  const Placeholder(
                                    fallbackWidth: 100,
                                    fallbackHeight: 100,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    firstAlbum.id.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                    '${firstAlbum.title}',
                                    style: const TextStyle(fontSize: 18),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
