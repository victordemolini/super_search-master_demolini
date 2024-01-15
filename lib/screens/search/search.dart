import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_search/screens/search/tile.dart';
import 'package:super_search/style.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String>? _results;
  String _input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search Users'), backgroundColor: Colors.red,
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                onChanged: _onSearchFieldChanged,
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: placeholderTextFieldStyle,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                )),
          ),
          Expanded(
              child: (_results ?? []).isNotEmpty
                  ? GridView.count(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(2.0),
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  children: _results!.map((r) => Tile(r)).toList())
                  : Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: _results == null
                      ? Container()
                      : Text("No results for '$_input'",
                      style: Theme.of(context).textTheme.caption))),
        ]));
  }

  _onSearchFieldChanged(String value) async {
    setState(() {
      _input = value;
      if (value.isEmpty) {
        _results = null;
      }
    });

    final results = await _searchUsers(value);

    setState(() {
      _results = results;
    });
  }

  Future<List<String>> _searchUsers(String name) async {
    final result = await Supabase.instance.client
        .from('dragonball')
        .select('name')
        .textSearch('name', name)
        .limit(100)
        .execute();

    if (result.data == null) {
      ('error: ${result.data.toString()}');
      return [];
    }

    final List<String> dragonball = [];

    for (var v in ((result.data ?? []) as List<dynamic>)) {

      dragonball.add("${v['name']}");
    }
    return dragonball;
  }
}