// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regex_evaluator.dart';

// **************************************************************************
// SchemaGenerator
// **************************************************************************

base class RegexEvalOptions {
  factory RegexEvalOptions.fromJson(Map<String, dynamic> json) =>
      $schema.parse(json);

  RegexEvalOptions._(this._json);

  RegexEvalOptions({required String pattern}) {
    _json = {'pattern': pattern};
  }

  late final Map<String, dynamic> _json;

  static const SchemanticType<RegexEvalOptions> $schema =
      _RegexEvalOptionsTypeFactory();

  String get pattern {
    return _json['pattern'] as String;
  }

  set pattern(String value) {
    _json['pattern'] = value;
  }

  @override
  String toString() {
    return _json.toString();
  }

  Map<String, dynamic> toJson() {
    return _json;
  }
}

base class _RegexEvalOptionsTypeFactory
    extends SchemanticType<RegexEvalOptions> {
  const _RegexEvalOptionsTypeFactory();

  @override
  RegexEvalOptions parse(Object? json) {
    return RegexEvalOptions._(json as Map<String, dynamic>);
  }

  @override
  JsonSchemaMetadata get schemaMetadata => JsonSchemaMetadata(
    name: 'RegexEvalOptions',
    definition: $Schema
        .object(
          properties: {'pattern': $Schema.string()},
          required: ['pattern'],
        )
        .value,
    dependencies: [],
  );
}
