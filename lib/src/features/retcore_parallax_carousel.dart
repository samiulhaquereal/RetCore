import 'dart:ui';
import 'package:retcore/src/config/imports.dart';

class RetCoreParallaxCarousel extends StatefulWidget {
  final double? padding;
  final double? spacing;
  final double imageHeight;
  final double imageWidth;
  final double radius;
  final List<String> imagePath;
  final Axis scrollDirection;

  const RetCoreParallaxCarousel({
    super.key,
    required this.imagePath,
    this.padding = tParallaxImagePadding,
    this.spacing = tParallaxImageSpacing,
    this.imageHeight = tParallaxImageHeight,
    this.imageWidth = tParallaxImageWidth,
    this.radius = tParallaxImageRadius,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<RetCoreParallaxCarousel> createState() => _ParallaxCarouselState();
}

class _ParallaxCarouselState extends State<RetCoreParallaxCarousel> {
  late final ScrollController _scrollController;
  late final double _indexFactor;
  double _imageOffset = 0.0;

  @override
  void initState() {
    final deviceHeight = (window.physicalSize.longestSide / window.devicePixelRatio);
    final deviceWidth = (window.physicalSize.shortestSide / window.devicePixelRatio);
    _indexFactor = widget.scrollDirection == Axis.vertical ? (widget.spacing! + widget.imageHeight) / deviceHeight : (widget.spacing! + widget.imageWidth) / deviceWidth;
    _imageOffset = widget.scrollDirection == Axis.vertical ? -widget.padding! / deviceHeight : -widget.padding! / deviceWidth;
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _imageOffset = widget.scrollDirection == Axis.vertical ? ((_scrollController.offset - widget.padding!) / deviceHeight) : ((_scrollController.offset - widget.padding!) / deviceWidth);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.scrollDirection == Axis.vertical ? MediaQuery.of(context).size.height : widget.imageHeight,
      width: widget.scrollDirection == Axis.vertical ? widget.imageWidth : MediaQuery.of(context).size.width,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: widget.scrollDirection == Axis.vertical ? widget.padding! : 0,horizontal: widget.scrollDirection == Axis.vertical ? 0 :  widget.padding!),
        controller: _scrollController,
        scrollDirection: widget.scrollDirection,
        itemCount: widget.imagePath.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(height: widget.scrollDirection == Axis.vertical ? widget.spacing : null , width: widget.scrollDirection == Axis.vertical ? null : widget.spacing),
        itemBuilder: (_, index) => ImageItem(
          index: index,
          imagePath: widget.imagePath[index],
          imageHeight: widget.imageHeight,
          imageWidth: widget.imageWidth,
          imageOffset: _imageOffset,
          indexFactor: _indexFactor,
          radius: widget.radius,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final int index;
  final String imagePath;
  final double imageHeight;
  final double imageWidth;
  final Axis scrollDirection;
  final double imageOffset;
  final double indexFactor;
  final double radius;

  const ImageItem({
    Key? key,
    required this.index,
    required this.imagePath,
    required this.imageHeight,
    required this.imageWidth,
    required this.scrollDirection,
    required this.imageOffset,
    required this.indexFactor,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: scrollDirection == Axis.vertical ? imageHeight : null,
        width: scrollDirection == Axis.vertical ? null : imageWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            alignment: scrollDirection == Axis.vertical ? Alignment(0, -imageOffset + indexFactor * index) : Alignment(-imageOffset + indexFactor * index, 0),
          ),
        )
    );
  }
}
