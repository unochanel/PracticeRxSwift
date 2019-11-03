struct AnyObserver<Element>: ObserverType {
    private let eventHandler: (Event<Element>) -> ()
    typealias BagType = Bag<(Event<Element>) -> ()>
    
    init(eventHandler: @escaping (Event<Element>) -> ()) {
        self.eventHandler = eventHandler
    }
    
    func on(_ event: Event<Element>) {
        eventHandler(event)
    }
}
