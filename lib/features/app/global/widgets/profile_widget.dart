import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_practice/features/app/theme/style.dart';

Widget Profilewidget({String? imageurl,XFile? image}){
  if(image==null){
    if(imageurl==null||imageurl==""){
      return Image.asset("assets/profile_default.png",fit: BoxFit.contain,);
    }else{
      return CachedNetworkImage(imageUrl: imageurl,fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) => const CircularProgressIndicator(color: tabColor,),
      errorWidget: (context, url, error) => Image.asset("assets/profile_default.png",fit: BoxFit.contain,),
      );
    }
  }else{
    return Image.file(File(image.path),fit: BoxFit.cover,);
  }
}