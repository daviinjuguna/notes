import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeDetailsPage extends StatefulWidget {
  const HomeDetailsPage({
    super.key,
    @PathParam('id') this.noteId = 'create',
  });
  final String noteId;

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
