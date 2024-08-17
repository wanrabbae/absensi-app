import 'package:app/controllers/app/app_cubit.dart';
import 'package:app/presentation/views/search/hora_search_delegate.dart';
import 'package:app/presentation/widgets/buttons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Row(
            children: [
              const SizedBox(width: 24),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: tr('type_here'),
                  ),
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () => handleSearch(context),
                  validator: (value) {
                    if (value?.isEmpty ?? true) return tr('keyword_empty');
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 8),
              HoraButton(
                onPressed: () => handleSearch(context),
                child: const Text('Cari'),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }

  handleSearch(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      if (autoValidateMode == AutovalidateMode.disabled) {
        setState(() {
          autoValidateMode = AutovalidateMode.always;
        });
      }
      return;
    }

    final query = controller.text;
    showSearch(
      context: context,
      delegate: HoraSearchDelegate(
        context.read(),
        idPerusahaan: context.read<AppCubit>().state.currentUser!.perusahaanId!,
        searchFieldLabel: tr('type_here'),
      ),
      query: query,
    );
  }
}
