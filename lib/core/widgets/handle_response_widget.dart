// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hr/core/enums/response_type.dart';
import 'package:hr/utils/styles/styles.dart';

class HandleResponseWidget extends StatelessWidget {
  const HandleResponseWidget({
    required this.response,
    required this.child,
    super.key,
    this.tryAgain,
    this.errorMessage,
    this.showNoData = false,
    this.noDataMessage,
  });
  final Widget child;
  final VoidCallback? tryAgain;
  final String? errorMessage;
  final ResponseEnum response;
  final bool? showNoData;
  final String? noDataMessage;
  @override
  Widget build(BuildContext context) {
    if (showNoData == true) {
      return Center(
        child: txt(
          noDataMessage ?? 'No data found',
          e: St.bold16,
          textAlign: TextAlign.center,
        ),
      );
    }
    if (response == ResponseEnum.success) return child;
    if (response == ResponseEnum.loading) {
      return Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          txt(
            errorMessage ?? 'An Error Occurred.',
            e: St.bold16,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          if (tryAgain != null)
            ElevatedButton(
              onPressed: tryAgain!,
              child: txt(
                'Try Again',
                e: St.bold16,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
