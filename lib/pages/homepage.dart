// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_practice/model/user.dart';


class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  

  // Helper function to build info columns
  Widget buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildProfileContent(User user) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
        Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                user.imageUrl,
                width: 100, 
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
        ),
          SizedBox(height: 20),

          Text(
            user.getFullName(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(2, 33, 80, 1),
            ),
          ),
          SizedBox(height: 31),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildInfoColumn('age', user.age.toString()),
              Container(height: 67, child: VerticalDivider(color: Color.fromRGBO(239, 242, 246, 1))),
              buildInfoColumn('gender', user.gender),
              Container(height: 67, child: VerticalDivider(color: Color.fromRGBO(239, 242, 246, 1))),
              buildInfoColumn('birth', user.birthDate),
            ],
          ),
          Container(
            height: 67, 
            child: Divider(
              color: Color.fromRGBO(239, 242, 246, 1
              )
             )
          ),

          Text(
            'Additional information',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 45),

          Icon(
            Icons.question_mark,
            size: 175,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<User>(
        future: fetchUser(),
        builder: (context, snapshot) {
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error loading user data'));
          }

   
          if (snapshot.hasData) {
            return Center(child: buildProfileContent(snapshot.data!));
          }

          return Center(child: Text('No data'));
        },
      ),
    );
  }
}