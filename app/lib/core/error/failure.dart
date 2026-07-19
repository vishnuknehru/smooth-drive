/// Domain-level failures. Repositories throw these; controllers catch them
/// into error states with user-facing copy.
sealed class Failure implements Exception {
  const Failure(this.message);

  /// User-presentable description.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Timeouts, DNS, refused connections — anything before an HTTP status.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Cannot reach the SmoothDrive server']);
}

/// 422 — the request itself was rejected.
final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Invalid route request']);
}

/// 502 — backend is up but its routing/map providers are not.
final class UpstreamFailure extends Failure {
  const UpstreamFailure([
    super.message = 'Route service is temporarily unavailable',
  ]);
}

/// 404 on /api/position/upcoming — the backend restarted and lost the
/// route cache. Recoverable by re-analyzing.
final class RouteExpiredFailure extends Failure {
  const RouteExpiredFailure([super.message = 'Route session expired']);
}

final class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong']);
}
