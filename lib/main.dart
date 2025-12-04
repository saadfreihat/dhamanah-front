import 'package:flutter/material.dart';

void main() {
  runApp(const DhamanahApp());
}

// ألوان تقريبية من الهوية (تقدر تعدلها لاحقاً)
const Color kDarkGreen = Color(0xFF05261F); // الخلفية الرئيسية
const Color kButtonGreen = Color(0xFF00C26A); // أزرار خضراء
const Color kBottomBar = Color(0xFF031712);

class DhamanahApp extends StatelessWidget {
  const DhamanahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dhamanah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kDarkGreen,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kButtonGreen,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

//
// 1) Splash Screen (شاشة البداية مع لوجو "ضمانة")
//

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF041B18), Color(0xFF064038)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ضمانة',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'وسيطك الموثوق',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// 2) Welcome + Bottom Navigation مثل أول صورة
//

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // حالياً كل التابات تعرض نفس الـ body (الشاشة الترحيبية)
    // بعدين نعمل لكل Tab شاشة حقيقية
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color(0xFFF3E7D5), // خلفية فاتحة للجزء العلوي
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Placeholder بدل رسمة البيت (نستبدله بصورة لاحقاً)
                      Container(
                        width: 180,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                        child: const Icon(
                          Icons.house_siding_outlined,
                          size: 72,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Welcome to Damanah',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Find the right professional for your home project',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // الجزء الغامق مع الأزرار
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              decoration: const BoxDecoration(
                color: kDarkGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Log in → نروح لشاشة اختيار Client/Contractor
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RoleSelectionScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonGreen,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      // Sign up → أيضاً نرسلها لنفس الشاشة حالياً
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RoleSelectionScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // لاحقاً نغيّر الـ body حسب الـ index
        },
        backgroundColor: kBottomBar,
        selectedItemColor: kButtonGreen,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//
// 3) شاشة اختيار الدور (Client / Contractor) مثل الصورة الثانية
//

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top bar: اسم التطبيق + أيقونة help
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Damanah',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      // لاحقاً: نضيف Dialog يشرح الفكرة
                    },
                    icon: const Icon(Icons.help_outline),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              const Text(
                'Verified Contractors for\nYour Dream Project',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              const Spacer(),

              const Text(
                'Accurate estimates, manage contracts, and track your construction project from start to finish.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ClientHomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kButtonGreen,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue as Client',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ContractorHomeScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue as Contractor',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// 4) Client Home Interface
//

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreen,
      appBar: AppBar(
        backgroundColor: kDarkGreen,
        elevation: 0,
        title: const Text('Dhamanah - Client'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome back 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Manage your home construction projects, estimates, and contracts.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),

            const SizedBox(height: 24),

            // زر بدء مشروع جديد
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const StartNewProjectScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Start New Project',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonGreen,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'My Projects',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // قائمة مشاريع (مؤقتاً بيانات تجريبية)
            Expanded(
              child: ListView(
                children: const [
                  ProjectCard(
                    title: 'Apartment renovation - Amman',
                    status: 'In progress',
                    budget: 'JOD 18,500',
                  ),
                  ProjectCard(
                    title: 'Villa finishing - Irbid',
                    status: 'Waiting for contract',
                    budget: 'JOD 42,000',
                  ),
                  ProjectCard(
                    title: 'Kitchen upgrade - Zarqa',
                    status: 'Completed',
                    budget: 'JOD 7,200',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String status;
  final String budget;

  const ProjectCard({
    super.key,
    required this.title,
    required this.status,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        subtitle: Text(status, style: const TextStyle(color: Colors.white70)),
        trailing: Text(
          budget,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          // لاحقاً: نفتح تفاصيل المشروع
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Open details for "$title"')));
        },
      ),
    );
  }
}

//
// 5) Start New Project Interface (form + تقدير تكلفة بسيط)
//

class StartNewProjectScreen extends StatefulWidget {
  const StartNewProjectScreen({super.key});

  @override
  State<StartNewProjectScreen> createState() => _StartNewProjectScreenState();
}

class _StartNewProjectScreenState extends State<StartNewProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  String projectType = 'Apartment';

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    areaController.dispose();
    super.dispose();
  }

  void _calculateEstimate() {
    final double area = double.tryParse(areaController.text) ?? 0;

    if (area <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid area.')),
      );
      return;
    }

    // أسعار تقريبية بالمتر المربع (بس عشان الديمو)
    double pricePerM2;
    if (projectType == 'Apartment') {
      pricePerM2 = 120; // JOD
    } else if (projectType == 'Villa') {
      pricePerM2 = 200;
    } else {
      pricePerM2 = 150; // Office
    }

    final double cost = area * pricePerM2;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Estimated Cost'),
        content: Text(
          'Approximate budget: JOD ${cost.toStringAsFixed(0)}\n\n'
          'This is a rough estimate based on project type and area.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreen,
      appBar: AppBar(
        backgroundColor: kDarkGreen,
        elevation: 0,
        title: const Text('Start New Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project name',
                hintText: 'e.g. Full apartment renovation',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                hintText: 'e.g. Amman',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: areaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Area (m²)',
                hintText: 'e.g. 150',
              ),
            ),
            const SizedBox(height: 12),
            const Text('Project type', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: projectType,
              items: const [
                DropdownMenuItem(value: 'Apartment', child: Text('Apartment')),
                DropdownMenuItem(value: 'Villa', child: Text('Villa')),
                DropdownMenuItem(value: 'Office', child: Text('Office')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  projectType = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateEstimate,
              style: ElevatedButton.styleFrom(
                backgroundColor: kButtonGreen,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Calculate estimate',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// 6) Contractor Home (Placeholder بسيط لحد ما نصممه)
//

class ContractorHomeScreen extends StatelessWidget {
  const ContractorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreen,
      appBar: AppBar(
        backgroundColor: kDarkGreen,
        elevation: 0,
        title: const Text('Dhamanah - Contractor'),
      ),
      body: const Center(
        child: Text('Contractor Home (قريباً)', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
