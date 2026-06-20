// main.dart - Fully Responsive Mobile & Desktop
import 'package:flutter/material.dart';

void main() {
  runApp(const BlackCatGameApp());
}

class BlackCatGameApp extends StatelessWidget {
  const BlackCatGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlackCatGame - Educational Games',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A1A2E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          primary: const Color(0xFF6C63FF),
          secondary: const Color(0xFFFF6584),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}

// ============ LANDING PAGE ============
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _gamesKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: Column(
        children: [
          NavbarSection(
            scrollToFeatures: () => _scrollToSection(_featuresKey),
            scrollToGames: () => _scrollToSection(_gamesKey),
            scrollToTestimonials: () => _scrollToSection(_testimonialsKey),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const HeroSection(),
                  FeaturesSection(key: _featuresKey),
                  GamesSection(key: _gamesKey),
                  TestimonialsSection(key: _testimonialsKey),
                  const CTASection(),
                  const FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============ NAVBAR SECTION ============
class NavbarSection extends StatefulWidget {
  final VoidCallback scrollToFeatures;
  final VoidCallback scrollToGames;
  final VoidCallback scrollToTestimonials;

  const NavbarSection({
    super.key,
    required this.scrollToFeatures,
    required this.scrollToGames,
    required this.scrollToTestimonials,
  });

  @override
  State<NavbarSection> createState() => _NavbarSectionState();
}

class _NavbarSectionState extends State<NavbarSection> {
  bool isMobileMenuOpen = false;
  int _selectedIndex = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollController = _findScrollController(context);
      if (scrollController != null) {
        scrollController.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    final scrollController = _findScrollController(context);
    if (scrollController != null) {
      scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  ScrollController? _findScrollController(BuildContext context) {
    final landingPage = context.findAncestorStateOfType<_LandingPageState>();
    if (landingPage != null) {
      return landingPage._scrollController;
    }
    return null;
  }

  void _onScroll() {
    final scrollController = _findScrollController(context);
    if (scrollController != null) {
      final scrolled = scrollController.offset > 20;
      if (scrolled != _isScrolled) {
        setState(() {
          _isScrolled = scrolled;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 40,
        vertical: isMobile ? 10 : 16,
      ),
      decoration: BoxDecoration(
        color: _isScrolled
            ? const Color(0xFF1A1A2E)
            : const Color(0xFF1A1A2E).withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF6C63FF).withOpacity(0.2),
          ),
        ),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: isMobile ? 32 : 40,
                  height: isMobile ? 32 : 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.games,
                    color: Colors.white,
                    size: isMobile ? 18 : 24,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'BlackCatGame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Desktop Menu
          if (!isMobile)
            Row(
              children: [
                _buildNavItem('Home', 0, () {
                  setState(() => _selectedIndex = 0);
                }),
                _buildNavItem('Features', 1, () {
                  setState(() => _selectedIndex = 1);
                  widget.scrollToFeatures();
                }),
                _buildNavItem('Games', 2, () {
                  setState(() => _selectedIndex = 2);
                  widget.scrollToGames();
                }),
                _buildNavItem('Testimonials', 3, () {
                  setState(() => _selectedIndex = 3);
                  widget.scrollToTestimonials();
                }),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

          // Mobile Menu Button
          if (isMobile)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                isMobileMenuOpen ? Icons.close : Icons.menu,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  isMobileMenuOpen = !isMobileMenuOpen;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index, VoidCallback onTap) {
    final isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive ? const Color(0xFF6C63FF) : Colors.white70,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 2),
                height: 2,
                width: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============ HERO SECTION ============
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 24 : 80,
      ),
      child: Column(
        children: [
          // Hero Image - Mobile di atas
          Container(
            width: double.infinity,
            height: isMobile ? 180 : 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C63FF).withOpacity(0.4),
                  const Color(0xFFFF6584).withOpacity(0.4),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: isMobile ? 60 : 120,
                    height: isMobile ? 60 : 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(isMobile ? 30 : 60),
                    ),
                    child: Icon(
                      Icons.catching_pokemon,
                      color: Colors.white,
                      size: isMobile ? 30 : 60,
                    ),
                  ),
                  SizedBox(height: isMobile ? 8 : 20),
                  Text(
                    '🎮 Play & Learn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 16 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isMobile ? 2 : 8),
                  Text(
                    'Interactive Educational Games',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isMobile ? 11 : 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: isMobile ? 20 : 40),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFD700),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '⭐ 4.9/5 Rating',
                      style: TextStyle(
                        color: const Color(0xFF6C63FF),
                        fontSize: isMobile ? 10 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 12 : 30),

              // Title
              Text(
                'Learn While Playing with',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: isMobile ? 12 : 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: isMobile ? 2 : 4),
              Text(
                'BlackCatGame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 28 : 56,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Text(
                'Educational Games',
                style: TextStyle(
                  color: const Color(0xFF6C63FF),
                  fontSize: isMobile ? 28 : 56,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              SizedBox(height: isMobile ? 8 : 16),

              // Description
              Text(
                isMobile
                    ? 'Interactive educational games that make learning fun! Master math, science, and languages through play.'
                    : 'Interactive educational games that make learning fun!\nMaster math, science, and languages through play.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: isMobile ? 13 : 18,
                  height: 1.6,
                ),
              ),
              SizedBox(height: isMobile ? 16 : 24),

              // Buttons
              if (!isMobile)
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Start Learning Now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        side: const BorderSide(color: Colors.white30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Watch Demo'),
                    ),
                  ],
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Start Learning',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              SizedBox(height: isMobile ? 20 : 40),

              // Stats
              Wrap(
                spacing: isMobile ? 8 : 30,
                runSpacing: isMobile ? 8 : 10,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  _buildStat('10K+', 'Active Students', isMobile),
                  _buildDivider(isMobile),
                  _buildStat('50+', 'Educational Games', isMobile),
                  _buildDivider(isMobile),
                  _buildStat('98%', 'Satisfaction Rate', isMobile),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label, bool isMobile) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 18 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white60,
            fontSize: isMobile ? 10 : 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isMobile) {
    return Container(
      width: 1,
      height: isMobile ? 30 : 50,
      color: Colors.white24,
    );
  }
}

// ============ FEATURES SECTION ============
class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  final List<Map<String, dynamic>> features = const [
    {
      'icon': Icons.school,
      'title': 'Curriculum Based',
      'description': 'Aligned with school curricula for effective learning',
      'color': Color(0xFF6C63FF),
    },
    {
      'icon': Icons.psychology,
      'title': 'Adaptive Learning',
      'description': 'Personalized difficulty based on student progress',
      'color': Color(0xFFFF6584),
    },
    {
      'icon': Icons.star,
      'title': 'Reward System',
      'description': 'Earn stars and badges to stay motivated',
      'color': Color(0xFFFFD700),
    },
    {
      'icon': Icons.people,
      'title': 'Multiplayer Mode',
      'description': 'Learn and compete with friends online',
      'color': Color(0xFF4ECDC4),
    },
    {
      'icon': Icons.analytics,
      'title': 'Progress Tracking',
      'description': 'Detailed reports for parents and teachers',
      'color': Color(0xFFFF6B6B),
    },
    {
      'icon': Icons.devices,
      'title': 'Cross-Platform',
      'description': 'Play on any device - mobile, tablet, or desktop',
      'color': Color(0xFFA8E6CF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final crossAxisCount = isMobile ? 1 : (MediaQuery.of(context).size.width < 1024 ? 2 : 3);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 30 : 60,
      ),
      color: const Color(0xFF1A1A2E),
      child: Column(
        children: [
          Text(
            'Why Choose BlackCatGame?',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 22 : 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 4 : 12),
          Text(
            'Making education fun and effective for every student',
            style: TextStyle(
              color: Colors.white60,
              fontSize: isMobile ? 13 : 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 24 : 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: isMobile ? 12 : 30,
              crossAxisSpacing: isMobile ? 12 : 30,
              childAspectRatio: isMobile ? 1.3 : 1.1,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return _buildFeatureCard(feature, isMobile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 40 : 60,
            height: isMobile ? 40 : 60,
            decoration: BoxDecoration(
              color: (feature['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              feature['icon'] as IconData,
              color: feature['color'] as Color,
              size: isMobile ? 20 : 30,
            ),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  feature['description'] as String,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: isMobile ? 11 : 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============ GAMES SECTION ============
class GamesSection extends StatelessWidget {
  const GamesSection({super.key});

  final List<Map<String, dynamic>> games = const [
    {
      'title': 'Math Quest',
      'category': 'Mathematics',
      'age': '6-10 years',
      'color': Color(0xFF6C63FF),
      'emoji': '🧮',
      'description': 'Solve math puzzles',
    },
    {
      'title': 'Word Wizard',
      'category': 'Language',
      'age': '8-12 years',
      'color': Color(0xFFFF6584),
      'emoji': '📚',
      'description': 'Build vocabulary',
    },
    {
      'title': 'Science Lab',
      'category': 'Science',
      'age': '9-14 years',
      'color': Color(0xFF4ECDC4),
      'emoji': '🔬',
      'description': 'Virtual experiments',
    },
    {
      'title': 'Code Academy',
      'category': 'Programming',
      'age': '10-16 years',
      'color': Color(0xFFFFD700),
      'emoji': '💻',
      'description': 'Learn programming',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final crossAxisCount = isMobile ? 2 : (MediaQuery.of(context).size.width < 1024 ? 2 : 4);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 30 : 60,
      ),
      child: Column(
        children: [
          Text(
            'Our Educational Games',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 22 : 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 4 : 12),
          Text(
            'Fun and interactive games for all ages and subjects',
            style: TextStyle(
              color: Colors.white60,
              fontSize: isMobile ? 13 : 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 20 : 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: isMobile ? 10 : 20,
              crossAxisSpacing: isMobile ? 10 : 20,
              childAspectRatio: isMobile ? 0.85 : 0.85,
            ),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return _buildGameCard(game, isMobile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            (game['color'] as Color).withOpacity(0.3),
            const Color(0xFF1A1A2E),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: (game['color'] as Color).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 10 : 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              game['emoji'] as String,
              style: TextStyle(fontSize: isMobile ? 30 : 50),
            ),
            SizedBox(height: isMobile ? 4 : 12),
            Text(
              game['title'] as String,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 13 : 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isMobile ? 2 : 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: (game['color'] as Color).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                game['category'] as String,
                style: TextStyle(
                  color: game['color'] as Color,
                  fontSize: isMobile ? 8 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: isMobile ? 4 : 8),
            Text(
              game['description'] as String,
              style: TextStyle(
                color: Colors.white60,
                fontSize: isMobile ? 10 : 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: isMobile ? 4 : 12),
            Text(
              'Age: ${game['age']}',
              style: TextStyle(
                color: Colors.white38,
                fontSize: isMobile ? 8 : 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ TESTIMONIALS SECTION ============
class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  final List<Map<String, dynamic>> testimonials = const [
    {
      'name': 'Kins',
      'role': 'Mother',
      'text': 'BlackCatGame transformed my children\'s attitude towards learning. They actually ask to play educational games now!',
      'rating': 5,
      'avatar': '👩',
    },
    {
      'name': 'Mr. Alex',
      'role': 'Teacher',
      'text': 'I\'ve seen remarkable improvement in my students\' math skills since we started using BlackCatGame.',
      'rating': 5,
      'avatar': '👨',
    },
    {
      'name': 'Emma Chen',
      'role': 'Student',
      'text': 'The games are so much fun! I\'ve learned coding and didn\'t even realize I was learning!',
      'rating': 5,
      'avatar': '🧒',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 30 : 60,
      ),
      color: const Color(0xFF1A1A2E),
      child: Column(
        children: [
          Text(
            'What People Say',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 22 : 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 4 : 12),
          Text(
            'Hear from our happy users',
            style: TextStyle(
              color: Colors.white60,
              fontSize: isMobile ? 13 : 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 20 : 50),
          if (isMobile)
            Column(
              children: testimonials.map((testimonial) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildTestimonialCard(testimonial, isMobile),
                );
              }).toList(),
            )
          else
            Row(
              children: testimonials.map((testimonial) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildTestimonialCard(testimonial, isMobile),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, dynamic> testimonial, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isMobile ? 32 : 50,
                height: isMobile ? 32 : 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(isMobile ? 16 : 25),
                ),
                child: Center(
                  child: Text(
                    testimonial['avatar'] as String,
                    style: TextStyle(fontSize: isMobile ? 16 : 24),
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial['name'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 13 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    testimonial['role'] as String,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: isMobile ? 10 : 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 16),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: const Color(0xFFFFD700),
                size: isMobile ? 12 : 18,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 6 : 12),
          Text(
            testimonial['text'] as String,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 12 : 15,
              height: 1.5,
            ),
            maxLines: isMobile ? 3 : 6,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ============ CTA SECTION ============
class CTASection extends StatelessWidget {
  const CTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 30 : 80,
      ),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 20 : 60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.2),
              const Color(0xFFFF6584).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF6C63FF).withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Ready to Start Learning?',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 22 : 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 8 : 12),
            Text(
              'Join thousands of students who are learning through play',
              style: TextStyle(
                color: Colors.white60,
                fontSize: isMobile ? 13 : 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 16 : 36),
            SizedBox(
              width: isMobile ? double.infinity : null,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 48,
                    vertical: isMobile ? 14 : 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  isMobile ? 'Get Started' : 'Get Started Free',
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: isMobile ? 12 : 24),
            Text(
              '🎮 No credit card required • Free forever • 100% safe',
              style: TextStyle(
                color: Colors.white38,
                fontSize: isMobile ? 10 : 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ============ FOOTER SECTION ============
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 20 : 40,
      ),
      color: const Color(0xFF0A0A14),
      child: Column(
        children: [
          if (isMobile) ...[
            // Mobile Footer
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.games,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'BlackCatGame',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Making education fun for everyone',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildFooterLink('About'),
                    _buildFooterLink('Privacy'),
                    _buildFooterLink('Terms'),
                    _buildFooterLink('Contact'),
                  ],
                ),
              ],
            ),
          ] else ...[
            // Desktop Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.games,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'BlackCatGame',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Making education fun for everyone',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildFooterLink('About'),
                    _buildFooterLink('Privacy'),
                    _buildFooterLink('Terms'),
                    _buildFooterLink('Contact'),
                  ],
                ),
              ],
            ),
          ],
          SizedBox(height: isMobile ? 16 : 20),
          Divider(color: Colors.white12),
          SizedBox(height: isMobile ? 12 : 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2026 BlackCatGame',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: isMobile ? 10 : 13,
                ),
              ),
              if (!isMobile)
                Row(
                  children: [
                    _buildSocialIcon(Icons.facebook),
                    _buildSocialIcon(Icons.facebook),
                    _buildSocialIcon(Icons.facebook),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white60,
        fontSize: 12,
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        color: Colors.white60,
        size: 14,
      ),
    );
  }
}