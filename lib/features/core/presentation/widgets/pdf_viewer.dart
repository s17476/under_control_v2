import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:under_control_v2/main.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({
    Key? key,
    required this.path,
    this.isFullScreen = false,
  }) : super(key: key);

  final String path;
  final bool isFullScreen;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PDFViewController? _controller;
  int _currentPage = 0;
  int _pages = 0;
  bool _isReady = false;
  String _errorMessage = '';

  void _toggleFullScreen() {
    if (widget.isFullScreen == true) {
      Navigator.pop(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: SafeArea(
              child: PdfViewer(
                path: widget.path,
                isFullScreen: true,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    if (widget.isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PDFView(
          filePath: widget.path,
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: true,
          pageFling: true,
          pageSnap: true,
          defaultPage: _currentPage,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
          onRender: (pages) {
            setState(() {
              _pages = pages!;
              _isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              _errorMessage = error.toString();
            });
          },
          onPageError: (page, error) {
            setState(() {
              _errorMessage = '$page: ${error.toString()}';
            });
          },
          onViewCreated: (PDFViewController pdfViewController) {
            setState(() {
              _controller = pdfViewController;
            });
          },
          // onLinkHandler: (String? uri) {
          //   print('goto uri: $uri');
          // },
          onPageChanged: (int? page, int? total) {
            setState(() {
              _currentPage = page!;
            });
          },
        ),
        // pages count
        if (_isReady)
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('${_currentPage + 1} / $_pages'),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: _toggleFullScreen,
                    icon: Icon(
                      widget.isFullScreen
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (_isReady && _pages > 1)
          Positioned(
            bottom: 8,
            child: Row(
              children: [
                // first page
                CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: () =>
                        _currentPage != 0 ? _controller!.setPage(0) : null,
                    icon: Icon(
                      Icons.keyboard_double_arrow_left,
                      color: _currentPage != 0 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                // back
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: () => _currentPage != 0
                        ? _controller!.setPage(_currentPage - 1)
                        : null,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 32,
                        color: _currentPage != 0 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // forward
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: () => _currentPage + 1 != _pages
                        ? _controller!.setPage(_currentPage + 1)
                        : null,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 32,
                      color: _currentPage + 1 != _pages
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                // last page
                CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: () => _currentPage != _pages - 1
                        ? _controller!.setPage(_pages - 1)
                        : null,
                    icon: Icon(
                      Icons.keyboard_double_arrow_right,
                      color: _currentPage != _pages - 1
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        _errorMessage.isEmpty
            ? !_isReady
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
            : Center(
                child: Text(_errorMessage),
              ),
      ],
    );
  }
}
