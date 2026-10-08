/// The lifecycle of one piece of remotely loaded data.
///
/// Stores keep an optional `LoadState`; `nil` means "not requested yet".
enum LoadState<Value: Sendable, Failure: Error & Sendable>: Sendable {
    case loading
    case success(Value)
    case failure(Failure)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }

    var value: Value? {
        if case .success(let value) = self { return value }
        return nil
    }
}

extension LoadState: Equatable where Value: Equatable, Failure: Equatable {}
