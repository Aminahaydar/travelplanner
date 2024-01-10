import 'package:flutter/material.dart';
import 'package:travelplanner/signup.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blue[900],
        title: Center(
        
          child:Text(
          'wanderwave',
          style: TextStyle(color: Colors.black,fontSize: 20),
        ),
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.designtrends.com/wp-content/uploads/2016/04/11105009/Beautiful-Travel-wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              'Explore the world with WanderWave and let your adventures begin.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color:  Colors.black,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20), 
              
              SizedBox(  height: 50,width: 300,// Add some spacing
              child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                  );
              
                },
              
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey, // You can customize the button color
                ),
                child: Text(
                  'Explore Destinations',
                  style: TextStyle(fontSize: 19),
                )
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}