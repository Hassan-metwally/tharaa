part of core;

class PaginatedInput extends NoParams {
  final int page;

  PaginatedInput({this.page = 1});

  Map<String, dynamic> toJson() => <String, dynamic>{'page': page};

  factory PaginatedInput.fromInput(PaginatedInput data) {
    return PaginatedInput(page: data.page);
  }

  @override
  List<Object?> get props => [page];
}
