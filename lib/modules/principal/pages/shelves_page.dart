import 'package:e_library/core/instances/instances.dart';
import 'package:e_library/modules/principal/widgets/shelf_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShelvesPage extends StatelessWidget {
  const ShelvesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des étagères'),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () => principalController.getShelves(),
        child: Obx(() {
          if (principalController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (principalController.shelves.isEmpty) {
            return Center(
              child: Text('Empty list'),
            );
          } else {
            return ListView.builder(
              itemCount: principalController.shelves.length,
              itemBuilder: (context, index) {
                return ShelfWidget(shelf: principalController.shelves[index]);
              },
            );
          }
        }),
      ),
    );
  }
}
