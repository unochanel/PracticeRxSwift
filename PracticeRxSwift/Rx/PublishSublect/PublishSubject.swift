class PublishSubject<Element>: Observable<Element>, ObserverType {
    typealias Observers = AnyObserver<Element>.BagType
    
    private var observers = Observers()
    
    func on(_ event: Event<Element>) {
        switch event {
        case .next:
            dispatch(event)
        case .completed:
            dispatch(event)
        case .error:
            break
        }
    }
    
    // onNextされるたびにonが呼ばれる
    func onNext(_ element: Element) {
        on(.next(element))
    }
    
    func onCompleted() {
        on(.completed)
    }
    
    func dispatch(_ event: Event<Element>) {
        guard let values = observers.dictionary?.values else { return }
        for handler in values {
            handler(event)
        }
    }
    
    override func subscribe<Observer>(_ observer: Observer) where Element == Observer.Element, Observer : ObserverType {
        //subscribeされるたびに、insertでDictionaryで登録
        observers.insert(observer.on)
    }
}
