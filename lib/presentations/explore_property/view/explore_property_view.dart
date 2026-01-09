import 'package:flutter/material.dart';

class ExplorePropertyView extends StatelessWidget {
  const ExplorePropertyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // ------------ MAP SECTION ------------
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Ganti dengan GoogleMap / widget map beneran kalau perlu
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/map_sample.png', // placeholder
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Tombol back
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                      ),

                      // Search bar
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 56,
                            vertical: 8,
                          ),
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFFE74C3C),
                                width: 1.2,
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Find Property',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Icon setting/location (kanan bawah di map)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.my_location_outlined),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ------------ BOTTOM SHEET ------------
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.45,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title + Reset
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Xplore Property',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Color(0xFF0044CC),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filter chips
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            _FilterChip(label: 'Status'),
                            _FilterChip(label: 'Location 1', isPrimary: true),
                            _FilterChip(label: 'Type 2', isPrimary: true),
                            _FilterChip(label: 'Price'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // "Show all Property “99”"
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Show all Property “99”',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // List property
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: _PropertyCard(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------- Widgets Kecil ----------------

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isPrimary;

  const _FilterChip({required this.label, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    final bg = isPrimary ? const Color(0xFFE0E7FF) : Colors.white;
    final borderColor = isPrimary
        ? const Color(0xFF2945FF)
        : const Color(0xFFE2E2E2);
    final textColor = isPrimary
        ? const Color(0xFF2945FF)
        : const Color(0xFF444444);

    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // gradient border kiri
          Container(
            width: 3,
            height: 110,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [Color(0xFFEB5757), Color(0xFF2F80ED)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title + bookmark
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // icon kotak
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.apartment,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1 Br  Mansion Kemayoran Apartment',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Jakarta',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // alamat
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Jl. Merdeka Selatan No.21 Kemayoran, C...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // chips info
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: const [
                      _InfoChip('Apartment'),
                      _InfoChip('Second'),
                      _InfoChip('IDR 30M'),
                      _InfoChip('LT 36 m2'),
                      _InfoChip('LB 30 m2'),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    '1 month ago',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
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

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF4B5563),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
