import 'package:flutter/material.dart';
import 'package:hr/features/companies/presentation/widgets/basic_info_filled_widget.dart';

class CompanyDepartmentProvider extends StatelessWidget {
  const CompanyDepartmentProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompanyDepartmentForm();
  }
}

class CompanyDepartmentForm extends StatefulWidget {
  const CompanyDepartmentForm({super.key});

  @override
  State<CompanyDepartmentForm> createState() => _CompanyDepartmentFormState();
}

class _CompanyDepartmentFormState extends State<CompanyDepartmentForm> {
  final TextEditingController _contactName = TextEditingController();
  final TextEditingController _companyEmail = TextEditingController();
  final TextEditingController _primaryMobileNumber = TextEditingController();
  final TextEditingController _secondaryMobileNumber = TextEditingController();
  final TextEditingController _landlineNumber = TextEditingController();
  final TextEditingController _faxNumber = TextEditingController();
  final TextEditingController _hrMobileNumber = TextEditingController();
  final TextEditingController _hrLandlineNumber = TextEditingController();
  final TextEditingController _hrEmail = TextEditingController();
  // late final CompanyContactCubit _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // _controller = context.read<CompanyContactCubit>();
    // _controller.contactShow(context);
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompanyBasicInfoFilledWidget(currentTab: 3, child: Placeholder());
  }

  void _initializeFields() {
    // _contactName.text = _controller.state.data?.contactName ?? '';
    // _companyEmail.text = _controller.state.data?.companyEmail ?? '';
    // _primaryMobileNumber.text = _controller.state.data?.primaryMobileNumber ?? '';
    // _secondaryMobileNumber.text = _controller.state.data?.secondaryMobileNumber ?? '';
    // _landlineNumber.text = _controller.state.data?.landlineNumber ?? '';
    // _faxNumber.text = _controller.state.data?.faxNumber ?? '';
    // _hrMobileNumber.text = _controller.state.data?.hrMobileNumber ?? '';
    // _hrLandlineNumber.text = _controller.state.data?.hrLandlineNumber ?? '';
    // _hrEmail.text = _controller.state.data?.hrEmail ?? '';
  }

  void _disposeControllers() {
    _contactName.dispose();
    _companyEmail.dispose();
    _primaryMobileNumber.dispose();
    _secondaryMobileNumber.dispose();
    _landlineNumber.dispose();
    _faxNumber.dispose();
    _hrMobileNumber.dispose();
    _hrLandlineNumber.dispose();
    _hrEmail.dispose();
  }

  Future _sendRequest() async {
    if (_formKey.currentState!.validate()) {
      // _controller.contactUpsert(
      //   context,
      //   CompanyContactModel(
      //     contactName: _contactName.text,
      //     companyEmail: _companyEmail.text,
      //     primaryMobileNumber: _primaryMobileNumber.text,
      //     secondaryMobileNumber: _secondaryMobileNumber.text,
      //     landlineNumber: _landlineNumber.text,
      //     faxNumber: _faxNumber.text,
      //     hrMobileNumber: _hrMobileNumber.text,
      //     hrLandlineNumber: _hrLandlineNumber.text,
      //     hrEmail: _hrEmail.text,
      //   ),
      // );
    }
  }
}
