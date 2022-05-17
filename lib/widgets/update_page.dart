import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new_project/models/product.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/providers/image_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class UpdatePage extends StatelessWidget {
final Product product;
UpdatePage(this.product);

  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
          builder: (context, ref, child) {
            final image = ref.watch(imageProvider).image;
            return Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    Text('Update Form', style: TextStyle(fontSize: 17, color: Colors.blueGrey, letterSpacing: 2),),
                    SizedBox(height: 70,),
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide productName';
                        }else if(val.length > 55){
                          return 'maximum character 55';
                        }
                        return null;
                      },
                      controller: titleController..text = product.product_name,
                      decoration: InputDecoration(
                          hintText: 'ProductName',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      maxLines: 3,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide description';
                        }
                        return null;
                      },
                      controller:detailController..text = product.product_detail,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()
                      ),
                    ),

                    SizedBox(height: 30,),
                    TextFormField(
                      maxLines: 3,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide price';
                        }
                        return null;
                      },
                      controller: priceController..text =  '${product.price}',
                      decoration: InputDecoration(
                          hintText: 'Description',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()
                      ),
                    ),

                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: InkWell(
                        onTap: (){
                          ref.read(imageProvider).imagePick();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                          height: 150,
                          width: 150,
                          child:image == null ? Image.network(product.image)
                              : Image.file(File(image.path), fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () async{
                            _form.currentState!.save();
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            if(image == null){
                              final response = await ref.read(crudProvider).updateProduct(
                                  product_name: titleController.text.trim(),
                                      product_detail: detailController.text.trim(),
                                  id: product.id,
                                price: int.parse(priceController.text.trim())
                              );
                              if(response != 'success'){
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 1500),
                                  content: Text(response),
                                ));
                              }else{
                                ref.refresh(dataProvider);
                                Navigator.of(context).pop();
                              }


                            }else{
                              final response = await ref.read(crudProvider).updateProduct(
                                  product_name: titleController.text.trim(),
                                  product_detail: detailController.text.trim(),
                                  price: int.parse(priceController.text.trim()),
                                  image: image,
                                  id: product.id,
                                imageId: product.public_id
                              );
                              if(response != 'success'){
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 1500),
                                  content: Text(response),
                                ));
                              }else{
                                ref.refresh(dataProvider);
                                Navigator.of(context).pop();
                              }

                            }


                          }, child:  Text('Submit')
                      ),
                    ),

                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
