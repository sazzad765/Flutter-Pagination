
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/api/brand_api.dart';
import 'package:flutter_pagination/constant.dart';
import 'package:flutter_pagination/models/brands.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollController = new ScrollController();
  var loadCompleted = false;
  int nextPage = 1;
  List<Data>list = [];

  @override
  void initState() {
    _loadItem();
    scrollIndicator();
    super.initState();
  }

  _loadItem(){
    fetchAllBrand(nextPage).then((value) => {
      nextPage < value.brands.lastPage
          ? nextPage++ : loadCompleted = true,
      value.brands.data.forEach((element) {
        list.add(element);
        setState(() {});
      }),

      print('value: '+value.toString()),


    });
    // setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollIndicator() {
    _scrollController.addListener(
          () {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          print('reach to bottom button');
          if (!loadCompleted) {
            setState(() {
              _loadItem();
            });
          }
        }
      },
    );
  }

  buildItem(BuildContext context, Data dataList) {
    return InkWell(
      child: Container(
        color: Color(0xFFEBEBEB),
        child: Column(
          children: [

            CachedNetworkImage(
              imageUrl: '$imageBaseUrl${dataList.image}',
              placeholder: (context, url) => Image.asset('assets/images/no_image.jpg'),
              errorWidget: (context, url, error) => Image.asset('assets/images/no_image.jpg'),
              height: 80,
              width: 100,
            ),

            Text(
              dataList.name,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      // onTap: () => Navigator.pushNamed(context, BrandProductScreen.routeName,
      //     arguments: dataList.slug),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child:Column(children: [
        GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return buildItem(context, list[index]);
          },
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
              (MediaQuery.of(context).orientation == Orientation.portrait) ? 3 : 4,
              crossAxisSpacing: 8, mainAxisSpacing: 8),
          padding: EdgeInsets.all(8),
        ),
        loadCompleted?Container():CircularProgressIndicator(),
      ],),
    );
  }
}
