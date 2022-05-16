import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_new_project/api.dart';
import 'package:flutter_new_project/models/product.dart';
import 'package:flutter_new_project/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

final crudProvider = Provider((ref) => CrudProvider());
final dataProvider = FutureProvider((ref) => CrudProvider().getData());

class CrudProvider {
  Future<List<Product>> getData() async {
    final dio = Dio();
    try {
      final response = await dio.get(Api.baseUrl);
      final data =
          (response.data as List).map((e) => Product.fromJson(e)).toList();
      return data;
    } on DioError catch (err) {
      throw '${err.message}';
    }
  }

  Future<String> addProduct(
      {required String product_name,
      required String product_detail,
      required int price,
      required XFile image}) async {
    final dio = Dio();
    final box = Hive.box<User>('user').values.toList();
    try {
      final formData = FormData.fromMap({
        'product_name': product_name,
        'product_detail': product_detail,
        'price': price,
        'photo': await MultipartFile.fromFile(image.path),
      });

      final response = await dio.post(Api.addProduct,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}'
          }));
      return 'success';
    } on DioError catch (err) {
      return '${err.message}';
    }
  }


  Future<String> updateProduct(
      {required String product_name,
        required String product_detail,
        required int price,
        String? imageId,
        required String id,
        XFile? image}) async {
    final dio = Dio();
    final box = Hive.box<User>('user').values.toList();
    try {
      if(image == null){
        final response = await dio.patch(Api.updateProduct + '/$id',
            data: {
              'photo': 'no need to update',
              'product_name': product_name,
              'product_detail': product_detail,
              'price': price
            },
            options: Options(headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}'
            }));
      }else{
        final formData = FormData.fromMap({
          'product_name': product_name,
          'product_detail': product_detail,
          'price': price,
          'public_id': imageId,
          'photo': await MultipartFile.fromFile(image.path),
        });

        final response = await dio.patch(Api.updateProduct + '/$id',
            data: formData,
            options: Options(headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}'
            }));

      }
      return 'success';
    } on DioError catch (err) {
      return '${err.message}';
    }
  }




  Future<String> removeProduct({required String id, required String imageId}) async {
    final dio = Dio();
    final box = Hive.box<User>('user').values.toList();
    try {

      final response = await dio.delete(Api.removeProduct + '/$id',
          data: {
          'public_id' : imageId
          },
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box[0].token}'
          }));
      return 'success';
    } on DioError catch (err) {
      return '${err.message}';
    }
  }









}
