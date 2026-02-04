import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(length: 4, child: _TabsNonScrollableDemo()),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;
  final RestorableInt tabIndex = RestorableInt(0);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Bottom App Bar - MAD Class",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            color: Colors.lightBlue[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to Tab 1",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Alert Dialog"),
                          content: Text("This is an alert dialog in Tab 1."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Close"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text("Show Alert Dialog"),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 25),

                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Enter Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: Colors.orange[100],
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Button pressed in ${tabs[2]} tab!"),
                    ),
                  );
                },
                child: Text("Click me"),
              ),
            ),
          ),

          Container(
            color: Colors.purple[100],
            child: ListView(
              padding: EdgeInsets.all(12),
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text("Item 1"),
                    subtitle: Text("This item is inside a Card widget."),
                    leading: Icon(Icons.star),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text("Item 2"),
                    subtitle: Text("This item is inside a Card widget."),
                    leading: Icon(Icons.star),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text("Item 3"),
                    subtitle: Text("Card widget used for list display."),
                    leading: Icon(Icons.star),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
