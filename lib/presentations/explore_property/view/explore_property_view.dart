import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../cubit/explore_property_cubit.dart';
import '../cubit/explore_property_state.dart';

class ExplorePropertyView extends StatefulWidget {
  const ExplorePropertyView({super.key});

  @override
  State<ExplorePropertyView> createState() => _ExplorePropertyViewState();
}

class _ExplorePropertyViewState extends State<ExplorePropertyView> {
  // ---- local filter state ----
  String? _status; // "new" / "second" / null
  String? _type; // "house" / "apartment" / dst
  double _priceMin = 0;
  double _priceMax = 0;
  RangeValues _priceRange = const RangeValues(0, 0);

  @override
  void initState() {
    super.initState();
    // load awal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  void _fetch() {
    context.read<ExplorePropertyCubit>().getProperties(
      status: _status,
      type: _type,
      // priceMin: _priceRange.start.toInt(),
      // priceMax: _priceRange.end.toInt(),
      viewMode: 'simple',
    );
  }

  void _resetFilter() {
    setState(() {
      _status = null;
      _type = null;
      _priceRange = const RangeValues(0, 100000000);
    });
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ExplorePropertyCubit, ExplorePropertyState>(
      builder: (context, state) {
        final PropertiesResponse? response = state.properties;
        final items = response?.data?.data ?? [];
        final total = items.length; // bisa diganti meta/pagination kalau mau

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
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/map_sample.png',
                              fit: BoxFit.cover,
                            ),
                          ),
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
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
                                'Explore Property',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextButton(
                                onPressed: _resetFilter,
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
                              children: [
                                _FilterChip(
                                  label: 'Status',
                                  isPrimary: _status != null,
                                  onTap: () => _openStatusFilter(context),
                                ),
                                _FilterChip(
                                  label: 'Type',
                                  isPrimary: _type != null,
                                  onTap: () => _openTypeFilter(context),
                                ),
                                _FilterChip(
                                  label: 'Price',
                                  isPrimary:
                                      _priceRange.start > 0 ||
                                      _priceRange.end < 100000000,
                                  onTap: () => _openPriceFilter(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // "Show all Property “xx”"
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Show all result ($total)',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        // List / loading / empty
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              if (state.status ==
                                  ExplorePropertyStatus.loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (items.isEmpty) {
                                return const Center(
                                  child: Text('No properties found'),
                                );
                              }

                              return ListView.builder(
                                controller: scrollController,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _PropertyCard(item: item),
                                  );
                                },
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
      },
    );
  }

  // ------------- FILTER BOTTOM SHEETS -------------

  void _openStatusFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        String? tempStatus = _status;

        return _FilterSheetWrapper(
          title: 'Status',
          onReset: () {
            tempStatus = null;
            setState(() => _status = null);
            _fetch();
            Navigator.pop(context);
          },
          onApply: () {
            setState(() => _status = tempStatus);
            _fetch();
            Navigator.pop(context);
          },
          child: Wrap(
            spacing: 8,
            children: [
              _ChoiceChip(
                label: 'New',
                selected: tempStatus == 'new',
                onTap: () => tempStatus = 'new',
              ),
              _ChoiceChip(
                label: 'Second',
                selected: tempStatus == 'second',
                onTap: () => tempStatus = 'second',
              ),
            ],
          ),
        );
      },
    );
  }

  void _openTypeFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        String? tempType = _type;

        Widget chip(String label, String value) {
          return _ChoiceChip(
            label: label,
            selected: tempType == value,
            onTap: () => tempType = value,
          );
        }

        return _FilterSheetWrapper(
          title: 'Type',
          onReset: () {
            tempType = null;
            setState(() => _type = null);
            _fetch();
            Navigator.pop(context);
          },
          onApply: () {
            setState(() => _type = tempType);
            _fetch();
            Navigator.pop(context);
          },
          child: Wrap(
            spacing: 8,
            children: [chip('House', 'rumah'), chip('Apartment', 'apartment')],
          ),
        );
      },
    );
  }

  void _openPriceFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        RangeValues tempRange = _priceRange;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return _FilterSheetWrapper(
              title: 'Price Range',
              onReset: () {
                tempRange = const RangeValues(0, 100000000);
                setState(() => _priceRange = tempRange);
                _fetch();
                Navigator.pop(context);
              },
              onApply: () {
                setState(() => _priceRange = tempRange);
                _fetch();
                Navigator.pop(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IDR ${tempRange.start.toInt()} - IDR ${tempRange.end.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: tempRange,
                    min: 0,
                    max: 100000000,
                    onChanged: (val) {
                      setModalState(() => tempRange = val);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ---------------- SMALL WIDGETS ----------------
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isPrimary ? const Color(0xFFE5ECFF) : Colors.white;
    final borderColor = isPrimary
        ? const Color(0xFF2945FF)
        : const Color(0xFFE2E2E2);
    final textColor = isPrimary
        ? const Color(0xFF2945FF)
        : const Color(0xFF444444);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
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
      ),
    );
  }
}

class _FilterSheetWrapper extends StatelessWidget {
  final String title;
  final VoidCallback onReset;
  final VoidCallback onApply;
  final Widget child;

  const _FilterSheetWrapper({
    super.key,
    required this.title,
    required this.onReset,
    required this.onApply,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                TextButton(
                  onPressed: onReset,
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
            const SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: child),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0033CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onApply,
                child: const Text(
                  'Show all result (99+)',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? const Color(0xFFE5ECFF) : Colors.white;
    final border = selected ? const Color(0xFF2945FF) : const Color(0xFFE2E2E2);
    final text = selected ? const Color(0xFF2945FF) : const Color(0xFF444444);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: border, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: text,
            fontSize: 16, // agak besar biar kayak desain
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final PropertiesDatum item;

  const _PropertyCard({required this.item});

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
                              item.name ?? '-',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.address ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      if (item.type != null)
                        _InfoChip(item.type == Type.RUMAH ? 'House' : 'Type'),
                      if (item.price != null) _InfoChip('IDR ${item.price}'),
                    ],
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
