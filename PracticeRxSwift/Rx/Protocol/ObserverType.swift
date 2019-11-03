protocol ObserverType {
    associatedtype Element
    func on(_ event: Event<Element>)
}
