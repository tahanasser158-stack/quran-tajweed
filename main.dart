import 'package:flutter/material.dart';

void main() => runApp(const QuranApp());

class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'القرآن الكريم',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B5D4B),
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    HomeTab(),
    MushafTab(),
    ReadersTab(),
    MoreTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: pages[index]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() => index = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'المصحف'),
            NavigationDestination(icon: Icon(Icons.mic_none), selectedIcon: Icon(Icons.mic), label: 'القراء'),
            NavigationDestination(icon: Icon(Icons.grid_view), selectedIcon: Icon(Icons.grid_view_rounded), label: 'المزيد'),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SizedBox(height: 10),
        const Text('القرآن الكريم', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text('نور للقلوب وهداية للناس', style: TextStyle(color: Colors.grey.shade700)),
        const SizedBox(height: 22),
        Card(
          elevation: 0,
          color: const Color(0xFFE8F2EE),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('آخر قراءة', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('سورة البقرة • الآية 1'),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.menu_book),
                  label: const Text('متابعة القراءة'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _Tile(icon: Icons.menu_book, title: 'المصحف', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MushafPage()))),
            _Tile(icon: Icons.palette_outlined, title: 'أحكام التجويد', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TajweedPage()))),
            _Tile(icon: Icons.mic, title: 'القراء', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReadersPage()))),
            _Tile(icon: Icons.search, title: 'البحث', onTap: () {}),
            _Tile(icon: Icons.auto_stories_outlined, title: 'التفسير', onTap: () {}),
            _Tile(icon: Icons.favorite_border, title: 'المفضلة', onTap: () {}),
          ],
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 34, color: const Color(0xFF0B5D4B)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}

class MushafTab extends StatelessWidget {
  const MushafTab({super.key});
  @override
  Widget build(BuildContext context) => const MushafPage();
}

class MushafPage extends StatefulWidget {
  const MushafPage({super.key});
  @override
  State<MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends State<MushafPage> {
  bool tajweed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سورة البقرة'),
        actions: [
          Switch(value: tajweed, onChanged: (v) => setState(() => tajweed = v)),
          IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TajweedPage())), icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('الجزء ١', style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 15),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  const Text('بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ', textAlign: TextAlign.center, style: TextStyle(fontSize: 27, height: 1.8)),
                  const Divider(height: 30),
                  Text.rich(
                    TextSpan(children: [
                      const TextSpan(text: 'الم ۝ ذَٰلِكَ '),
                      TextSpan(text: 'الْكِتَابُ', style: TextStyle(color: tajweed ? Colors.green.shade700 : null)),
                      const TextSpan(text: ' لَا '),
                      TextSpan(text: 'رَيْبَ', style: TextStyle(color: tajweed ? Colors.red.shade600 : null)),
                      const TextSpan(text: ' فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ ۝'),
                    ]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25, height: 2.0),
                  ),
                  const SizedBox(height: 18),
                  if (tajweed)
                    const Align(
                      alignment: Alignment.center,
                      child: Text('الألوان توضيحية في النسخة الأولية — سيتم ربطها بقاعدة أحكام تجويد موثوقة.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReadersTab extends StatelessWidget {
  const ReadersTab({super.key});
  @override
  Widget build(BuildContext context) => const ReadersPage();
}

class ReadersPage extends StatefulWidget {
  const ReadersPage({super.key});
  @override
  State<ReadersPage> createState() => _ReadersPageState();
}

class _ReadersPageState extends State<ReadersPage> {
  final names = [
    'الشيخ عبدالباسط عبدالصمد',
    'الشيخ محمود خليل الحصري',
    'الشيخ محمد صديق المنشاوي',
    'الشيخ مصطفى إسماعيل',
    'الشيخ محمود علي البنا',
    'الشيخ محمد متولي الشعراوي',
    'الشيخ ماهر المعيقلي',
    'الشيخ عبد الرحمن السديس',
    'الشيخ سعود الشريم',
    'الشيخ ياسر الدوسري',
    'الشيخ فارس عباد',
    'الشيخ سعد الغامدي',
  ];
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = names.where((n) => n.contains(query)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('القراء')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'ابحث عن قارئ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(filtered[i]),
                subtitle: const Text('تلاوات — سيتم ربطها بمصدر صوتي موثوق'),
                trailing: IconButton(icon: const Icon(Icons.play_circle_outline), onPressed: () {}),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TajweedPage extends StatelessWidget {
  const TajweedPage({super.key});

  static const rules = [
    ('المد', Colors.red, 'إطالة الصوت بحروف المد وفق نوع المد ومقداره.'),
    ('القلقلة', Colors.amber, 'اضطراب الصوت عند النطق بحروف القلقلة الساكنة.'),
    ('الإظهار', Colors.green, 'إظهار النون الساكنة أو التنوين عند حروف الإظهار.'),
    ('الإخفاء', Colors.blue, 'النطق بالنون الساكنة أو التنوين بين الإظهار والإدغام.'),
    ('الإدغام', Colors.orange, 'إدخال حرف في حرف وفق أحكام الإدغام.'),
    ('الإقلاب', Colors.purple, 'قلب النون الساكنة أو التنوين ميمًا عند الباء.'),
    ('التفخيم', Colors.teal, 'تغليظ الصوت في مواضعه المقررة.'),
    ('الترقيق', Colors.cyan, 'ترقيق الصوت في الحروف والمواضع المقررة.'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('مفتاح أحكام التجويد')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('اضغط على أي حكم لمعرفة تفاصيله وأمثلته.', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 12),
        ...rules.map((r) => Card(
          elevation: 0,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: r.$2),
            title: Text(r.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(r.$3),
            onTap: () {},
          ),
        )),
      ],
    ),
  );
}

class ReadersPage extends StatelessWidget {
  const ReadersPage({super.key});
  @override
  Widget build(BuildContext context) => const _ReadersList();
}

class _ReadersList extends StatelessWidget {
  const _ReadersList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القراء')),
      body: const Center(child: Text('قائمة القراء متاحة من قسم القراء في الصفحة الرئيسية.')),
    );
  }
}

class MoreTab extends StatelessWidget {
  const MoreTab({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: const [
      ListTile(leading: Icon(Icons.menu_book), title: Text('أحكام التجويد')),
      ListTile(leading: Icon(Icons.auto_stories), title: Text('التفسير')),
      ListTile(leading: Icon(Icons.bookmark_border), title: Text('العلامات المرجعية')),
      ListTile(leading: Icon(Icons.dark_mode_outlined), title: Text('الوضع الليلي')),
      ListTile(leading: Icon(Icons.settings_outlined), title: Text('الإعدادات')),
    ],
  );
}
