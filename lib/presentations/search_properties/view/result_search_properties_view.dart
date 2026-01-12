import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../explore_property/cubit/explore_property_cubit.dart';
import '../../explore_property/cubit/explore_property_state.dart';

const _priceGradient = LinearGradient(
  colors: [
    Color(0xFF970001), // red
    Color(0xFF004690), // navy
    Color(0xFF00ACA9), // teal
  ],
);

const _unselectedTrack = Colors.grey;

class SearchPropertyResultView extends StatefulWidget {
  final String initialKeyword;

  const SearchPropertyResultView({super.key, required this.initialKeyword});

  @override
  State<SearchPropertyResultView> createState() =>
      _SearchPropertyResultViewState();
}

class _SearchPropertyResultViewState extends State<SearchPropertyResultView> {
  String? _status;
  String? _type;
  RangeValues _priceRange = const RangeValues(0, 0);

  static const double kPriceMax = 1000000000; // 1 M

  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialKeyword);

    // langsung load data awal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _debouncedSearch() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _fetch();
    });
  }

  void _fetch() {
    final keyword = _searchController.text.trim();

    int? priceMin;
    int? priceMax;

    final bool notPicked = _priceRange.start == 0 && _priceRange.end == 0;
    final bool fullRange =
        _priceRange.start == 0 && _priceRange.end >= kPriceMax;

    if (!notPicked && !fullRange) {
      priceMin = _priceRange.start.round();
      priceMax = _priceRange.end.round();
      if (priceMax > kPriceMax.toInt()) {
        priceMax = kPriceMax.toInt();
      }
    }

    context.read<ExplorePropertyCubit>().searchProperties(
      search: keyword.isEmpty ? null : keyword,
      status: _status,
      type: _type,
      priceMin: priceMin,
      priceMax: priceMax,
      viewMode: 'simple',
    );
  }

  String _formatShortPrice(double value) {
    final v = value.toInt();

    if (v >= 1000000000) {
      final miliaran = v / 1000000000;
      final str = miliaran % 1 == 0
          ? miliaran.toInt().toString()
          : miliaran.toStringAsFixed(1);
      return '${str}M';
    } else if (v >= 1000000) {
      final jutaan = v / 1000000;
      final str = jutaan % 1 == 0
          ? jutaan.toInt().toString()
          : jutaan.toStringAsFixed(1);
      return '${str}jt';
    } else if (v >= 1000) {
      final ribu = v / 1000;
      final str = ribu % 1 == 0
          ? ribu.toInt().toString()
          : ribu.toStringAsFixed(1);
      return '${str}rb';
    }
    return v.toString();
  }

  void _resetFilter() {
    setState(() {
      _status = null;
      _type = null;
      _priceRange = const RangeValues(0, 0);
    });
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP BAR + SEARCH =====
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () => context.goNamed('home'),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        // kalau mau gradient merah-biru, kita pakai container double
                        border: Border.all(
                          width: 1.5,
                          color: const Color(0xFF2945FF),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _fetch(),
                        onChanged: (_) => _debouncedSearch(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search property',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== FILTER CHIPS =====
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
                      label: 'Price Range',
                      isPrimary: !_isPriceDefault(),
                      onTap: () => _openPriceFilter(context),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ===== HEADER "All Result" =====
            BlocBuilder<ExplorePropertyCubit, ExplorePropertyState>(
              builder: (context, state) {
                final PropertiesSearchResponse? resp = state.searchProperties;
                final total = resp?.data?.data?.length ?? 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Result "$total"',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
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
                );
              },
            ),

            const SizedBox(height: 4),

            // ===== LIST RESULT =====
            Expanded(
              child: BlocBuilder<ExplorePropertyCubit, ExplorePropertyState>(
                builder: (context, state) {
                  final keyword = _searchController.text.trim();

                  if (keyword.isEmpty) {
                    return const Center(
                      child: Text('Type a keyword to search property'),
                    );
                  }

                  if (state.status == ExplorePropertyStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final PropertiesSearchResponse? resp = state.searchProperties;
                  final items = resp?.data?.data ?? [];

                  if (items.isEmpty) {
                    return const Center(child: Text('No properties found'));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _ResultPropertyCard(item: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isPriceDefault() {
    final notPicked = _priceRange.start == 0 && _priceRange.end == 0;
    final fullRange = _priceRange.start == 0 && _priceRange.end >= kPriceMax;
    return notPicked || fullRange;
  }

  void _openStatusFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        String? tempStatus = _status;

        return StatefulBuilder(
          builder: (context, setModalState) {
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
                    onTap: () => setModalState(() {
                      // toggle: kalau sudah 'new', jadi null
                      tempStatus = tempStatus == 'new' ? null : 'new';
                    }),
                  ),
                  _ChoiceChip(
                    label: 'Second',
                    selected: tempStatus == 'second',
                    onTap: () => setModalState(() {
                      tempStatus = tempStatus == 'second' ? null : 'second';
                    }),
                  ),
                ],
              ),
            );
          },
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

        return StatefulBuilder(
          builder: (context, setModalState) {
            Widget chip(String label, String value) {
              return _ChoiceChip(
                label: label,
                selected: tempType == value,
                onTap: () => setModalState(() {
                  tempType = tempType == value ? null : value;
                }),
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
                children: [
                  chip('House', 'rumah'),
                  chip('Apartment', 'apartment'),
                ],
              ),
            );
          },
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
        RangeValues tempRange = _priceRange.start == 0 && _priceRange.end == 0
            ? const RangeValues(0, kPriceMax)
            : _priceRange;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return _FilterSheetWrapper(
              title: 'Price Range',
              onReset: () {
                tempRange = const RangeValues(0, 0);
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
                    'IDR ${_formatShortPrice(tempRange.start)} - '
                    'IDR ${_formatShortPrice(tempRange.end == 0 ? kPriceMax : tempRange.end)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 10,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20,
                      ),
                      thumbColor: const Color(0xFF004690),
                      activeTrackColor: Colors.transparent,
                      inactiveTrackColor: _unselectedTrack,
                      rangeTrackShape: const _GradientTrackShape(),
                    ),
                    child: RangeSlider(
                      values: tempRange,
                      min: 0,
                      max: kPriceMax,
                      onChanged: (val) {
                        setModalState(() => tempRange = val);
                      },
                    ),
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

// ================== CARD RESULT ==================

class _ResultPropertyCard extends StatelessWidget {
  final PropertiesSearchDatum item;

  const _ResultPropertyCard({required this.item});

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
          // garis gradient di kiri
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
                      if (item.type != null) _InfoChip(_typeLabel(item.type)),
                      if (item.price != null)
                        _InfoChip(_formatPrice(item.price)),
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

  static String _typeLabel(PropertyTypeSearch? type) {
    switch (type) {
      case PropertyTypeSearch.rumah:
        return 'House';
      default:
        return 'Property';
    }
  }

  static String _formatPrice(String? price) {
    if (price == null || price.isEmpty) return '-';
    final value = double.tryParse(price) ?? 0;
    return 'IDR ${value.toStringAsFixed(0)}';
  }
}

// ============== SMALL WIDGETS (FILTER UI) ==============

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

class _GradientTrackShape extends RangeSliderTrackShape {
  const _GradientTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 4;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required Animation<double> enableAnimation,
    required Offset endThumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Offset startThumbCenter,
    required TextDirection textDirection,
  }) {
    final rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final leftRect = Rect.fromLTRB(
      rect.left,
      rect.top,
      startThumbCenter.dx,
      rect.bottom,
    );

    final rightRect = Rect.fromLTRB(
      endThumbCenter.dx,
      rect.top,
      rect.right,
      rect.bottom,
    );

    final activeRect = Rect.fromLTRB(
      startThumbCenter.dx,
      rect.top,
      endThumbCenter.dx,
      rect.bottom,
    );

    final inactivePaint = Paint()..color = _unselectedTrack;
    final activePaint = Paint()
      ..shader = _priceGradient.createShader(activeRect);

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(leftRect, const Radius.circular(6)),
      inactivePaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rightRect, const Radius.circular(6)),
      inactivePaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(6)),
      activePaint,
    );
  }
}

class _FilterSheetWrapper extends StatelessWidget {
  final String title;
  final VoidCallback onReset;
  final VoidCallback onApply;
  final Widget child;

  const _FilterSheetWrapper({
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
                  'Show result',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
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
