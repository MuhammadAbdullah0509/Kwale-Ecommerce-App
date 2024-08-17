import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kwale/screens/home_screen/review_screen/add_review_screen.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';


class ViewAllReviews extends StatelessWidget {
  const ViewAllReviews({super.key});

  // final List<ReviewModel> reviews = [
  //   ReviewModel(username: 'JohnDoe', review: 'Great app! Love it!', rating: 4.5),
  //   ReviewModel(username: 'JaneSmith', review: 'Very useful. Highly recommended.', rating: 5),
  //   // Add more sample reviews here
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Replace with desired action
          },
        ),
        title: const Text('User Reviews',style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text('245 Reviews'),
                     AddRatingBar(rating: 3),
                   ],
                 ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewScreen(),),);
                  },
                  icon: const Icon(Icons.rate_review),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  ),
                  label: const Text('Add Review'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,//reviews.length,
              itemBuilder: (context, index) {
                //final review = reviews[index];
                return _buildReviewCard();//review
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard() {//
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
             const Text(
                'Username: ',//${review.username}
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //SizedBox(width: 10),
              const Spacer(),
              RatingBarIndicator(
                rating: 3,//review.rating,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('User Review Add here'),
        ],
      ),
    );
  }
}
