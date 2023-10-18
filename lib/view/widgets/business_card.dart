import 'package:flutter/material.dart';
import 'package:money_cards/constants/colors.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({super.key});

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              // color: bgLighter,
              height: 80,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "./assets/business-card.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Shubhi Paul",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: textDark),
                      ),
                    ),
                    Text(
                      "Sub Space",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textMid),
                    ),
                    Text(
                      "shubhipaul@gmail.com",
                      style: TextStyle(color: textLight),
                    ),
                    Text(
                      "89009-30616",
                      style: TextStyle(color: textLight),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textLight,
            )
          ]),
        ));
  }
}
