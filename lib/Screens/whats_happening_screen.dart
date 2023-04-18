import 'package:flutter/material.dart';
import 'package:psic_project/Model/data_model.dart';
import 'package:psic_project/controller/session_by_day_controller.dart';

import '../widgets/custom_navigation_bar.dart';
import 'session_detail.dart';

class WhatsHappeningScreenPage extends StatefulWidget {
  const WhatsHappeningScreenPage({Key? key}) : super(key: key);

  @override
  State<WhatsHappeningScreenPage> createState() =>
      _WhatsHappeningScreenPageState();
}

class _WhatsHappeningScreenPageState extends State<WhatsHappeningScreenPage> {
  int index = 0;
  final SessionByDayController _sessionByDayController =
      SessionByDayController();
  GlobalKey streamkey = GlobalKey();
  List<HallSessions>? allhallSessions = [];
  var current = 1;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CustomNavigationBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<List<HallSessions>>(
              key: streamkey,
              stream: _sessionByDayController.getWhatsHappening().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black54,
                                  size: 30,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 90),
                                child: Text(
                                  'What\'s Happening',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: index <= snapshot.data!.length,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, indexList2) {
                                      dynamic date = 0;
                                      dynamic time = 0;
                                      dynamic endTime = 0;
                                      try {
                                        time = int.parse(
                                          snapshot.data!
                                              .elementAt(indexList2)
                                              .sessionTime!
                                              .replaceAll('-', ',')
                                              .replaceAll(':', ',')
                                              .split(',')
                                              .elementAt(0)
                                              .toString(),
                                        );

                                        endTime = int.parse(
                                          snapshot.data!
                                              .elementAt(indexList2)
                                              .sessionTime!
                                              .replaceAll('-', ',')
                                              .replaceAll(':', ',')
                                              .split(',')
                                              .elementAt(2)
                                              .toString(),
                                        );

                                        date = int.parse(
                                          snapshot.data!
                                              .elementAt(indexList2)
                                              .sessionDate!
                                              .replaceAll(',', '')
                                              .split(' ')
                                              .toList()
                                              .elementAt(1)
                                              .toString(),
                                        );
                                      } catch (ex) {
                                        rethrow;
                                      }

                                      print('Time: $time');
                                      print('EndTime: $endTime');
                                      print('Date: $date');

                                      // if (time >= DateTime.now().month &&
                                      //     (snapshot.data!
                                      //         .elementAt(indexList2)
                                      //         .sessionDate!
                                      //         .contains('-')
                                      //         ? false
                                      //         : DateTime.now().day == date))

                                      if (endTime > DateTime.now().hour &&
                                          DateTime.now().day == date) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SessionDetail(
                                                                sessions: snapshot
                                                                    .data
                                                                    ?.elementAt(
                                                                        indexList2),
                                                                sessionIndex:
                                                                    indexList2,
                                                                allSessionsList:
                                                                    snapshot
                                                                        .data,
                                                              )));
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) => SessionDetail(
                                                  //             sessions: allhallSessions
                                                  //                 ?.elementAt(
                                                  //                     indexList2),
                                                  //             allSessionsList:
                                                  //                 allhallSessions,
                                                  //             sessionIndex:
                                                  //                 indexList2)));
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade400,
                                                        spreadRadius: 1,
                                                        blurRadius: 5,
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.7,
                                                              child: Text(
                                                                '${snapshot.data?.elementAt(indexList2).sessionDate}-${snapshot.data?.elementAt(indexList2).sessionHall}\n',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.3,
                                                              child: Text(
                                                                '${snapshot.data?.elementAt(indexList2).sessionName}\n',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${snapshot.data?.elementAt(indexList2).sessionTime}\n',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          SessionDetail(
                                                                            sessions:
                                                                                snapshot.data?.elementAt(indexList2),
                                                                            sessionIndex:
                                                                                indexList2,
                                                                            allSessionsList:
                                                                                snapshot.data,
                                                                          )));
                                                              // Navigator.of(context).push(
                                                              //     MaterialPageRoute(
                                                              //         builder: (context) =>
                                                              //             SessionDetail(
                                                              //               sessions:
                                                              //                   allhallSessions?.elementAt(indexList2),
                                                              //               allSessionsList:
                                                              //                   allhallSessions,
                                                              //               sessionIndex:
                                                              //                   indexList2,
                                                              //             )));
                                                            },
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(MaterialPageRoute(
                                                                        builder: (context) => SessionDetail(
                                                                              sessions: snapshot.data?.elementAt(indexList2),
                                                                              sessionIndex: indexList2,
                                                                              allSessionsList: snapshot.data,
                                                                            )));
                                                              },
                                                              child: Text(
                                                                '${snapshot.data?.elementAt(indexList2).sessionDetail!.replaceAll('<br />', '').replaceAll('\n', '')}',
                                                                maxLines: 100,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xff8e3434),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ),
                              const SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                              color: Color(0xff8e3434)),
                        )
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
