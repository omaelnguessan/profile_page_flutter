import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width =  size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facebook Profile",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("images/cover.jpg",
                height: 200, fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 125),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 75,
                    child: profilePicture(72),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Spacer(),
                Text(
                  "Omael N'guessan",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Spacer()
              ],
            ),
            Padding(
                padding: EdgeInsets.all(10),
              child: Text(
                "Plus noir est le font de la tasse plus pure sera le code, c'est l'heure de coder",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ButtonContainer(text: "Modifier le profile")
                ),
                ButtonContainer(icon: Icons.border_color)
              ],
            ),
            separator(),
            sectionTitleText("A propos de moi"),
            aboutRow(icon: Icons.home, text: "Yopougon millionnaire, Abidjan"),
            aboutRow(icon: Icons.work, text: "Développeur fullstack"),
            aboutRow(icon: Icons.favorite, text: "En couple mon Macbook"),
            separator(),
            sectionTitleText("Amis"),
            allFriends(this.friends, width/3.5),
            allFriends(this.friends, width/3.5),
            separator(),
            sectionTitleText("Mes posts"),
            postContainer(time: "5 minutes", title: "Petit tour au magic world, carnaval on s'amuse bien ici", imagePath: "images/carnaval.jpg", like: 2, comments: 2),
            postContainer(time: "2 jours", title: "la montagne est magnifique", imagePath: "images/mountain.jpg", like: 38, comments: 80),
            postContainer(time: "1 semaine", title: "Bon retour au bureau", imagePath: "images/work.jpg", like: 140, comments: 80),
            postContainer(time: "1 mois", title: "Enfin je suis en vacance", imagePath: "images/playa.jpg", like: 230, comments: 80),
          ],
        ),
      ),
    );
  }

  CircleAvatar profilePicture(double raduis) {
    return  CircleAvatar(
      radius: raduis,
      backgroundImage: const AssetImage("images/profile.jpg"),
    );
  }

  Container ButtonContainer({IconData? icon, String? text}) {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        padding: const EdgeInsets.all(11),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
        ),
        child: (icon == null) ?
            Center(
              child: Text(
                "$text",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white,),
              ),
            )
            : Icon(icon,
          color: Colors.white,
        ),
      );
  }

  Widget sectionTitleText(String text)  {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget aboutRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon),
        Padding(
            padding: const EdgeInsets.all(5),
          child: Text(text),
        )
      ],
    );
  }

  Column friendsPicture({required String name, required String picturePath, required double width}) {
    return Column(
      children: [
        Container(
          width: width,
          height: width,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(picturePath),
              fit: BoxFit.cover,
          ),
            borderRadius:  BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.grey)]
          ),
        ),
        Text(name),
        const Padding(padding: EdgeInsets.only(bottom: 5))
      ],
    );
  }

  Divider separator() {
    return const Divider(thickness: 2,);
  }

  Map<String, String> friends = {
    "Diana Odjodé": "images/cat.jpg",
    "Sanogo Djakaridja": "images/duck.jpg",
    "John Mary": "images/sunflower.jpg",
  };

  Row allFriends(Map<String, String> friends,double width) {
    List<Widget> children = [];
    friends.forEach((name, picturePath) {
      children.add(
          friendsPicture(name: name, picturePath: picturePath, width: width)
      );
    });
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Map<int, Map<String, Object>> posts = {
    1: {
      "time": "5 minutes",
      "title": "Petit tour au magic world, carnaval on s'amuse bien ici",
      "imagePath": "images/carnaval.jpg",
      "like": 150,
      "comments": 2,
    },
    2: {
      "time": "",
      "title": "",
      "imagePath": "",
      "like": 2,
      "comments": 2,
    },
    3: {
      "time": "",
      "title": "",
      "imagePath": "",
      "like": 2,
      "comments": 2,
    },
  };

  Container postContainer({ required String time, required String title,
    required String imagePath,
    int like = 0,
    int comments = 0}) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(225, 225, 225, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              profilePicture(20),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text("Omael N'guessan", style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              Spacer(),
              timeText(time),
            ],
          ),
          Text(title, textAlign: TextAlign.center,),
          Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Image.asset(imagePath, fit: BoxFit.cover,),
          )
          ,

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.favorite, color: Colors.red,),
              Text("$like Likes"),
              Icon(Icons.message, color: Colors.grey,),
              Text("$comments Commentaires")
            ],
          )
        ],
      ),
    );
  }

  Text timeText(String time) {
    return Text("il y a $time",
    style: TextStyle(
      color: Colors.black54
    ),
    );
  }

}


