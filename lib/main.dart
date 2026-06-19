// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            NavbarSection(),
            HeroSection(),
            FeaturesSection(),
            GamesSection(),
            TestimonialsSection(),
            CTASection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}

// ============ NAVBAR SECTION ============
class NavbarSection extends StatefulWidget {
  const NavbarSection({super.key});

  @override
  State<NavbarSection> createState() => _NavbarSectionState();
}

class _NavbarSectionState extends State<NavbarSection> {
  bool isMobileMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E).withOpacity(0.9),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF6C63FF).withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.games,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'BlackCatGame',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          // Desktop Menu
          if (!isMobile)
            Row(
              children: [
                _buildNavItem('Home', true),
                _buildNavItem('Features', false),
                _buildNavItem('Games', false),
                _buildNavItem('Testimonials', false),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),

          // Mobile Menu Button
          if (isMobile)
            IconButton(
              icon: Icon(
                isMobileMenuOpen ? Icons.close : Icons.menu,
                color: Colors.white,
                size: 30,
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

  Widget _buildNavItem(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? const Color(0xFF6C63FF) : Colors.white70,
          fontSize: 16,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xFFFFD700),
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '⭐ 4.9/5 Rating',
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Learn While Playing with',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'BlackCatGame',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Educational Games',
                  style: TextStyle(
                    color: Color(0xFF6C63FF),
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Interactive educational games that make learning fun!\n'
                  'Master math, science, and languages through play.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
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
                        elevation: 8,
                        shadowColor: const Color(0xFF6C63FF).withOpacity(0.4),
                      ),
                      child: const Text(
                        'Start Learning Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
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
                      child: const Text(
                        'Watch Demo',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Stats
                Row(
                  children: [
                    _buildStat('10K+', 'Active Students'),
                    _buildDivider(),
                    _buildStat('50+', 'Educational Games'),
                    _buildDivider(),
                    _buildStat('98%', 'Satisfaction Rate'),
                  ],
                ),
              ],
            ),
          ),
         // Hero Image
// Hero Image
Expanded(
  child: Container(
    height: 400,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: const DecorationImage(
        image: AssetImage('assets/images/hero_image.png'), // Ganti dengan path gambar Anda
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.catching_pokemon,
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '🎮 Play & Learn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Interactive Educational Games',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 30),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: const Color(0xFF1A1A2E),
      child: Column(
        children: [
          const Text(
            'Why Choose BlackCatGame?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Making education fun and effective for every student',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              childAspectRatio: 1.1,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return _buildFeatureCard(feature);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6C63FF).withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (feature['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              feature['icon'] as IconData,
              color: feature['color'] as Color,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            feature['title'] as String,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            feature['description'] as String,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
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
      'description': 'Solve math puzzles and defeat the dragon!',
    },
    {
      'title': 'Word Wizard',
      'category': 'Language',
      'age': '8-12 years',
      'color': Color(0xFFFF6584),
      'emoji': '📚',
      'description': 'Build vocabulary through fun word games',
    },
    {
      'title': 'Science Lab',
      'category': 'Science',
      'age': '9-14 years',
      'color': Color(0xFF4ECDC4),
      'emoji': '🔬',
      'description': 'Conduct virtual science experiments',
    },
    {
      'title': 'Code Academy',
      'category': 'Programming',
      'age': '10-16 years',
      'color': Color(0xFFFFD700),
      'emoji': '💻',
      'description': 'Learn programming through interactive games',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: Column(
        children: [
          const Text(
            'Our Educational Games',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Fun and interactive games for all ages and subjects',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return _buildGameCard(game);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (game['color'] as Color).withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              game['emoji'] as String,
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 12),
            Text(
              game['title'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: (game['color'] as Color).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                game['category'] as String,
                style: TextStyle(
                  color: game['color'] as Color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              game['description'] as String,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Age: ${game['age']}',
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
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
      'role': 'Mother of 2',
      'text': 'BlackCatGame transformed my children\'s attitude towards learning. They actually ask to play educational games now!',
      'rating': 5,
      'avatar': '👩',
    },
    {
      'name': 'Mr. Alex',
      'role': 'Elementary Teacher',
      'text': 'I\'ve seen remarkable improvement in my students\' math skills since we started using BlackCatGame in class.',
      'rating': 5,
      'avatar': '👨',
    },
    {
      'name': 'Emma Chen',
      'role': 'Student, Age 10',
      'text': 'The games are so much fun! I\'ve learned coding and I didn\'t even realize I was learning!',
      'rating': 5,
      'avatar': '🧒',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: const Color(0xFF1A1A2E),
      child: Column(
        children: [
          const Text(
            'What People Say',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Hear from our happy users',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            children: testimonials.map((testimonial) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A3E),
                    borderRadius: BorderRadius.circular(16),
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
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                testimonial['avatar'] as String,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                testimonial['name'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                testimonial['role'] as String,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Color(0xFFFFD700),
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        testimonial['text'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Container(
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.2),
              const Color(0xFFFF6584).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF6C63FF).withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Ready to Start Learning?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Join thousands of students who are learning through play',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFF6C63FF).withOpacity(0.4),
                  ),
                  child: const Text(
                    'Get Started Free',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 18,
                    ),
                    side: const BorderSide(color: Colors.white30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Learn More',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '🎮 No credit card required • Free forever • 100% safe',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 14,
              ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      color: const Color(0xFF0A0A14),
      child: Column(
        children: [
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
                      const SizedBox(width: 10),
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
          const SizedBox(height: 30),
          const Divider(color: Colors.white12),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '© 2026 BlackCatGame. All rights reserved.',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 13,
                ),
              ),
              Row(
                children: [
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white60,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: Colors.white60,
        size: 18,
      ),
    );
  }
}