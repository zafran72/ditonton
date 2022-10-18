// // ignore_for_file: library_private_types_in_public_api

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:core/core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie/domain/entities/movie.dart';
// import 'package:core/presentation/pages/about_page.dart';
// import 'package:movie/presentation/bloc/movie/movie_bloc.dart';
// import 'package:movie/presentation/pages/movie_detail_page.dart';
// import 'package:movie/presentation/pages/popular_movies_page.dart';
// import 'package:movie/presentation/pages/search_page.dart';
// import 'package:movie/presentation/pages/top_rated_movies_page.dart';
// import 'package:movie/presentation/pages/watchlist_movies_page.dart';
// import 'package:flutter/material.dart';

// class HomeMoviePage extends StatefulWidget {
//   const HomeMoviePage({super.key});

//   @override
//   _HomeMoviePageState createState() => _HomeMoviePageState();
// }

// class _HomeMoviePageState extends State<HomeMoviePage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
//       context.read<PopularMoviesBloc>().add(FetchPopularMovies());
//       context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: Column(
//           children: [
//             const UserAccountsDrawerHeader(
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage('assets/circle-g.png'),
//               ),
//               accountName: Text('Ditonton'),
//               accountEmail: Text('ditonton@dicoding.com'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.movie),
//               title: const Text('Movies'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.save_alt),
//               title: const Text('Watchlist'),
//               onTap: () {
//                 Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
//               },
//             ),
//             ListTile(
//               onTap: () {
//                 Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
//               },
//               leading: const Icon(Icons.info_outline),
//               title: const Text('About'),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text('Ditonton'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
//             },
//             icon: const Icon(Icons.search),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Now Playing',
//                 style: kHeading6,
//               ),
//               BlocBuilder<NowPlayingMoviesBloc, MovieBlocState>(
//                   builder: (context, state) {
//                 if (state is MoviesLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is MoviesHasData) {
//                   return MovieList(state.movies);
//                 } else if (state is MoviesHasError) {
//                   return Center(
//                     child: Text(state.message),
//                   );
//                 } else {
//                   return const Text('Failed');
//                 }
//               }),
//               _buildSubHeading(
//                 title: 'Popular',
//                 onTap: () =>
//                     Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
//               ),
//               BlocBuilder<PopularMoviesBloc, MovieBlocState>(
//                   builder: (context, state) {
//                 if (state is MoviesLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is MoviesHasData) {
//                   return MovieList(state.movies);
//                 } else if (state is MoviesHasError) {
//                   return Center(
//                     child: Text(state.message),
//                   );
//                 } else {
//                   return const Text('Failed');
//                 }
//               }),
//               _buildSubHeading(
//                 title: 'Top Rated',
//                 onTap: () =>
//                     Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
//               ),
//               BlocBuilder<TopRatedMoviesBloc, MovieBlocState>(
//                   builder: (context, state) {
//                 if (state is MoviesLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state is MoviesHasData) {
//                   return MovieList(state.movies);
//                 } else if (state is MoviesHasError) {
//                   return Center(
//                     child: Text(state.message),
//                   );
//                 } else {
//                   return const Text('Failed');
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Row _buildSubHeading({required String title, required Function() onTap}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: kHeading6,
//         ),
//         InkWell(
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class MovieList extends StatelessWidget {
//   final List<Movie> movies;

//   const MovieList(this.movies, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           final movie = movies[index];
//           return Container(
//             padding: const EdgeInsets.all(8),
//             child: InkWell(
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   MovieDetailPage.ROUTE_NAME,
//                   arguments: movie.id,
//                 );
//               },
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(16)),
//                 child: CachedNetworkImage(
//                   imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
//                   placeholder: (context, url) => const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//             ),
//           );
//         },
//         itemCount: movies.length,
//       ),
//     );
//   }
// }
