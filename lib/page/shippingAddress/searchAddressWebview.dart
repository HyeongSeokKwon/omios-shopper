import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';

class SearchAddressWebView extends StatefulWidget {
  final ShippingAddressBloc shippingAddressBloc;
  const SearchAddressWebView({Key? key, required this.shippingAddressBloc})
      : super(key: key);

  @override
  State<SearchAddressWebView> createState() => _SearchAddressWebViewState();
}

class _SearchAddressWebViewState extends State<SearchAddressWebView> {
  final InAppLocalhostServer localhostServer = InAppLocalhostServer();
  @override
  void initState() {
    localhostServer.start();
    super.initState();
  }

  @override
  void dispose() {
    localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.shippingAddressBloc,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
              ),
              Text(
                "주소 찾기",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 22.0),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: BlocBuilder<ShippingAddressBloc, ShippingAddressState>(
          builder: (context, state) {
            return InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "http://localhost:8080/assets/daum_address.html")),
              onWebViewCreated: (InAppWebViewController controller) {
                controller.addJavaScriptHandler(
                    handlerName: 'handlerAddr',
                    callback: (args) async {
                      context
                          .read<ShippingAddressBloc>()
                          .add(SetAddressEvent(addressInfo: args[0]));
                      await localhostServer.close();
                      Navigator.pop(context);
                    });
              },
              onLoadStop: (InAppWebViewController controller, Uri? uri) {},
              onConsoleMessage: (InAppWebViewController controller,
                  ConsoleMessage consoleMessage) {},
            );
          },
        ),
      ),
    );
  }
}
