import 'dart:math';

import 'package:flutter/material.dart';

import 'home.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: Text("Application Tricks"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform(
          transform:
              Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: page1(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: page2(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: page3(),
                    ),
                  ],
                ),
              ),
              FlipperWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget page1() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFFcd5334),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Icon(
              Icons.warning,
              size: 90,
              color: Colors.white,
            ),
          ),
          Text(
            "application first trick",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget page2() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFFcd5334),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Icon(
              Icons.warning,
              size: 90,
              color: Colors.white,
            ),
          ),
          Text(
            "application second trick",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget page3() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFFcd5334),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Icon(
              Icons.warning,
              size: 90,
              color: Colors.white,
            ),
          ),
          Text(
            "application third trick",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class FlipperWidget extends StatefulWidget {
  @override
  _FlipperWidgetState createState() => _FlipperWidgetState();
}

class _FlipperWidgetState extends State<FlipperWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  bool reverseControl = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -pi / 2), weight: 0.5),
      TweenSequenceItem(tween: Tween(begin: pi / 2, end: 0.0), weight: 0.5),
    ]).animate(_animationController);
  }

  _onTap(){
    if(!mounted) return;
    if(reverseControl){
      _animationController.reverse();
      reverseControl=false;
    }else{
      _animationController.forward();
      reverseControl=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_animation.value),
        child: GestureDetector(
          onTap: _onTap,
          child: IndexedStack(
            alignment: Alignment.center,
            index: _animationController.value < 0.5 ? 0 : 1,
            children: [
              one(),
              two(),
            ],
          ),
        ),
      ),
    );
  }

  Widget one() {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
          color: Color(0xFFcd5334), borderRadius: BorderRadius.circular(25)),
      child: Center(child: Text("Trick One",style: TextStyle(color: Colors.white),)),
    );
  }

  Widget two() {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Text(
          "Trick Two",
          style: TextStyle(
            color: Color(0xFFcd5334),
          ),
        ),
      ),
    );
  }
}
