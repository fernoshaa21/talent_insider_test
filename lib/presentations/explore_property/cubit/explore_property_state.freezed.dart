// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_property_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExplorePropertyState {

 ExplorePropertyStatus get status; PropertiesResponse? get properties; PropertiesSearchResponse? get searchProperties; LocationsPropertiesResponse? get locationProperties; String? get errorMessage;
/// Create a copy of ExplorePropertyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExplorePropertyStateCopyWith<ExplorePropertyState> get copyWith => _$ExplorePropertyStateCopyWithImpl<ExplorePropertyState>(this as ExplorePropertyState, _$identity);

  /// Serializes this ExplorePropertyState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExplorePropertyState&&(identical(other.status, status) || other.status == status)&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.searchProperties, searchProperties) || other.searchProperties == searchProperties)&&(identical(other.locationProperties, locationProperties) || other.locationProperties == locationProperties)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,properties,searchProperties,locationProperties,errorMessage);

@override
String toString() {
  return 'ExplorePropertyState(status: $status, properties: $properties, searchProperties: $searchProperties, locationProperties: $locationProperties, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ExplorePropertyStateCopyWith<$Res>  {
  factory $ExplorePropertyStateCopyWith(ExplorePropertyState value, $Res Function(ExplorePropertyState) _then) = _$ExplorePropertyStateCopyWithImpl;
@useResult
$Res call({
 ExplorePropertyStatus status, PropertiesResponse? properties, PropertiesSearchResponse? searchProperties, LocationsPropertiesResponse? locationProperties, String? errorMessage
});




}
/// @nodoc
class _$ExplorePropertyStateCopyWithImpl<$Res>
    implements $ExplorePropertyStateCopyWith<$Res> {
  _$ExplorePropertyStateCopyWithImpl(this._self, this._then);

  final ExplorePropertyState _self;
  final $Res Function(ExplorePropertyState) _then;

/// Create a copy of ExplorePropertyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? properties = freezed,Object? searchProperties = freezed,Object? locationProperties = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExplorePropertyStatus,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as PropertiesResponse?,searchProperties: freezed == searchProperties ? _self.searchProperties : searchProperties // ignore: cast_nullable_to_non_nullable
as PropertiesSearchResponse?,locationProperties: freezed == locationProperties ? _self.locationProperties : locationProperties // ignore: cast_nullable_to_non_nullable
as LocationsPropertiesResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExplorePropertyState].
extension ExplorePropertyStatePatterns on ExplorePropertyState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExplorePropertyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExplorePropertyState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExplorePropertyState value)  $default,){
final _that = this;
switch (_that) {
case _ExplorePropertyState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExplorePropertyState value)?  $default,){
final _that = this;
switch (_that) {
case _ExplorePropertyState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExplorePropertyStatus status,  PropertiesResponse? properties,  PropertiesSearchResponse? searchProperties,  LocationsPropertiesResponse? locationProperties,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExplorePropertyState() when $default != null:
return $default(_that.status,_that.properties,_that.searchProperties,_that.locationProperties,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExplorePropertyStatus status,  PropertiesResponse? properties,  PropertiesSearchResponse? searchProperties,  LocationsPropertiesResponse? locationProperties,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ExplorePropertyState():
return $default(_that.status,_that.properties,_that.searchProperties,_that.locationProperties,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExplorePropertyStatus status,  PropertiesResponse? properties,  PropertiesSearchResponse? searchProperties,  LocationsPropertiesResponse? locationProperties,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ExplorePropertyState() when $default != null:
return $default(_that.status,_that.properties,_that.searchProperties,_that.locationProperties,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExplorePropertyState extends ExplorePropertyState {
  const _ExplorePropertyState({this.status = ExplorePropertyStatus.initial, this.properties, this.searchProperties, this.locationProperties, this.errorMessage}): super._();
  factory _ExplorePropertyState.fromJson(Map<String, dynamic> json) => _$ExplorePropertyStateFromJson(json);

@override@JsonKey() final  ExplorePropertyStatus status;
@override final  PropertiesResponse? properties;
@override final  PropertiesSearchResponse? searchProperties;
@override final  LocationsPropertiesResponse? locationProperties;
@override final  String? errorMessage;

/// Create a copy of ExplorePropertyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExplorePropertyStateCopyWith<_ExplorePropertyState> get copyWith => __$ExplorePropertyStateCopyWithImpl<_ExplorePropertyState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExplorePropertyStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExplorePropertyState&&(identical(other.status, status) || other.status == status)&&(identical(other.properties, properties) || other.properties == properties)&&(identical(other.searchProperties, searchProperties) || other.searchProperties == searchProperties)&&(identical(other.locationProperties, locationProperties) || other.locationProperties == locationProperties)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,properties,searchProperties,locationProperties,errorMessage);

@override
String toString() {
  return 'ExplorePropertyState(status: $status, properties: $properties, searchProperties: $searchProperties, locationProperties: $locationProperties, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ExplorePropertyStateCopyWith<$Res> implements $ExplorePropertyStateCopyWith<$Res> {
  factory _$ExplorePropertyStateCopyWith(_ExplorePropertyState value, $Res Function(_ExplorePropertyState) _then) = __$ExplorePropertyStateCopyWithImpl;
@override @useResult
$Res call({
 ExplorePropertyStatus status, PropertiesResponse? properties, PropertiesSearchResponse? searchProperties, LocationsPropertiesResponse? locationProperties, String? errorMessage
});




}
/// @nodoc
class __$ExplorePropertyStateCopyWithImpl<$Res>
    implements _$ExplorePropertyStateCopyWith<$Res> {
  __$ExplorePropertyStateCopyWithImpl(this._self, this._then);

  final _ExplorePropertyState _self;
  final $Res Function(_ExplorePropertyState) _then;

/// Create a copy of ExplorePropertyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? properties = freezed,Object? searchProperties = freezed,Object? locationProperties = freezed,Object? errorMessage = freezed,}) {
  return _then(_ExplorePropertyState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExplorePropertyStatus,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as PropertiesResponse?,searchProperties: freezed == searchProperties ? _self.searchProperties : searchProperties // ignore: cast_nullable_to_non_nullable
as PropertiesSearchResponse?,locationProperties: freezed == locationProperties ? _self.locationProperties : locationProperties // ignore: cast_nullable_to_non_nullable
as LocationsPropertiesResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
