class ApiResponse<T> {
  final bool success;
  final String type;
  final String message;
  final T data;

  ApiResponse({
    required this.success,
    required this.type,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'],
      type: json['type'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'success': success,
      'type': type,
      'message': message,
      'data': toJsonT(data),
    };
  }
}
