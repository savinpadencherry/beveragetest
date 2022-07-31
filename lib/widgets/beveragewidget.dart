// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_test_r/models/newbeverage.dart';

class BeverageWidget extends StatefulWidget {
  final NewBeverage beverageModel;
  const BeverageWidget({
    Key? key,
    required this.beverageModel,
  }) : super(key: key);

  @override
  State<BeverageWidget> createState() => _BeverageWidgetState();
}

class _BeverageWidgetState extends State<BeverageWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BeverageDescription(
              beverageModel: widget.beverageModel,
            ),
          ),
        );
      },
      child: basemodel(),
    );
  }

  Padding basemodel() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 150,
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 25.0,
                  offset: Offset(0, 5),
                  spreadRadius: 0)
            ]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image.network(
                  widget.beverageModel.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.beverageModel.name,
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.beverageModel.strGlass,
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.no_drinks,
                      color: Colors.black45,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.beverageModel.id,
                      style: const TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(Icons.local_drink),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.beverageModel.type,
                      style: const TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BeverageDescription extends StatefulWidget {
  final NewBeverage beverageModel;
  const BeverageDescription({
    Key? key,
    required this.beverageModel,
  }) : super(key: key);

  @override
  State<BeverageDescription> createState() => _BeverageDescriptionState();
}

class _BeverageDescriptionState extends State<BeverageDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(widget.beverageModel.imageUrl),
              AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.beverageModel.strGlass,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.beverageModel.type,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.beverageModel.instructions,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.beverageModel.name,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
