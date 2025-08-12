import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  static const Color bg = Color(0xFF0D0824);
  static const Color card = Color(0xFF1C1539);
  static const Color accent = Color(0xFF8C6CFF);
  static const Color subtle = Color(0xFFB6A8D9);

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 450))
      ..forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.data();
  }

  String _iconFor(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball':
        return 'assets/basketball.png';
      case 'soccer':
        return 'assets/ball.png';
      case 'volleyball':
        return 'assets/volleyball.png';
      default:
        return 'assets/basketball.png';
    }
  }

  Color _levelColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return const Color(0xFF30D158);
      case 'intermediate':
        return const Color(0xFFFFD60A);
      case 'advanced':
        return const Color(0xFFFF375F);
      default:
        return subtle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () async {
              final updated = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
              if (updated == true) setState(() {});
            },
            child: const Text('Edit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getUserData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: accent));
          }
          if (!snap.hasData || snap.data == null) {
            return const Center(child: Text('No data found', style: TextStyle(color: Colors.white)));
          }

          final data = snap.data!;
          final name = (data['username'] ?? 'User').toString();
          final city = (data['city'] ?? '').toString();
          final level = (data['level'] ?? '').toString(); // Beginner/Intermediate/Advanced
          final bio = (data['bio'] ?? '').toString();     // optional
          final photoUrl = data['profilePicUrl'];
          final games = data['games'] ?? 0;
          final mvps = data['mvps'] ?? 0;

          final sportsMap = Map<String, dynamic>.from(data['sports'] ?? {});
          final sports = sportsMap.entries
              .map((e) => {'sport': e.key, 'position': e.value.toString()})
              .toList();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Avatar, Name + Level badge, City
                ScaleTransition(
                  scale: CurvedAnimation(parent: _anim, curve: Curves.easeOutBack),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: card,
                        backgroundImage: photoUrl != null
                            ? NetworkImage(photoUrl)
                            : const AssetImage('assets/default_avatar.png') as ImageProvider,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (level.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _levelColor(level).withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: _levelColor(level).withValues(alpha: 0.7), width: 1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(width: 6, height: 6,
                                      decoration: BoxDecoration(
                                        color: _levelColor(level),
                                        shape: BoxShape.circle,
                                      )),
                                  const SizedBox(width: 6),
                                  Text(
                                    level,
                                    style: TextStyle(
                                      color: _levelColor(level),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (city.isNotEmpty)
                        Text(city, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _statCard('Games', games.toString()),
                    _statCard('MVPs', mvps.toString()),
                  ],
                ),

                const SizedBox(height: 24),

                // Bio (About)
                if (bio.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('About',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16)),
                    child: Text(bio, style: const TextStyle(color: Colors.white70, height: 1.35)),
                  ),
                  const SizedBox(height: 24),
                ],

                // Sports strip (always scroll)
                if (sports.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sports & Positions',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  const SizedBox(height: 10),
                  _SportsStrip(items: sports, iconFor: _iconFor),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _statCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
      decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}

class _SportsStrip extends StatelessWidget {
  const _SportsStrip({required this.items, required this.iconFor});

  final List<Map<String, String>> items; // {'sport':..., 'position':...}
  final String Function(String) iconFor;

  static const Color card = Color(0xFF1C1539);
  static const double _baseHeight = 120;
  static const double _icon = 34;
  static const double _spacing = 10.0;
  static const int _targetPerRow = 3;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.textScalerOf(context).scale(1.0);
    final double tileH = (_baseHeight + (scale - 1.0) * 24.0).clamp(_baseHeight, _baseHeight + 36);

    return LayoutBuilder(builder: (ctx, c) {
      final cardWidth =
          ((c.maxWidth - _spacing * (_targetPerRow - 1)) / _targetPerRow).floorToDouble();

      return SizedBox(
        height: tileH,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(width: _spacing),
          itemBuilder: (context, i) => SizedBox(
            width: cardWidth,
            child: _sportCard(items[i], tileH),
          ),
        ),
      );
    });
  }

  Widget _sportCard(Map<String, String> item, double tileH) {
    final sport = item['sport']!;
    final pos = item['position']!;
    final iconPath = iconFor(sport);

    return Container(
      height: tileH,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: _icon, height: _icon),
          const SizedBox(height: 6),
          Text(sport, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text(pos, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
