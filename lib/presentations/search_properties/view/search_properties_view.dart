import 'dart:async'; // <<< penting untuk debounce
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/domain.dart';
import '../../../lib.dart';
import '../../explore_property/cubit/explore_property_cubit.dart';
import '../../explore_property/cubit/explore_property_state.dart';

class SearchPropertyView extends StatefulWidget {
  final String initialQuery;

  const SearchPropertyView({super.key, this.initialQuery = ''});

  @override
  State<SearchPropertyView> createState() => _SearchPropertyViewState();
}

class _SearchPropertyViewState extends State<SearchPropertyView> {
  late final TextEditingController _controller;

  Timer? _debounce; // debounce timer

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);

    // auto search kalau initialQuery tidak kosong
    if (widget.initialQuery.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _runSearch();
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _runSearch() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      context.read<ExplorePropertyCubit>().clearSearchResults();
      return;
    }

    context.read<ExplorePropertyCubit>().searchProperties(
      search: text,
      viewMode: 'simple',
    );
  }

  void _onChanged(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _runSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ====== TOP SEARCH BAR ======
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 1.5,
                          color: const Color(0xFF2945FF),
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _runSearch(),
                        onChanged: _onChanged, // << live search
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

            // ====== RESULT HEADER ======
            BlocBuilder<ExplorePropertyCubit, ExplorePropertyState>(
              builder: (context, state) {
                final keyword = _controller.text.trim();
                final PropertiesSearchResponse? resp = state.searchProperties;
                final items = resp?.data?.data ?? [];
                final showResult = keyword.isNotEmpty;
                final total = showResult ? items.length : 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          showResult
                              ? 'Result from “$keyword”'
                              : 'Search property',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (showResult)
                        Text(
                          '$total Property',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF2945FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 4),

            // ====== LIST RESULT ======
            Expanded(
              child: BlocBuilder<ExplorePropertyCubit, ExplorePropertyState>(
                builder: (context, state) {
                  final keyword = _controller.text.trim();

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
                    itemCount: items.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      if (index == items.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: Color(0xFF2945FF),
                                width: 1.5,
                              ),
                            ),
                            onPressed: () {
                              final keyword = _controller.text.trim();
                              if (keyword.isEmpty) return;

                              context.goNamed(
                                'result_properties_view',
                                extra: keyword,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'See all result',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final item = items[index];
                      return _SearchPropertyCard(item: item);
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
}

// ===================== CARD =======================

class _SearchPropertyCard extends StatelessWidget {
  final PropertiesSearchDatum item;

  const _SearchPropertyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.apartment,
                  size: 22,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF111827),
                        ),
                        children: [
                          TextSpan(text: item.name ?? '-'),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: _typeLabel(item.type),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatPrice(item.price),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_outward,
                size: 18,
                color: Color(0xFF111827),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _typeLabel(PropertyTypeSearch? type) {
    switch (type) {
      case PropertyTypeSearch.rumah:
        return 'House';
      default:
        return 'Property';
    }
  }

  String _formatPrice(String? price) {
    if (price == null || price.isEmpty) return '-';
    final value = double.tryParse(price) ?? 0;
    return 'IDR ${value.toStringAsFixed(0)}';
  }
}
