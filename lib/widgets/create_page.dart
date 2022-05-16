import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_new_project/providers/crudProvider.dart';
import 'package:flutter_new_project/providers/image_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';




class CreatePage extends StatelessWidget {

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
                    Text('Create Form', style: TextStyle(fontSize: 17, color: Colors.blueGrey, letterSpacing: 2),),
                    SizedBox(height: 70,),
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide title';
                        }else if(val.length > 55){
                          return 'maximum character 55';
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: 'Title',
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
                      controller:detailController,
                      decoration: InputDecoration(
                          hintText: 'Description',
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          border: OutlineInputBorder()
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide title';
                        }else if(val.length > 55){
                          return 'maximum character 55';
                        }
                        return null;
                      },
                      controller: priceController,
                      decoration: InputDecoration(
                          hintText: 'Price',
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
                          child:image == null ?  Center(child: Text('please select an image'))
                              : Image.file(File(image.path), fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () async{
                            _form.currentState!.save();
                            FocusScope.of(context).unfocus();
                                if(image == null){
                                  Get.defaultDialog(
                                      content: Text('required'),
                                      title: 'Please select an image',
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: Text('CLose'))
                                      ]
                                  );
                                }else{
                                  final response = await ref.read(crudProvider).addProduct(
                                      product_name: titleController.text.trim(),
                                      product_detail: detailController.text.trim(),
                                      image: image,
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
