import 'package:image_search_2day/data/api/pixabay_api.dart';
import 'package:image_search_2day/data/mapper/photo_mapper.dart';
import 'package:image_search_2day/data/model/photo.dart';
import 'package:image_search_2day/repository/photo_repository.dart';

class PixabayPhotoRepositoryImpl implements PhotoRepository {
  final _api = PixabayApi();

  @override
  Future<List<Photo>> getPhotos(String query) async {
    final resultDto = await _api.getImages(query);

    if (resultDto.hits == null) {
      return [];
    }

    return resultDto.hits!.map((e) => e.toPhoto()).toList();
  }
}
