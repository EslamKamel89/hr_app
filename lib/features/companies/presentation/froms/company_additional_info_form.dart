import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hr/core/models/pass_by_reference.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';

class CompanyAdditionalProvider extends StatelessWidget {
  const CompanyAdditionalProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompanyAdditionalForm();
  }
}

class CompanyAdditionalForm extends StatefulWidget {
  const CompanyAdditionalForm({super.key});

  @override
  State<CompanyAdditionalForm> createState() => _CompanyAdditionalFormState();
}

class _CompanyAdditionalFormState extends State<CompanyAdditionalForm> {
  final PassByReference<File?> _logo = PassByReference(null);
  // late final CompanyContactCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompanyBasicInfoFilledWidget(currentTab: 2, child: Placeholder());
  }

  void _initializeFields() {}

  void _disposeControllers() {}

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {}
  }
}
