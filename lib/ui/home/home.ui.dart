import 'package:flutter/material.dart';
import 'package:vitec_travels/ui/home/home.vm.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../base/base.ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model){
        model.getFromStore();
      },
      builder: (context, model, child) =>RefreshIndicator(
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 3), () {
            setState(() {
              model.getTravelData();
            });
          });
        },
        child:  Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 150,
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Image.asset('assets/images/finals.png', fit: BoxFit.cover, height: double.maxFinite, width: double.maxFinite,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
                        child: Container(
                          height: 50,
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: model.searchController,
                            decoration: InputDecoration(
                                hintText: "What do you want to experience?",
                                hintStyle: TextStyle(
                                  color: Colors.black.withAlpha(700), fontWeight: FontWeight.w500
                                ),
                                prefixIcon:Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                                  child: InkWell(onTap: (){} , child: const Icon(Icons.search, color: Colors.green, size: 30,)), // myIcon is a 48px-wide widget.
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent)),
                                contentPadding: const EdgeInsets.only(
                                    top: 15, bottom: 15, right: 0, left: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            keyboardType: TextInputType.text,
                            onChanged:(val){

                            }
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(child: ListView(
                padding: const EdgeInsets.all(0),
                physics: const AlwaysScrollableScrollPhysics(),
                children:  [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text.rich(TextSpan(
                              text: 'Touren in de deiner ',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Nahe',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                              ])),
                          // Text('Tours near you', style: TextStyle(fontSize: 25,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w700),),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          height: model.viewMore==false?120:model.nearby?.length==null?120:(120.toDouble()*model.nearby!.length.toDouble()) as double,
                          child: model.nearby?.length==0||model.nearby?.length==null?
                          Center(
                            child: Text('No tours yet refresh page', style: TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                          ):ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: model.nearby?.length,
                              itemBuilder: (context, index){
                                final nearby = model.nearby?[index];
                                return Container(
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 1),
                                  padding: EdgeInsets.only(left: 16),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(fit: BoxFit.fill,
                                                  image: CachedNetworkImageProvider(nearby?.images==null?"https://picsum.photos/200/300":"${nearby?.images?[0].path}")
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text('${nearby?.name}', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: const Color.fromRGBO(200, 200, 200, 1)
                                                            ),
                                                          ),
                                                          Text('${nearby?.location}', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 2),
                                                            child: Image.asset("assets/images/germany.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 2),
                                                            child: Image.asset("assets/images/star.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?.averageRating?.toDouble()}', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                          SizedBox(width: 2,),
                                                          Text('(${nearby?.distance})', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            child: Image.asset("assets/images/money.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?.stepcount?.toDouble()}', style: const TextStyle(fontSize: 15,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            child: Image.asset("assets/images/stopwatch.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?.min?.toDouble()}', style: const TextStyle(fontSize: 15,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            child: Image.asset("assets/images/data-transfer.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?.price?.toDouble()}', style: const TextStyle(fontSize: 15,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ))
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(horizontal: 40)
                              ),
                              onPressed: ()=>setState(() {
                                model.updatePageIndex();
                              }),
                              child:  Text(model.viewMore==true?"See Less":"See More", style: TextStyle(fontSize: 18,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w700),),
                            )
                          ],
                        ),
                        const SizedBox(height: 20,),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text.rich(TextSpan(
                              text: 'Beliebte ',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Colors.green,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Touren',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                              ])),
                        ),
                        SizedBox(height: 16,),
                        Container(
                          height: model.popViewMore==false?240:model.populars?.length==null?240:(120.toDouble()*model.populars!.length.toDouble()) as double,
                          child: model.populars?.length==0||model.populars?.length==null?
                          Center(
                            child: Text('No tours yet refresh page', style: TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                          ):ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: model.popViewMore==false?2: model.populars?.length,
                              itemBuilder: (context, index){
                                final nearby = model.populars?[index];
                                return Container(
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 1),
                                  padding: EdgeInsets.only(left: 16),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(fit: BoxFit.fill,
                                                  image: CachedNetworkImageProvider(nearby?["author"]["img_path"]==null?"":"${nearby?["author"]["img_path"]}")
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Expanded(child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text('${nearby?["name"]}', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: const Color.fromRGBO(200, 200, 200, 1)
                                                            ),
                                                          ),
                                                          Text('${nearby?["location"]}', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 2),
                                                            child: Image.asset("assets/images/nigeria.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 2),
                                                            child: Image.asset("assets/images/star.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text(nearby?["averageRating"]==null?"0.0":'${nearby?["averageRating"]}', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                          SizedBox(width: 2,),
                                                          Text('(${nearby?["min"]})', style: const TextStyle(fontSize: 17,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            child: Image.asset("assets/images/money.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?["stepcount"].toDouble()}', style: const TextStyle(fontSize: 15,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            child: Image.asset("assets/images/stopwatch.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?["min"].toDouble()}', style: const TextStyle(fontSize: 15,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 20, width: 20,
                                                            margin: const EdgeInsets.only(right: 5),
                                                            child: Image.asset("assets/images/data-transfer.png", height: 20, width: 20, fit: BoxFit.contain,),
                                                          ),
                                                          Text('${nearby?["price"].toDouble()}', style: const TextStyle(fontSize: 15,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w500),),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Divider()
                                        ],
                                      ))
                                    ],
                                  ),
                                );
                              }
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.symmetric(horizontal: 40)
                              ),
                              onPressed: ()=>setState(() {
                                model.updatePopPageIndex();
                              }),
                              child:  Text(model.popViewMore==true?"See Less":"See More", style: TextStyle(fontSize: 18,fontFamily: 'Inter', color: Colors.black,fontWeight: FontWeight.w700),),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
