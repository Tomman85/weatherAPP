
import 'package:json_annotation/json_annotation.dart';
import 'package:weather/presentation/models/test_model.dart';
part 'single_test_response.g.dart';

@JsonSerializable()
class SingleTestResponse{




  @JsonKey(name:'results')
  TestModel testModel;
  SingleTestResponse(this.testModel);


  factory SingleTestResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleTestResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SingleTestResponseToJson(this);




}