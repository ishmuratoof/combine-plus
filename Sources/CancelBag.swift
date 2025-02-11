import Combine

public final class CancelBag {
    
    public init(subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.subscriptions = subscriptions
    }
    
    @resultBuilder
    public enum Builder {
        public static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
    
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    public func cancel() {
        subscriptions.removeAll()
    }
    
    public func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        subscriptions.formUnion(cancellables())
    }
}

public extension AnyCancellable {
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}
