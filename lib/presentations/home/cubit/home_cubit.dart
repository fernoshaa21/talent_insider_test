// HomeCubit.dart

import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trimitra_putra_mandiri/presentations/home/cubit/home_state.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(HomeState());

  // Dummy location (nanti bisa di sesuaikan dengan lokasi perusahaan dan ini yang saya pakai adalah lokasi rumah saya)
  static const _dummyLocation = LatLng(-6.357787, 106.561748);

  Future<void> getLocationAndSelfie() async {
    //Permission
    final permission = await _checkLocationPermission();

    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      emit(state.copyWith(status: "Permission Denied"));
      return;
    }

    // getCurrentLocation
    Position position = await _getCurrentLocation();

    final selfie = await _takeSelfie();

    // Validation Radius 100M
    bool isInRadius = _isWithinRadius(position, _dummyLocation);

    String selfiePath = selfie.path;

    final prefs = await SharedPreferences.getInstance();
    final isAbsen = prefs.getBool('isAbsen') ?? false;

    if (isAbsen) {
      emit(
        state.copyWith(
          username: "John Doe",
          time: DateTime.now().toString(),
          location: position.toString(),
          status: "Sudah Absen",
          selfiePath: selfiePath,
        ),
      );
    } else {
      emit(
        state.copyWith(
          username: "John Doe",
          time: DateTime.now().toString(),
          location: position.toString(),
          status: isInRadius ? "Absen Sekarang" : "Terlalu Jauh",
          selfiePath: selfiePath,
        ),
      );
    }
  }

  Future<void> removeSelfie() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('selfiePath');
    await prefs.remove('time');
    await prefs.remove('location');
    await prefs.remove('status');

    emit(
      state.copyWith(
        selfiePath: null,
        time: null,
        location: null,
        status: null,
      ),
    );
  }

  Future<LocationPermission> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  // Mendapatkan posisi lokasi pengguna
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  bool _isWithinRadius(Position position, LatLng target) {
    final distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      target.latitude,
      target.longitude,
    );
    return distance <= 100;
  }

  Future<File> _takeSelfie() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception("Selfie not taken");
    }
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    return HomeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    return state.toJson();
  }
}
