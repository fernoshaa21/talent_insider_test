import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain.dart';

class AddPropertiesUsecase
    implements UseCase<AddPropertyResponse, AddPropertiesParam> {
  final PropertiesRepository repository;

  AddPropertiesUsecase(this.repository);

  @override
  Future<Either<Failure, AddPropertyResponse>> call(AddPropertiesParam params) {
    return repository.addProperties(
      params.type,
      params.status,
      params.name,
      params.description,
      params.address,
      params.price,
      params.image ?? '',
      params.buildingArea,
      params.landArea,
    );
  }
}

class AddPropertiesParam extends Equatable {
  final String type;
  final String status;
  final String name;
  final String description;
  final String address;
  final int price;
  String? image;
  final int buildingArea;
  final int landArea;

  AddPropertiesParam({
    required this.type,
    required this.status,
    required this.name,
    required this.description,
    required this.address,
    required this.price,
    this.image,
    required this.buildingArea,
    required this.landArea,
  });

  @override
  List<Object?> get props => [
    type,
    status,
    name,
    description,
    address,
    price,
    image,
    buildingArea,
    landArea,
  ];
}
