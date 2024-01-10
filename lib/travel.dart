import 'package:flutter/material.dart';
import 'booking.dart';

class Travel extends StatelessWidget {
  final List<TravelDestination> destinations = [
    TravelDestination(
      imageUrl: 'https://i.pinimg.com/originals/6c/29/da/6c29daac63c1ff4eb94ce4f722227b72.jpg',
      name: 'Paris',
      description: 'The capital of France, known for its art and culture and the most popular artist.',
      price: '\$500',
    ),
    TravelDestination(
      imageUrl: 'https://i.pinimg.com/originals/81/6c/9c/816c9c26b808db60176651e731246dde.jpg',
      name: 'Tokyo',
      description: 'The capital of Japan, known for its modern technology, vibrant street life, and historic temples.',
      price: '\$600',
    ),
    TravelDestination(
      imageUrl: 'https://www.fodors.com/wp-content/uploads/2019/10/01_01_BarcelonaAvoidCrowds__TakeYourselfToChurch_iStock-1029265170-724x483.jpg',
      name: 'Barcelona',
      description: 'A vibrant city in Spain, famous for its architecture, art, and beautiful beaches.',
      price: '\$300',
    ),
    TravelDestination(
      imageUrl: 'https://images4.alphacoders.com/552/thumb-1920-552459.jpg',
      name: 'Berlin',
      description: 'The capital of Germany, known for its rich history, cultural landmarks, and vibrant nightlife.',
      price: '\$700',
    ),
    TravelDestination(
      imageUrl: 'https://worldstrides.com/wp-content/uploads/2018/07/Madrid_Skyline_Spain.jpg',
      name: 'Madrid',
      description: 'The region has its own legislature and enjoys a wide range of competencies in areas such as social spending, healthcare, and education.',
      price: '\$500',
    ),
    TravelDestination(
      imageUrl: 'https://cdn.getyourguide.com/img/location/5ffeb52eae59a.jpeg/88.jpg',
      name: 'New York',
      description: 'New York City is the most populous and densely populated city in the United States, with five boroughs and a rich cultural, financial, and historical heritage.',
      price: '\$350',
    ),
   
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Destinations'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: (destinations.length / 2).ceil(),
          itemBuilder: (context, index) {
            int startIndex = index * 2;
            return Column(
              children: [
                Row(
                  children: [
                    _buildDestinationCard(context, startIndex),
                    SizedBox(width: 16.0), // Adjust the width of the SizedBox for spacing between columns
                    if (startIndex + 1 < destinations.length)
                      _buildDestinationCard(context, startIndex + 1),
                  ],
                ),
                SizedBox(height: 20.0), // Adjust the height of the SizedBox for spacing between rows
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDestinationCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  BookingPage(
              destination: destinations[index],
            ),
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(destinations[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              height: 150,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    destinations[index].name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    destinations[index].description,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Price: ${destinations[index].price}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TravelDestination {
  final String name;
  final String imageUrl;
  final String price;
  final String description;

  TravelDestination({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}