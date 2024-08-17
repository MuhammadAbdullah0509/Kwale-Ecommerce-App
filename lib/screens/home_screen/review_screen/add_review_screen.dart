import 'package:flutter/material.dart';
import 'package:kwale/screens/widgets_screens/rating_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double _rating = 0;
  double _initialRating = 2.0;

  final _reviewTextController = TextEditingController();

  final _reviewTextAreaController = TextEditingController();

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
        title: const Text(
          'Add Review',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text box for a short review
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffF8F8FF),
            ),
            child: TextField(
              controller: _reviewTextController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Text area for a long review
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffF8F8FF),
            ),
            child: TextField(
              controller: _reviewTextAreaController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Add Review',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  initialRating: _initialRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: const Color(0xff8EEBEC),
                  itemCount: 5,
                  itemSize: 30.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                  updateOnDrag: true,
                ),
                const SizedBox(height: 20),
                //Text('Rating: $_rating'),
                //AddRatingBar(rating: _rating),
              ],
            ),
          ),

          const SizedBox(height: 16.0),
          const Spacer(),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.1,
            child: ElevatedButton(
              onPressed: () {
                // You can handle the submission of the review here,
                // Do something with the review data, e.g., save it to a database
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              child: const Text('Submit Review'),
            ),
          ),
        ],
      ),
    );
  }
}
