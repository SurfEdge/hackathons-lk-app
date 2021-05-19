import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hackathons_lk_app/services/customicons_icons.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Hackathon.lk logo -------------------------------------------------------------------------------
            Image.asset(
              'lib/assets/Hackathons.lk-logo-black.png',
              width: 260,
            ),
            SizedBox(
              height: 16,
            ),
            //* Description
            Text(
              'Hackathons.lk is the online calendar for Hackathons happening in Sri Lanka. Looking at the past couple of years, the growth of Hackathons accelerated sky high such that from school level to corporate level and various other public and private organizations started started initiating Hackathons on a regular basis. In such an environment Hackathons.lk focuses on connecting participants with much relevant Hackathons happening in Sri Lanka while providing a digital infrastructure for Hackathon organizers in the National context.',
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            //* SurfEdge Logo
            Image.asset(
              'lib/assets/SE_Wide-1.png',
              width: 180,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                //* Call button
                // InkWell(
                //   child: Container(
                //     margin: EdgeInsets.only(right: 12),
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       color: Color(0xff1976D2),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Icon(
                //       Icons.call,
                //       color: Colors.white,
                //     ),
                //   ),
                //   //* Call to hackathon.lk
                //   onTap: () async {
                //     await canLaunch('tel:+94764793907')
                //         ? await launch('tel:+94764793907')
                //         : throw 'Could not launch tel:+94764793907';
                //   },
                // ),
                //* Mail button
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff1976D2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  //* Mail to hackathon.lk
                  onTap: () async {
                    await canLaunch('mailto:register@hackathons.lk')
                        ? await launch('mailto:register@hackathons.lk')
                        : throw 'Could not launch mailto:register@hackathons.lk';
                  },
                ),
                //* Website button
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff1976D2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Customicons.globe,
                      color: Colors.white,
                    ),
                  ),
                  //* Open hackathon.lk website
                  onTap: () async {
                    await canLaunch('https://hackathons.lk')
                        ? await launch('https://hackathons.lk')
                        : throw 'Could not launch https://hackathons.lk';
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
