import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildRatingItem extends StatelessWidget {
  final String value;

  const BuildRatingItem({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Rating: ',
          style: GoogleFonts.roboto(
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 5), // Add spacing between label and value
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2), // Adjust color and opacity
            borderRadius: BorderRadius.circular(8), // Adjust border radius
          ),
          child: Row(
            children: [
              Text(
                value,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class BuildInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const BuildInfoItem({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // crucial to avoid overflow
        ),
      ],
    );
  }
}
