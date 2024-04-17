import 'package:flutter/material.dart';

class lazyLoading extends StatefulWidget {
  const lazyLoading({super.key});

  @override
  State<lazyLoading> createState() => _lazyLoadingState();
}

class _lazyLoadingState extends State<lazyLoading> {

  final ScrollController _scrollController = ScrollController();
  List<String> items = List.generate(20, (index) => "Item ${index}" );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreData();
        
      }
    });
  }

  _loadMoreData()async{
await Future.delayed(Duration(seconds: 2));
setState(() {
  List<String> newItems = List.generate(20, (index) => "new items ${items.length + 1}");
  items.addAll(newItems);
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazy Loading"),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            ...items.asMap().entries.map((e)
             {
              int index = e.key;
              String item = e.value;
if (index < items.length -1) {
  return ListTile(title: Text(e.value),);
  
  
}
else{
  return CircularProgressIndicator();
}
 
   } )

          ],
        ),
      ),
    );
  }
}