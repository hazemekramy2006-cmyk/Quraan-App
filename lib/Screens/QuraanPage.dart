import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quraanapp/Data/Surah_Data.dart';
import 'package:quraanapp/Models/ModelSurah.dart';

class Quraanpage extends StatefulWidget {
  const Quraanpage({super.key});

  @override
  State<Quraanpage> createState() => _QuraanpageState();
}

class _QuraanpageState extends State<Quraanpage> {
  final TextEditingController _searchController = TextEditingController();
  final AudioPlayer player = AudioPlayer();

  final List<Surah> surahs = surahsData;

  List<Surah> filtered = [];

  @override
  void initState() {
    super.initState();
    filtered = surahs;
  }

  @override
  void dispose() {
    _searchController.dispose();
    player.dispose();
    super.dispose();
  }

  void updateSearch(String value) {
    final query = value.toLowerCase();

    setState(() {
      filtered = query.isEmpty
          ? surahs
          : surahs.where((s) {
              return s.name.toLowerCase().contains(query) || s.nameEn.toLowerCase().contains(query);
            }).toList();
    });
  }

  // 🎧 تشغيل السورة
  void playSurah(int index) async {
    await player.play(
      UrlSource(
        "https://server8.mp3quran.net/afs/${(index + 1).toString().padLeft(3, '0')}.mp3",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF8E2DE2)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "القرآن الكريم",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "The Holy Quran",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 15),

                // SEARCH
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: updateSearch,
                    decoration: const InputDecoration(
                      hintText: "Search for Surah...",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final surah = filtered[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF8E2DE2),
                      child: Text(
                        "${surahs.indexOf(surah) + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      surah.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(surah.nameEn),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          surah.type,
                          style: TextStyle(
                            color: surah.type == "مكية" ? Colors.orange : Colors.green,
                          ),
                        ),
                        Text("${surah.verses} آية"),
                      ],
                    ),
                    onTap: () {
                      _showSurahDetails(context, surah);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Bottom Sheet
  void _showSurahDetails(BuildContext context, Surah surah) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                surah.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(surah.nameEn),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.menu_book),
                      Text("${surah.verses} آية"),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.location_on),
                      Text(surah.type),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🎧 PLAY BUTTON
              GestureDetector(
                onTap: () {
                  playSurah(surahs.indexOf(surah));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6A11CB), Color(0xFF8E2DE2)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Play Audio",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
