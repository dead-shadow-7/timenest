import 'package:flutter/material.dart';
import 'package:timenest/presentation/screens/addTask.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int count = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom colors
    const backgroundColor = Color.fromARGB(
      255,
      237,
      232,
      220,
    ); // Beige/cream background
    const accentColor = Color.fromARGB(
      255,
      177,
      127,
      89,
    ); // Brown/copper accent color
    const textColor = Color.fromARGB(255, 67, 74, 67); // Dark text color

    // Task category colors
    const doItNowColor = Color.fromARGB(255, 255, 138, 138); // Coral/pink
    const decideWhenColor = Color.fromARGB(255, 129, 191, 218); // Light blue
    const delegateItColor = Color.fromARGB(255, 85, 173, 155); // Teal/green
    const dumpItColor = Color.fromARGB(255, 197, 153, 182); // Light purple

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('', style: TextStyle(color: textColor, fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.wb_sunny_outlined, color: accentColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: accentColor),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: accentColor),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'GOOD\nAFTERNOON!',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: accentColor,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: textColor, thickness: 1),
            const SizedBox(height: 15),
            const Text(
              'Tasks',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Do it now - Urgent and important
                  _buildTaskCard(
                    title: 'Do it now',
                    subtitle: 'Urgent and important',
                    count: '0',
                    color: doItNowColor,
                  ),
                  const SizedBox(height: 16),

                  // Decide when to Do - Important not Urgent
                  _buildTaskCard(
                    title: 'Decide when to Do',
                    subtitle: 'Important not Urgent',
                    count: '0',
                    color: decideWhenColor,
                  ),
                  const SizedBox(height: 16),

                  // Delegate It - Urgent not Important
                  _buildTaskCard(
                    title: 'Delegate It',
                    subtitle: 'Urgent not Important',
                    count: '0',
                    color: delegateItColor,
                  ),
                  const SizedBox(height: 16),

                  // Dump It - Not urgent Not important
                  _buildTaskCard(
                    title: 'Dump It',
                    subtitle: 'Not urgent Not important',
                    count: '0',
                    color: dumpItColor,
                  ),
                  const SizedBox(height: 70), // Space for FAB
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(32), // Half of height/width
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        child: Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: accentColor,
            shape: BoxShape.circle,
            border: Border.all(color: backgroundColor, width: 4),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: accentColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home icon
              IconButton(
                icon: Icon(
                  Icons.home_outlined,
                  color: _selectedIndex == 0 ? Colors.white : Colors.white70,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
              // Grid/Dashboard icon
              IconButton(
                icon: Icon(
                  Icons.grid_view,
                  color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                  size: 28,
                ),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // Space for FAB
              // Calendar icon
              IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: _selectedIndex == 2 ? Colors.white : Colors.white70,
                  size: 28,
                ),
                onPressed: () => _onItemTapped(2),
              ),
              // Settings icon
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: _selectedIndex == 3 ? Colors.white : Colors.white70,
                  size: 28,
                ),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String subtitle,
    required String count,
    required Color color,
  }) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(54, 0, 0, 0),
            blurRadius: 8,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
