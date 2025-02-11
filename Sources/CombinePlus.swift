import Foundation
@_exported import Combine

public extension Publisher where Failure == Never {
    func weakAssign<T: AnyObject>(to keyPath: ReferenceWritableKeyPath<T, Output>, on object: T) -> AnyCancellable {
        receive(on: DispatchQueue.main).sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
    
    func weakSink<T: AnyObject>(_ function: @escaping (T) -> (Self.Output) -> Void, on object: T) -> AnyCancellable {
        sink { [weak object] value in
            guard let object = object else { return }
            
            function(object)(value)
        }
    }
}

public extension Publisher where Output == String?, Failure == Never {
    func combineAndFilterDuplicate<T: AnyObject>(with publisher: Published<String?>.Publisher, to keyPath: ReferenceWritableKeyPath<T, Output>, on object: T) -> AnyCancellable {
        self.combineLatest(publisher)
            .filter { $0.0 != $0.1 }
            .filter { $0.0 != "" }
            .sink { [unowned object] value, _ in
                object[keyPath: keyPath] = value
            }
    }
}

