
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Autofill controllers
  final _usernameCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();

  String _level = ''; // Beginner / Intermediate / Advanced
  int _games = 0;
  int _mvps = 0;
  Map<String, String> _sports = {}; // {sportName: position}

  // If you add Storage later, you can track a picked file here.
  //File? _newImageFile; 
  String? _photoUrl;

  bool _isLoading = false;

  // THEME
  static const Color bg = Color(0xFF0D0824);
  static const Color card = Color(0xFF1C1539);
  static const Color accent = Color(0xFF8C6CFF);
  static const Color subtle = Color(0xFFB6A8D9);

  // Supported sports + positions
  static const List<String> kSports = ['Basketball', 'Soccer', 'Volleyball'];
  static const Map<String, List<String>> kPositions = {
    'Basketball': ['Point Guard','Shooting Guard','Small Forward','Power Forward','Center'],
    'Soccer': ['Goalkeeper','Defender','Midfielder','Winger','Striker'],
    'Volleyball': ['Setter','Outside Hitter','Opposite','Middle Blocker','Libero'],
  };

  static String iconFor(String sport) {
    switch (sport.toLowerCase()) {
      case 'basketball': return 'assets/basketball.png';
      case 'soccer': return 'assets/ball.png';
      case 'volleyball': return 'assets/volleyball.png';
      default: return 'assets/basketball.png';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _cityCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data();
    if (data != null) {
      setState(() {
        _usernameCtrl.text = (data['username'] ?? '').toString();
        _cityCtrl.text = (data['city'] ?? '').toString();
        _bioCtrl.text = (data['bio'] ?? '').toString();
        _level = (data['level'] ?? '').toString();
        _games = data['games'] ?? 0;
        _mvps = data['mvps'] ?? 0;
        _photoUrl = data['profilePicUrl'];
        _sports = Map<String, String>.from(data['sports'] ?? {});
      });
    }
  }

  // Save profile text fields (name, city, level, bio, games, mvps)
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameCtrl.text.trim();
    final city = _cityCtrl.text.trim();
    final bio = _bioCtrl.text.trim();

    setState(() => _isLoading = true);
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

      final payload = {
        'username': username,
        'city': city,
        'bio': bio,
        'level': _level.isEmpty ? 'Intermediate' : _level,
        'games': _games,
        'mvps': _mvps,
        // keep current photo URL (we'll wire uploads later)
        'profilePicUrl': _photoUrl,
        // keep current sports untouched here
        'sports': _sports,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      try {
        await docRef.update(payload);
      } on FirebaseException catch (e) {
        if (e.code == 'not-found') {
          await docRef.set({
            ...payload,
            'createdAt': FieldValue.serverTimestamp(),
            'email': FirebaseAuth.instance.currentUser!.email,
          });
        } else {
          rethrow;
        }
      }

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Sports-only persist (call this if you edit sports here)
  Future<void> _persistSports() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      await docRef.update({'sports': _sports, 'updatedAt': FieldValue.serverTimestamp()});
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        await docRef.set(
          {'sports': _sports, 'updatedAt': FieldValue.serverTimestamp()},
          SetOptions(merge: true),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> _openSportPicker({String? editingSport}) async {
    final already = _sports.keys.toSet();
    final available = kSports.where((s) => editingSport == s || !already.contains(s)).toList();
    if (available.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All supported sports are already added.")),
        );
      }
      return;
    }

    String selectedSport = editingSport ?? available.first;
    String selectedPosition = _sports[editingSport] ?? (kPositions[selectedSport]!.first);

    await showModalBottomSheet(
      context: context,
      backgroundColor: card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocalState) => Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedSport,
                dropdownColor: card,
                decoration: _dropdownDecoration('Sport'),
                iconEnabledColor: Colors.white,
                items: available
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s, style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val == null) return;
                  setLocalState(() {
                    selectedSport = val;
                    selectedPosition = kPositions[selectedSport]!.first;
                  });
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedPosition,
                dropdownColor: card,
                decoration: _dropdownDecoration('Position'),
                iconEnabledColor: Colors.white,
                items: kPositions[selectedSport]!
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p, style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (val) => setLocalState(() => selectedPosition = val ?? selectedPosition),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    setState(() {
                      if (editingSport != null && editingSport != selectedSport) {
                        _sports.remove(editingSport);
                      }
                      _sports[selectedSport] = selectedPosition;
                    });
                    Navigator.pop(ctx);
                    await _persistSports();
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteSport(String sport) async {
    setState(() => _sports.remove(sport));
    await _persistSports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: accent))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // (Optional) Avatar tap target kept for future photo upload
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: card,
                      backgroundImage: _photoUrl != null
                          ? NetworkImage(_photoUrl!)
                          : const AssetImage('assets/default_avatar.png') as ImageProvider,
                    ),
                    const SizedBox(height: 20),

                    // Name
                    TextFormField(
                      controller: _usernameCtrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Username'),
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter username' : null,
                    ),
                    const SizedBox(height: 12),

                    // City
                    TextFormField(
                      controller: _cityCtrl,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('City'),
                    ),
                    const SizedBox(height: 12),

                    // Level
                    DropdownButtonFormField<String>(
                      value: _level.isEmpty ? null : _level,
                      dropdownColor: card,
                      decoration: _inputDecoration('Level'),
                      items: const ['Beginner', 'Intermediate', 'Advanced']
                          .map((l) => DropdownMenuItem(
                                value: l,
                                child: Text(l, style: const TextStyle(color: Colors.white)),
                              ))
                          .toList(),
                      onChanged: (val) => setState(() => _level = val ?? _level),
                    ),
                    const SizedBox(height: 12),

                    // Bio
                    TextFormField(
                      controller: _bioCtrl,
                      maxLines: 4,
                      maxLength: 160,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Bio (optional)'),
                    ),
                    const SizedBox(height: 12),

                    // Games / MVPs
                    TextFormField(
                      initialValue: _games.toString(),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('Games'),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _games = int.tryParse(v ?? '0') ?? 0,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      initialValue: _mvps.toString(),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration('MVPs'),
                      keyboardType: TextInputType.number,
                      onSaved: (v) => _mvps = int.tryParse(v ?? '0') ?? 0,
                    ),
                    const SizedBox(height: 20),

                    // Sports (quick viewer; you already have full editor flow separate)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sports', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () => _openSportPicker(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _sports.isEmpty
                        ? const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('No sports added yet', style: TextStyle(color: Colors.grey)))
                        : SizedBox(
                            height: 120,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _sports.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 10),
                              itemBuilder: (ctx, i) {
                                final sport = _sports.keys.elementAt(i);
                                final pos = _sports[sport]!;
                                return Container(
                                  width: 110,
                                  decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16)),
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(iconFor(sport), width: 34, height: 34),
                                      const SizedBox(height: 8),
                                      Text(sport,
                                          style: const TextStyle(color: Colors.white, fontSize: 14),
                                          overflow: TextOverflow.ellipsis),
                                      Text(pos,
                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                          overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () => _openSportPicker(editingSport: sport),
                                          ),
                                          const SizedBox(width: 6),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.redAccent, size: 18),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () => _deleteSport(sport),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: subtle),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: accent, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );

  InputDecoration _dropdownDecoration(String label) => _inputDecoration(label);
}
