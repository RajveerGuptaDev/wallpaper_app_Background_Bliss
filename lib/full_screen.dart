import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';



class FullScreen extends StatefulWidget {
   final String ImagesUrl;
  const FullScreen({super.key, required this.ImagesUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setwallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.ImagesUrl);
    final bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("FullScreen",style: TextStyle(
          color: Colors.yellow,
              fontWeight: FontWeight.bold
        ),),

      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.ImagesUrl),
              ),
            ),
            InkWell(
              onTap: (){
                     setwallpaper();
              },
              child: Container(
                color: Colors.black,
                width: double.infinity,
                height: 30,
                child: const  Center(child: Text("set the WallPaper",style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold
                ),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
