import 'package:flutter/material.dart';
import 'package:optima/providers/fire_storage_service.dart';
import 'package:optima/widgets/app_drawer.dart';


final String image1 = "image1.jpg";
final String image2 = "image2.jpg";
final String image3="image3.jpg";


String image = "";
class LoadFirebaseStorageImage extends StatefulWidget {
  @override
  _LoadFirebaseStorageImageState createState() =>
      _LoadFirebaseStorageImageState();
}

class _LoadFirebaseStorageImageState extends State<LoadFirebaseStorageImage> {

  var imageList = [image1, image2,image3];
  int i=-1;
  int nextImageCount(){
    if(i!=2){
      i++;

    }
    else if(i==2){
      i=0;
    }
    return i;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.grey),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('  View',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "lineto",
                      fontSize: 90,
                      fontWeight: FontWeight.w700
                  ),),
                Text('   Analytics',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "lineto",
                      fontSize: 60,
                      fontWeight: FontWeight.w700
                  ),),
                Divider(color: Colors.grey,),

                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: FutureBuilder(
                            future: _getImage(context, image),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done)
                                return Center(
                                  child: Container(
                                    height:
                                    MediaQuery.of(context).size.height / 1.25,
                                    width:
                                    MediaQuery.of(context).size.width / 1.25,
                                    child: snapshot.data,
                                  ),
                                );

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return
                                  Center(child: CircularProgressIndicator());

                              return Container();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                loadButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[

          Container(
            margin: EdgeInsets.all(25),
            width: double.infinity,
            height: 50,
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  int j= nextImageCount();
                  image=imageList[j];
//                  final _random = new Random();
//                  var imageList = [image1, image2,image3,image4];
//                  image = imageList[_random.nextInt(imageList.length)];
                });
              },
              child: Text('Load Analytics',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "lineto",
                    fontSize: 23,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    });

    return m;
  }
}
