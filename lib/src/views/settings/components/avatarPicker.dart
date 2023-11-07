import 'dart:convert';
import 'dart:developer';
import 'package:core/core.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class AvatarPicker extends StatefulWidget {
 final Function? onTap;
 final String? currentImage;
 AvatarPicker({this.onTap,this.currentImage});

 @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  List<String>? avatarImages;
  User user = User();
  bool loaded = false;
  Future _init() async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    log(manifestMap.toString());
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('avatar/'))
        .where((String key) => key.contains('.png'))
        .toList();
    user = (await UserPreferences.user);
    setState(() {
      loaded  = true;
      avatarImages = imagePaths;
    });
  }
  @override
  void initState() {

    super.initState();
    _init();
  }
  @override
  Widget build(BuildContext context) {

    log('avatarPicker has ${avatarImages?.length} images');

  String currentAvatar = widget.currentImage ?? user.data?['avatar'] ?? '';
   return ScreenScaffold(title: 'Pick your Avatar', child:  (avatarImages==null || avatarImages?.length == 0) ?
   (loaded ? Center(child:Text('Could not load avatar images')) :   CircularProgressIndicator()) :
        GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
      ),
      itemCount: avatarImages?.length,
      itemBuilder: (context, index) {
        // Item rendering
        return Card(child:avatarImage(avatarImages![index],active:avatarImages![index]==currentAvatar));
      },
    )
    );
  }
  Widget avatarImage(String image,{active=false}){
    return new GestureDetector(
      onTap: () {
        if(widget.onTap==null){
        user.data!['avatar'] = image;
        loaded=false;
        if(kDebugMode){
        log('Saving avatar');
        }
        UserProvider provider = Provider.of<UserProvider>(context,listen: false);
        if(provider.loaded) {
        provider.saveObject(user.id, user.data, fields: ['avatar']);
        provider.setUser(user);
        UserPreferences.saveUser(user);
        }

        setState(() {
        loaded=true;
        });
        }
        else {
          widget.onTap!(image);
        }
      },
      child: Container(
        decoration: active? BoxDecoration(
            border: Border.all(color: Colors.blueAccent,width: 3),

        ):null,
        child:Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
      Expanded(
      // Add an image to each card.
      child: Image.asset(image,
        fit: BoxFit.cover,
      ),
    ),
       //   Text('$image')
    ]
    ),
      ),

    );
  }
}
