import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/pics/pics_bloc.dart';
import '../blocs/pics/pics_event.dart';
import '../blocs/pics/pics_state.dart';
import '../models/picture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PicsBloc>().add(FetchPics(limit: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pics from Picsum', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<PicsBloc, PicsState>(
          builder: (context, state) {
            if (state is PicsLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PicsLoadFailure) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is PicsLoadSuccess) {
              final pics = state.pics;
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: pics.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final picture = pics[index];
                  return _PicCell(picture: picture);
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class _PicCell extends StatelessWidget {
  final Picture picture;
  const _PicCell({required this.picture});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final aspectRatio = picture.width > 0 ? picture.width / picture.height : 1;
    final height = screenWidth / aspectRatio;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              picture.downloadUrl,
              width: screenWidth - 24, 
              height: height,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return SizedBox(
                  width: screenWidth - 24,
                  height: height,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                width: screenWidth - 24,
                height: height,
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image, size: 48),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Author: ${picture.author}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            'ID: ${picture.id} • ${picture.width}x${picture.height}',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
