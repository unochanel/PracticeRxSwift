class Just<Element>: Observable<Element> {
    private let element: Element
    
    init(element: Element) {
        self.element = element
    }
    
    override func subscribe<Observer>(_ observer: Observer) where Element == Observer.Element, Observer : ObserverType {
        observer.on(.next(element))
        observer.on(.completed)
    }
}
