import 'package:flutter/material.dart';
import 'package:satudata_mobile/presentation/widget/appbar_widget.dart';

class PublikasiScreen extends StatelessWidget {
  const PublikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SatuDataAppBar(),
      ),
      body: Center(
        child: Text('Publikasi'),
      ),
    );
  }
}
