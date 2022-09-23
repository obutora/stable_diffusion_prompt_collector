import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stable_diffusion_prompt_collector/component/screen/home_screen.dart';
import 'package:stable_diffusion_prompt_collector/component/screen/view_screen.dart';

import '../theme/colors.dart';

class StandardScaffold extends StatelessWidget {
  const StandardScaffold({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: zinc900,
        elevation: 0,
        title: Text(
          'Stable Diffusion Prompt Collctor',
          style: Theme.of(context).textTheme.button!.copyWith(color: white200),
        ),
      ),
      drawer: Drawer(
        backgroundColor: zinc800,
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Select Pages',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              trailing: IconButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, HomeScreen.id),
                  icon: const Icon(
                    CupertinoIcons.right_chevron,
                    color: white200,
                  )),
              title: Text(
                'Resister Prompt',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListTile(
              trailing: IconButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, ViewScreen.id),
                  icon: const Icon(
                    CupertinoIcons.right_chevron,
                    color: white200,
                  )),
              title: Text(
                'View & Search',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: zinc800,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 80, right: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}
