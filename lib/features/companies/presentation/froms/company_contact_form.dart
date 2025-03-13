import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/features/companies/cubits/company_form/company_form_cubit.dart';

class CompanyContactForm extends StatefulWidget {
  const CompanyContactForm({super.key});

  @override
  State<CompanyContactForm> createState() => _CompanyContactFormState();
}

class _CompanyContactFormState extends State<CompanyContactForm> {
  final TextEditingController _contactName = TextEditingController();
  final TextEditingController _companyEmail = TextEditingController();
  final TextEditingController _primaryMobileNumber = TextEditingController();
  final TextEditingController _secondaryMobileNumber = TextEditingController();
  final TextEditingController _landlineNumber = TextEditingController();
  final TextEditingController _faxNumber = TextEditingController();
  final TextEditingController _hrMobileNumber = TextEditingController();
  final TextEditingController _hrLandlineNumber = TextEditingController();
  final TextEditingController _hrEmail = TextEditingController();
  late final CompanyFormCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = context.read<CompanyFormCubit>();
    _initializeFields();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void _initializeFields() {
    _contactName.text = _controller.state.contact?.data?.contactName ?? '';
    _companyEmail.text = _controller.state.contact?.data?.companyEmail ?? '';
    _primaryMobileNumber.text = _controller.state.contact?.data?.primaryMobileNumber ?? '';
    _landlineNumber.text = _controller.state.contact?.data?.landlineNumber ?? '';
    _faxNumber.text = _controller.state.contact?.data?.faxNumber ?? '';
    _hrMobileNumber.text = _controller.state.contact?.data?.hrMobileNumber ?? '';
    _hrLandlineNumber.text = _controller.state.contact?.data?.hrLandlineNumber ?? '';
    _hrEmail.text = _controller.state.contact?.data?.hrEmail ?? '';
  }

  void _disposeControllers() {
    _contactName.dispose();
    _companyEmail.dispose();
    _primaryMobileNumber.dispose();
    _secondaryMobileNumber.dispose();
    _faxNumber.dispose();
    _hrMobileNumber.dispose();
    _hrLandlineNumber.dispose();
    _hrEmail.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {}
  }
}
