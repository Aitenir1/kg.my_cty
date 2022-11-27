import 'package:flutter/material.dart';

class InfoWidget extends StatefulWidget {
  final String title;
  final String text;

  const InfoWidget({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/banners.jpg'),
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            widget.text,
            maxLines: 1,
            // overflow: TextOverflow.fade,
            style: const TextStyle(
              fontSize: 16.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
          // Spacer(),
          ElevatedButton(
            onPressed: () {},
            child: Container(
              // height: 10,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text('Проголосовать'),
            ),
          )
        ],
      ),
    );
  }
}
