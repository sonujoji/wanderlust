import 'dart:developer';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/memories_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/completed_container.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class CompletedTripDetails extends StatefulWidget {
  final String tripId;
  final Trip trip;

  const CompletedTripDetails(
      {super.key, required this.tripId, required this.trip});

  @override
  State<CompletedTripDetails> createState() => _CompletedTripDetailsState();
}

class _CompletedTripDetailsState extends State<CompletedTripDetails> {
  final ImagePicker _picker = ImagePicker();
  final MemoriesService _memoriesService = MemoriesService();
  List<String> imagePaths = [];
  List<String> memoriesId = [];

  Future<void> _loadMemories() async {
    await _memoriesService.openBox();
    final memories = await _memoriesService.getMemoriesById(widget.tripId);
    setState(() {
      imagePaths = memories.expand((mems) => mems.memories).toList();
      memoriesId = memories.map((mems) => mems.id).toList();
    });
    memoriesListNotifier.value = memories;
    memoriesListNotifier.notifyListeners();
  }

  Future<void> _pickandSaveImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      for (XFile image in images) {
        final memories = Memories(
          memories: [image.path],
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tripId: widget.tripId,
        );
        await _memoriesService.addMemories(memories);
        log('added memmories');
        customSnackBar(context, 'Memmories added');
      }
    }
    await _loadMemories();
  }

  @override
  void initState() {
    _loadMemories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    final trip = widget.trip;
    return ValueListenableBuilder(
      valueListenable: memoriesListNotifier,
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: primaryColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: white,
                      )),
                  backgroundColor: primaryColor,
                  pinned: true,
                  floating: false,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        trip.title,
                        style: TextStyle(
                          color: white,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
                      background: Image.file(
                        File(widget.trip.destinationImage),
                        fit: BoxFit.cover,
                      )),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Completed trip details component
                          CompletedTripDetailsContainer(trip: trip),
                          SizedBox(height: 20),

                          // memories button
                          ContainerButton(
                              trip: trip, text: 'Memories', width: 0.27),

                          //memories view
                          GalleryView(imagePaths: imagePaths)
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: blue,
              onPressed: () {
                _pickandSaveImages();
              },
              child: Icon(Icons.add),
            ));
      },
    );
  }
}
