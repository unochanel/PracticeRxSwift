class ConnectableObservable<Element>: Observable<Element> {
    private let source: Observable<Element>
    private let subject: PublishSubject<Element>
    
    init(source: Observable<Element>, subject: PublishSubject<Element>) {
        self.source = source
        self.subject = subject
    }
    
    override func subscribe<Observer>(_ observer: Observer) where Element == Observer.Element, Observer : ObserverType {
        subject.subscribe(observer)
    }
    
    func connect() {
        source.subscribe(subject)
    }
}
