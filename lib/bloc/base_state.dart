import 'package:flutter/material.dart';

@immutable
abstract class BaseState {}

class InitialState extends BaseState {}

class CommonState<TModel> extends BaseState {
  final TModel model;
  final bool isLoading;
  final String? errorMessage;

  CommonState(
    this.model, {
    this.errorMessage,
    this.isLoading = false,
  });

  CommonState copyWith({
    TModel? model,
    bool isLoading = false,
    String? errorMessage,
  }) {
    return CommonState(
      model ?? this.model,
      errorMessage: errorMessage,
      isLoading: isLoading,
    );
  }
}
