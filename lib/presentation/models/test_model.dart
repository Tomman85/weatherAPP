import 'package:json_annotation/json_annotation.dart';

part 'test_model.g.dart';

@JsonSerializable()
class TestModel {
  @JsonKey(name: "formatted")
  String? formatted;

  TestModel({required this.formatted});

  factory TestModel.fromJson(Map<String, dynamic> json) =>
      _$TestModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}
