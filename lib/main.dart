import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:wallpaper_app/full_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BackGround Bliss',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.yellow
        ),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,

      ),
      home: const WallPaper_Screen(),
    );
  }
}

class WallPaper_Screen extends StatefulWidget {
  const WallPaper_Screen({super.key});

  @override
  State<WallPaper_Screen> createState() => _WallPaper_ScreenState();
}

class _WallPaper_ScreenState extends State<WallPaper_Screen> {
  List Images =[];
  int page = 1;

  @override


  void initState() {
    // TODO: implement initState
    super.initState();
fetchApi();
  }
  fetchApi()async{
   await http.get(Uri.parse(
       'https://api.pexels.com/v1/curated?per_page=80'
   ),
   headers :{
     'Authorization' :' npoJQN93P3sBq3D8iqG1LXP4r36GFG4Uve7dTKhfVU4Uk0Z8LwNzv3O4'
   }).then((value){
     Map result = jsonDecode(value.body);
     setState(() {
       Images = result['photos'];
     });
     print(Images);
   });
  }

  Loadmore()async{
    setState(() {
      page = page+1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();
    await http.get(Uri.parse(url),
    headers :{
      'Authorization' : ' npoJQN93P3sBq3D8iqG1LXP4r36GFG4Uve7dTKhfVU4Uk0Z8LwNzv3O4'

       }).then((value)
    {
    Map result = jsonDecode(value.body);
    setState(() {
    Images.addAll(result['photos']);
    });

    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,

        title: const Text("BackGround Bliss ",style: TextStyle(
          color: Colors.yellow,
          fontWeight: FontWeight.bold,

        ),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder( itemCount: Images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            
                  crossAxisCount: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 3/3,
                crossAxisSpacing: 3,
            
            
              ),
            
            
            
                itemBuilder: ( context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(ImagesUrl: Images[index]['src']['large2x']
                        )
                        )
                        );
                      },
                      child: Container(
                        color: Colors.black38,
                        child: Image.network(
                          Images[index]['src']['tiny'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                }, ),
            ),
          ),
          InkWell(
            onTap: (){
              Loadmore();
            },
            child: Container(
              width: double.infinity,
              height: 30,
              color: Colors.black,
              child: const Center(child: Text("Click here to Load more ",style: TextStyle(
                color: Colors.yellow
              ),)),

            ),
          )
        ],
      ),
    );
  }
}



