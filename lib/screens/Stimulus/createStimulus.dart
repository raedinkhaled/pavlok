import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pavlok/cubits/stimuli/cubit/stimulus_cubit.dart';

class CreateStimulusScreen extends StatelessWidget {
  static const String routeName = '/create';
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => CreateStimulusScreen(),
        settings: RouteSettings(name: routeName));
  }

  void _onAddButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<StimulusCubit>().createStimulus(
            _typeController.text.toString(),
            int.tryParse(_valueController.text) ?? 0,
            _reasonController.text.toString(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/logo2.svg',
                height: 50,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'PAVLOK',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_on_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person_outline_rounded,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => StimulusCubit(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _typeController,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Type is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _valueController,
                      decoration: InputDecoration(
                        labelText: 'Value',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Value is required';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        labelText: 'Reason',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Reason is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32),
                    Align(
                      child: SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<StimulusCubit, StimulusState>(
                          listener: (context, state) {
                            if (state is StimulusCreated) {
                              Navigator.popAndPushNamed(context, '/');
                            } else if (state is StimulusError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () => _onAddButtonPressed(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Add Stimulus',
                                style: TextStyle(
                                    color: Theme.of(context).cardColor),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
