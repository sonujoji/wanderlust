
// home page view old design

// Padding(
//                               padding: const EdgeInsets.only(top: 20),
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => TripDetails()));
//                                 },
//                                 child: Container(
//                                   height: 170,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.4),
//                                           blurRadius: 10,
//                                         )
//                                       ]),
//                                   child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Stack(
//                                         children: [
//                                           //trip image
//                                           Image.asset(
//                                             'assets/images/pexels-pixabay-237272.jpg',
//                                             fit: BoxFit.cover,
//                                             width: double.infinity,
//                                             height: double.infinity,
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                     begin: Alignment.topCenter,
//                                                     end: Alignment.bottomCenter,
//                                                     colors: [
//                                                   Colors.transparent,
//                                                   Colors.black.withOpacity(0.4),
//                                                 ])),
//                                           ),

//                                           //texts
//                                           Positioned(
//                                             bottom: 20,
//                                             left: 20,
//                                             right: 20,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       trip.title,
//                                                       style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     Icon(
//                                                       Icons
//                                                           .double_arrow_outlined,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       )),
//                                 ),
//                               ),
//                             );