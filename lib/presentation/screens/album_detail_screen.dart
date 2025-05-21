// lib/presentation/screens/album_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/album_bloc.dart';

class AlbumDetailScreen extends StatelessWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album $albumId')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoaded) {
            final album = state.albums.firstWhere((a) => a.id == albumId);
            final photos =
                state.photos.where((p) => p.albumId == albumId).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  album.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  // style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                ...photos.map(
                  (photo) => ListTile(
                    leading: Image.asset(
                      'assets/images/thumbnail.png',
                      width: 50,
                      height: 50,
                    ),

                    title: Row(
                      children: [
                        Text(
                          photo.id.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(photo.title, overflow: TextOverflow.clip),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
