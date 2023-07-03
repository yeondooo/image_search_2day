import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search_2day/ui/main/main_view_model.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('이미지 검색 앱'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: '이미지를 검색해 보세요',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  viewModel.fetchImages(controller.text);
                },
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: viewModel.photos.length,
              itemBuilder: (context, index) {
                final photo = viewModel.photos[index];
                return Hero(
                  tag: photo.id,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/detail', extra: photo);
                    },
                    child: Image.network(
                      photo.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
