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
      params.description,
      params.address,
      params.price,
      params.image,
      params.buildingArea,
      params.landArea,
    );
  }
}

class AddPropertiesParam extends Equatable {
  final String type;
  final String status;
  final String description;
  final String address;
  final int price;
  final String image;
  final int buildingArea;
  final int landArea;

  const AddPropertiesParam({
    required this.type,
    required this.status,
    required this.description,
    required this.address,
    required this.price,
    required this.image,
    required this.buildingArea,
    required this.landArea,
  });

  @override
  List<Object?> get props => [
    type,
    status,
    description,
    address,
    price,
    image,
    buildingArea,
    landArea,
  ];
}
