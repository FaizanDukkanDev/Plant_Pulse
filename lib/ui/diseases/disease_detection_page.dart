import 'package:plantpulse/ui/diseases/diagnosis.dart';
import 'package:plantpulse/ui/diseases/disease_card.dart';
import 'package:plantpulse/ui/diseases/view_image_region.dart';
import 'package:plantpulse/ui/widgets/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiseaseDetectionPage extends TabPage {
  const DiseaseDetectionPage({required Key key, required String pageTitle})
      : super(key: key, pageTitle: pageTitle);

  @override
  _DiseaseDetectionPageState createState() => _DiseaseDetectionPageState();
}

class _DiseaseDetectionPageState extends TabPageState<DiseaseDetectionPage> {
  Diagnosis _diagnosis = Diagnosis();

  void initState() {
    tabListView.add(ViewImageRegion(diagnosis: _diagnosis));
    tabListView.add(DiseaseCard());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Diagnosis>.value(
      value: _diagnosis,
      child: super.build(context),
    );
  }
}
