import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/heleprs/pick_image.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/core/widgets/choose_camera_or_gallery.dart';
import 'package:hr/utils/assets/assets.dart';
import 'package:hr/utils/styles/styles.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileWidget extends StatefulWidget {
  const UploadFileWidget({
    super.key,
    required this.label,
    required this.file,
    this.path,
    this.req = false,
  });
  final String label;
  final PassByReference<File?> file;
  final String? path;
  final bool req;
  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Flexible(child: txt(widget.label, e: St.bold18, softwrap: true)),
                  // SizedBox(width: 5),
                  // txt(widget.req ? '*' : '(optinal)', e: St.reg12, c: widget.req ? Colors.red : null),
                ],
              ),
            ),
            widget.file.data != null || widget.path != null
                ? Stack(
                  children: [
                    widget.file.data != null
                        ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          clipBehavior: Clip.hardEdge,
                          child: Image.file(widget.file.data!, fit: BoxFit.cover),
                        )
                        : CachedNetworkImage(
                          imageUrl: widget.path!,
                          placeholder:
                              (context, child) => Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Image.asset(AssetsData.icon, fit: BoxFit.cover),
                                  )
                                  .animate(onPlay: (c) => c.repeat())
                                  .fade(duration: 500.ms, begin: 0.2, end: 0.7)
                                  .then()
                                  .fade(duration: 500.ms, begin: 0.7, end: 0.2),
                          errorWidget:
                              (context, _, child) => Container(
                                height: 150,
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: txt("Image couldn't be displayed"),
                              ),
                        ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.edit, size: 30),
                        ),
                      ),
                    ),
                  ],
                )
                : InkWell(
                  onTap: _pickImage,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: context.primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: txt('Upload', e: St.bold18, c: Colors.white),
                  ),
                ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _pickImage() async {
    final ImageSource? imageSource = await chooseGalleryOrCameraDialog();
    if (imageSource == null) return;
    widget.file.data = await pickImage(imageSource);
    setState(() {});
  }
}
