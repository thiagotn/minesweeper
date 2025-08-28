import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionFooter extends StatefulWidget {
  @override
  _VersionFooterState createState() => _VersionFooterState();
}

class _VersionFooterState extends State<VersionFooter> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _getVersion();
  }

  Future<void> _getVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = 'version: ${packageInfo.version}';
      });
    } catch (e) {
      setState(() {
        _version = 'v1.0.3';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        _version,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'TickingTimebombBB',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

