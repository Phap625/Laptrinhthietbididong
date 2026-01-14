import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Components Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Define routes for navigation
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
        '/text': (context) => const TextDetailScreen(),
        '/images': (context) => const ImagesScreen(),
        '/textfield': (context) => const TextFieldScreen(),
        '/row': (context) => const RowLayoutScreen(),
      },
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN 1: UI Components List (Menu)
// ---------------------------------------------------------------------------
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Components List', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Display'),
            _buildMenuItem(context, 'Text', 'Displays text', '/text'),
            _buildMenuItem(context, 'Image', 'Displays an image', '/images'),

            const SizedBox(height: 16),
            _buildSectionHeader('Input'),
            _buildMenuItem(context, 'TextField', 'Input field for text', '/textfield'),
            _buildMenuItem(context, 'PasswordField', 'Input field for passwords', '/textfield'), // Pointing to same for demo

            const SizedBox(height: 16),
            _buildSectionHeader('Layout'),
            _buildMenuItem(context, 'Column', 'Arranges elements vertically', '/row'), // Pointing to Row screen for demo purposes
            _buildMenuItem(context, 'Row', 'Arranges elements horizontally', '/row'),

            const SizedBox(height: 16),
            // The special red item at the bottom
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tự tìm hiểu', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Tìm ra tất cả các thành phần UI Cơ bản'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String subtitle, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN 2: Text Detail
// ---------------------------------------------------------------------------
class TextDetailScreen extends StatelessWidget {
  const TextDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.blue),
        title: const Text('Text Detail', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            textAlign: TextAlign.start,
            text: const TextSpan(
              style: TextStyle(fontSize: 24, color: Colors.black),
              children: [
                TextSpan(text: 'The quick '),
                TextSpan(
                  text: 'Brown',
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '\nfox '),
                TextSpan(
                  text: 'j u m p s',
                  style: TextStyle(fontSize: 20, letterSpacing: 2),
                ),
                TextSpan(
                  text: ' over',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '\nthe ', style: TextStyle(decoration: TextDecoration.underline)),
                TextSpan(
                  text: 'lazy dog.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN 3: Images
// ---------------------------------------------------------------------------
class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.blue),
        title: const Text('Images', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Network Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://xdcs.cdnchinhphu.vn/446259493575335936/2023/8/23/giao-thong-van-tai-9096-16927730679551867829733.jpeg', // Placeholder food/building image
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(height: 200, color: Colors.grey[300], child: const Center(child: Text('Image Error'))),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'https://xdcs.cdnchinhphu.vn/446259493575335936/2023/8/23/giao-thong-van-tai-9096-16927730679551867829733.jpeg',
                style: TextStyle(fontSize: 10, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Asset Image (using a placeholder container here since I don't have your assets)
              // To use real assets: Image.asset('assets/my_image.png')
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.network(
                    'https://tse3.mm.bing.net/th/id/OIP.Bn2vwh5SF0Lv4PddP3s-YAHaEd?pid=Api&P=0&h=180', // Placeholder building
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('in app'),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN 4: TextField
// ---------------------------------------------------------------------------
class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = "Tự động cập nhật dữ liệu theo textfield";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        // If empty, show default text, else show input
        _displayText = _controller.text.isEmpty
            ? "Tự động cập nhật dữ liệu theo textfield"
            : _controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.blue),
        title: const Text('TextField', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Thông tin nhập',
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _displayText,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SCREEN 5: Row Layout
// ---------------------------------------------------------------------------
class RowLayoutScreen extends StatelessWidget {
  const RowLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper to build the blue boxes
    Widget buildBox(Color color) {
      return Container(
        width: 80, // Adjust width based on screen size or use Expanded
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.blue),
        title: const Text('Row Layout', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBox(Colors.blue[200]!),
                buildBox(Colors.blue[600]!),
                buildBox(Colors.blue[200]!),
              ],
            ),
            const SizedBox(height: 16),
            // Row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBox(Colors.blue[200]!),
                buildBox(Colors.blue[600]!),
                buildBox(Colors.blue[200]!),
              ],
            ),
            const SizedBox(height: 16),
            // Row 3
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBox(Colors.blue[200]!),
                buildBox(Colors.blue[600]!),
                buildBox(Colors.blue[200]!),
              ],
            ),
            const SizedBox(height: 16),
            // Row 4
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBox(Colors.blue[200]!),
                buildBox(Colors.blue[600]!),
                buildBox(Colors.blue[200]!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
