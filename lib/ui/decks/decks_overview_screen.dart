import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deck_grid.dart';
import '../screen.dart';

enum FilterOptions { all, fav, sinhhoc, vatly, hoahoc, lichsu, dialy }

class DecksOverviewScreen extends StatefulWidget {
  static const routeName = '/decks';

  const DecksOverviewScreen({super.key});

  @override
  State<DecksOverviewScreen> createState() => _DecksOverviewScreenState();
}

class _DecksOverviewScreenState extends State<DecksOverviewScreen> {
  var _currentFilter = FilterOptions.all;
  late Future<void> _fetchDecks;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _fetchDecks = context.read<DecksManager>().fetchDecks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                TopicName(currentFilter: _currentFilter),
                const Spacer(), // Đẩy nút menu về bên phải
                FilterMenu(
                  currentFilter: _currentFilter,
                  onFilterSelected: (filter) {
                    setState(() {
                      _currentFilter = filter;
                    });
                  },
                )
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Tìm kiếm...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Theme.of(context).colorScheme.surface),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 50),
            FutureBuilder(
                future: _fetchDecks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_searchText.isNotEmpty) {
                      return Expanded(
                        child: DeckGrid(_searchText, isSearch: true),
                      );
                    }
                    return Expanded(
                      child: DeckGrid(getFilter(_currentFilter)!),
                    );
                  }
                  return const Center(
                    child: CustomProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: const BotNavBar(initialIndex: 1),
    );
  }
}

class FilterMenu extends StatelessWidget {
  const FilterMenu({
    super.key,
    this.currentFilter,
    this.onFilterSelected,
  });

  final FilterOptions? currentFilter;
  final void Function(FilterOptions selectedValue)? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        initialValue: currentFilter,
        onSelected: onFilterSelected,
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          size: 50,
        ),
        itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Tất cả bộ thẻ'),
              ),
              const PopupMenuItem(
                value: FilterOptions.fav,
                child: Text('Yêu thích'),
              ),
              const PopupMenuItem(
                value: FilterOptions.sinhhoc,
                child: Text('Sinh học'),
              ),
              const PopupMenuItem(
                value: FilterOptions.hoahoc,
                child: Text('Hóa học'),
              ),
              const PopupMenuItem(
                value: FilterOptions.vatly,
                child: Text('Vật lý'),
              ),
              const PopupMenuItem(
                value: FilterOptions.lichsu,
                child: Text('Lịch sử'),
              ),
              const PopupMenuItem(
                value: FilterOptions.dialy,
                child: Text('Địa lý'),
              ),
            ]);
  }
}

class TopicName extends StatelessWidget {
  const TopicName({
    super.key,
    this.currentFilter,
  });
  final FilterOptions? currentFilter;
  @override
  Widget build(BuildContext context) {
    String title;
    switch (currentFilter) {
      case FilterOptions.sinhhoc:
        title = 'CHỦ ĐỀ SINH HỌC';
        break;
      case FilterOptions.hoahoc:
        title = 'CHỦ ĐỀ HÓA HỌC';
        break;
      case FilterOptions.vatly:
        title = 'CHỦ ĐỀ VẬT LÝ';
        break;
      case FilterOptions.lichsu:
        title = 'CHỦ ĐỀ LỊCH SỬ';
        break;
      case FilterOptions.dialy:
        title = 'CHỦ ĐỀ ĐỊA LÝ';
        break;
      case FilterOptions.fav:
        title = 'BỘ THẺ YÊU THÍCH';
        break;
      default:
        title = 'TẤT CẢ BỘ THẺ';
    }
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

String? getFilter(FilterOptions filter) {
  String type = '';
  switch (filter) {
    case FilterOptions.sinhhoc:
      type = 'Sinh học';
      break;
    case FilterOptions.hoahoc:
      type = 'Hóa học';
      break;
    case FilterOptions.vatly:
      type = 'Vật lý';
      break;
    case FilterOptions.lichsu:
      type = 'Lịch sử';
      break;
    case FilterOptions.dialy:
      type = 'Địa lý';
      break;
    case FilterOptions.fav:
      type = 'Yêu thích';
      break;
    default:
  }
  return type;
}
