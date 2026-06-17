import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Obx(() {
        final movie = controller.movie.value;
        return CustomScrollView(
          slivers: [
            // Backdrop + Back Button
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
              pinned: true,
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: controller.toggleFavorite,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(() => Icon(
                          controller.isFavorite.value
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: controller.isFavorite.value
                              ? const Color(0xFFE50914)
                              : Colors.white,
                          size: 20,
                        )),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Backdrop Image
                    movie?.backdropPath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w780${movie!.backdropPath}',
                            fit: BoxFit.cover,
                          )
                        : Container(color: const Color(0xFF1A1A1A)),
                    // Gradient overlay
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF0D0D0D),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Movie Info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster + Basic Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Poster
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: movie?.posterPath != null
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w300${movie!.posterPath}',
                                  width: 100,
                                  height: 148,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 148,
                                  color: const Color(0xFF1A1A1A),
                                  child: const Icon(Icons.movie_outlined,
                                      color: Colors.white24),
                                ),
                        ),
                        const SizedBox(width: 16),
                        // Title & Meta
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie?.title ?? 'Movie Title',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.4,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Rating Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1A1A1A),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.08)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: Color(0xFFFFC107), size: 15),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${movie?.voteAverage?.toStringAsFixed(1) ?? '0.0'} / 10',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              _metaRow(Icons.calendar_today_outlined,
                                  movie?.releaseDate ?? '-'),
                              const SizedBox(height: 5),
                              _metaRow(Icons.access_time_outlined,
                                  '${movie?.runtime ?? 0} min'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Genre Chips
                    if (movie?.genres != null && movie!.genres!.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(
                          movie.genres!.length,
                          (i) => _GenreChip(label: movie.genres![i].name ?? ''),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Overview
                    const Text(
                      'Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie?.overview ?? 'No overview available.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Watch Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE50914),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_circle_rounded,
                                color: Colors.white, size: 22),
                            SizedBox(width: 8),
                            Text(
                              'Watch Trailer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _metaRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 13),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 12),
        ),
      ],
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;
  const _GenreChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE50914).withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE50914).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFE50914),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}