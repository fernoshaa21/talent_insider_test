import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../lib.dart';
import '../cubit/explore_property_cubit.dart';
import '../cubit/explore_property_state.dart';

const priceGradient = LinearGradient(
  colors: [
    Color(0xFF970001), // red
    Color(0xFF004690), // navy
    Color(0xFF00ACA9), // teal
  ],
);

const unselectedTrack = Colors.grey;

class ExplorePropertyView extends StatefulWidget {
  const ExplorePropertyView({super.key});

  @override
  State<ExplorePropertyView> createState() => _ExplorePropertyViewState();
}

class _ExplorePropertyViewState extends State<ExplorePropertyView> {
  // ---- local filter state ----
  String? _status; // "new" / "second" / null
  String? _type; // "rumah" / "apartment" / dll
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-6.250477, 106.797414),
    zoom: 14,
  );
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  RangeValues _priceRange = const RangeValues(0, 0);
  Future<void> _getRegionBounds() async {
    final LatLngBounds bounds = await mapController.getVisibleRegion();
    final swLatitude = bounds.southwest.latitude;
    final swLongitude = bounds.southwest.longitude;
    final neLatitude = bounds.northeast.latitude;
    final neLongitude = bounds.northeast.longitude;

    // Send these coordinates to the API
    _sendCoordinatesToAPI(swLatitude, swLongitude, neLatitude, neLongitude);
  }

  // Function to call the API with coordinates
  void _sendCoordinatesToAPI(
    double swLatitude,
    double swLongitude,
    double neLatitude,
    double neLongitude,
  ) {
    // Call the cubit to fetch properties for the selected region
    context.read<ExplorePropertyCubit>().getLocationProperties(
      swLatitude: swLatitude,
      swLongitude: swLongitude,
      neLatitude: neLatitude,
      neLongitude: neLongitude,
    );
  }

  /// maksimum harga (ikut Swagger)
  static const double kPriceMax = 1000000000; // 1 Miliar

  @override
  void initState() {
    super.initState();
    // load awal
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  void _fetch() {
    int? priceMin;
    int? priceMax;

    // kondisi "belum pernah dipilih" (default 0..0) → jangan kirim filter
    final bool notPicked = _priceRange.start == 0 && _priceRange.end == 0;

    // kondisi "full range" (0..max) → juga dianggap tanpa filter
    final bool fullRange =
        _priceRange.start == 0 && _priceRange.end >= kPriceMax;

    if (!notPicked && !fullRange) {
      priceMin = _priceRange.start.round();
      priceMax = _priceRange.end.round();

      // pastikan tidak lewat batas
      if (priceMax > kPriceMax.toInt()) {
        priceMax = kPriceMax.toInt();
      }
    }

    // Function to update markers dynamically based on API response
    void _updateMarkers(List<LatLng> locations) {
      setState(() {
        _markers.clear();
        for (var location in locations) {
          _markers.add(
            Marker(
              markerId: MarkerId(location.toString()),
              position: location,
              infoWindow: InfoWindow(title: 'Property'),
            ),
          );
        }
      });
    }

    debugPrint(
      '[FILTER] status=$_status type=$_type priceMin=$priceMin priceMax=$priceMax',
    );

    context.read<ExplorePropertyCubit>().getProperties(
      status: _status,
      type: _type,
      priceMin: priceMin,
      priceMax: priceMax,
      viewMode: 'simple',
    );
  }

  String formatShortPrice(double value) {
    final v = value.toInt();

    if (v >= 1000000000) {
      // >= 1 Miliar
      final miliaran = v / 1000000000;
      final str = miliaran % 1 == 0
          ? miliaran.toInt().toString()
          : miliaran.toStringAsFixed(1);
      return '${str}M'; // M = milyar
    } else if (v >= 1000000) {
      // >= 1 juta
      final jutaan = v / 1000000;
      final str = jutaan % 1 == 0
          ? jutaan.toInt().toString()
          : jutaan.toStringAsFixed(1);
      return '${str}jt';
    } else if (v >= 1000) {
      // ribuan
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

    return BlocBuilder<ExplorePropertyCubit, ExplorePropertyState>(
      builder: (context, state) {
        final PropertiesResponse? response = state.properties;
        final items = response?.data?.data ?? [];
        final total = items.length;

        bool hasPriceFilter() {
          final notPicked = _priceRange.start == 0 && _priceRange.end == 0;
          final fullRange =
              _priceRange.start == 0 && _priceRange.end >= kPriceMax;
          return !notPicked && !fullRange;
        }

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
                          GoogleMap(
                            initialCameraPosition: _initialPosition,
                            onMapCreated: _onMapCreated,
                            markers: _markers,
                            onCameraMove: (_) {
                              // This is where the bounds are changed
                            },
                            onCameraIdle: () {
                              // Once the camera stops moving, we fetch the region bounds
                              _getRegionBounds();
                            },
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: ElevatedButton(
                              onPressed: () {
                                // Trigger location filter fetching (map bounds are used for this)
                                _getRegionBounds();
                              },
                              child: Text('Find Properties in View'),
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
                                  onPressed: () => context.goNamed('home'),
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
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(24),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const SearchPropertyView(
                                              initialQuery: '',
                                            ),
                                      ),
                                    );
                                  },
                                  child: IgnorePointer(
                                    child: const TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        hintText: 'Find Property',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
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
                                  isPrimary: hasPriceFilter(),
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
            onTap: () {
              tempType = value;
              setState(() => _type = tempType);
              _fetch();
              Navigator.pop(context);
            },
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
        // kalau belum pernah dipilih, buka langsung full range
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
                    'IDR ${formatShortPrice(tempRange.start)} - '
                    'IDR ${formatShortPrice(tempRange.end == 0 ? kPriceMax : tempRange.end)}',
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
                      inactiveTrackColor: unselectedTrack,
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

    // kiri (sebelum start thumb)
    final leftRect = Rect.fromLTRB(
      rect.left,
      rect.top,
      startThumbCenter.dx,
      rect.bottom,
    );

    // kanan (setelah end thumb)
    final rightRect = Rect.fromLTRB(
      endThumbCenter.dx,
      rect.top,
      rect.right,
      rect.bottom,
    );

    // tengah (aktif) → pakai gradient
    final activeRect = Rect.fromLTRB(
      startThumbCenter.dx,
      rect.top,
      endThumbCenter.dx,
      rect.bottom,
    );

    final inactivePaint = Paint()..color = unselectedTrack;
    final activePaint = Paint()
      ..shader = priceGradient.createShader(activeRect);

    // kiri & kanan abu-abu
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(leftRect, const Radius.circular(6)),
      inactivePaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(rightRect, const Radius.circular(6)),
      inactivePaint,
    );

    // bagian aktif dengan gradient
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
                  'Show all result (99+)',
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
