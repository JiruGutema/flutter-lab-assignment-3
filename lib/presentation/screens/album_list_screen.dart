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
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final album = state.albums[index];
                return ListTile(
                  leading: Image.asset(
                    'assets/images/thumbnail.png',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(
                    album.id.toString() + "  " + album.title,
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => context.push('/detail/${album.id}'),
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
