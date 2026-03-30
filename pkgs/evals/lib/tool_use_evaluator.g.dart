// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_use_evaluator.dart';

// **************************************************************************
// SchemaGenerator
// **************************************************************************

base class ToolUseEvalOptions {
  factory ToolUseEvalOptions.fromJson(Map<String, dynamic> json) =>
      $schema.parse(json);

  ToolUseEvalOptions._(this._json);

  ToolUseEvalOptions({required List<String> expectedTools}) {
    _json = {'expectedTools': expectedTools};
  }

  late final Map<String, dynamic> _json;

  static const SchemanticType<ToolUseEvalOptions> $schema =
      _ToolUseEvalOptionsTypeFactory();

  List<String> get expectedTools {
    return (_json['expectedTools'] as List).cast<String>();
  }

  set expectedTools(List<String> value) {
    _json['expectedTools'] = value;
  }

  @override
  String toString() {
    return _json.toString();
  }

  Map<String, dynamic> toJson() {
    return _json;
  }
}

base class _ToolUseEvalOptionsTypeFactory
    extends SchemanticType<ToolUseEvalOptions> {
  const _ToolUseEvalOptionsTypeFactory();

  @override
  ToolUseEvalOptions parse(Object? json) {
    return ToolUseEvalOptions._(json as Map<String, dynamic>);
  }

  @override
  JsonSchemaMetadata get schemaMetadata => JsonSchemaMetadata(
    name: 'ToolUseEvalOptions',
    definition: $Schema
        .object(
          properties: {'expectedTools': $Schema.list(items: $Schema.string())},
          required: ['expectedTools'],
        )
        .value,
    dependencies: [],
  );
}
