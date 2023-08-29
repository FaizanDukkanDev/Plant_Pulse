import 'package:plantpulse/app_theme.dart';
import 'package:plantpulse/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key, required this.pageTitle,  this.isPageTitle=true}) : super(key: key);

  final String pageTitle;
  final bool isPageTitle;

  @override
  TabPageState createState() => TabPageState();
}

class TabPageState<T extends TabPage> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  List<Widget> _tabListView = [];
  ScrollController _scrollController = ScrollController();

  List<Widget> get tabListView => _tabListView;
  ScrollController get scrollController => _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: AppTheme.appTheme.scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            buildTabListView(),
            widget.isPageTitle? TabAppBar(
              scrollController: _scrollController,
              title: widget.pageTitle,
            ):SizedBox.shrink(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabListView() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
        bottom: 70 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: _tabListView.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return _tabListView[index];
      },
    );
  }
}
