import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/explore_property_cubit.dart';
import '../cubit/explore_property_state.dart';

class AddPropertyView extends StatefulWidget {
  const AddPropertyView({super.key});

  @override
  _AddPropertyViewState createState() => _AddPropertyViewState();
}

class _AddPropertyViewState extends State<AddPropertyView> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk tiap inputan
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _buildingAreaController = TextEditingController();
  final TextEditingController _landAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Property"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed('home');
          },
        ),
      ),
      body: BlocConsumer<ExplorePropertyCubit, ExplorePropertyState>(
        listener: (context, state) {
          if (state.status == ExplorePropertyStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Property added successfully!")),
            );
          } else if (state.status == ExplorePropertyStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "An error occurred"),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Property Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a property name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image URL (Base64)',
                    ),
                  ),
                  TextFormField(
                    controller: _buildingAreaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Building Area (m²)',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the building area';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _landAreaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Land Area (m²)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the land area';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Call the addProperty method
                          context.read<ExplorePropertyCubit>().addProperty(
                            type: 'rumah',
                            status: 'new',
                            name: _nameController.text,
                            description: _descriptionController.text,
                            address: _addressController.text,
                            price: int.parse(_priceController.text),
                            image: _imageController.text,
                            buildingArea: int.parse(
                              _buildingAreaController.text,
                            ),
                            landArea: int.parse(_landAreaController.text),
                          );
                        }
                      },
                      child: Text('Add Property'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
