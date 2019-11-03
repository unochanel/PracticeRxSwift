class ObservableSequence<Sequence: Swift.Sequence, Element>: Observable<Element> {
    let elements: Sequence
    
    init(elements: Sequence) {
        self.elements = elements
    }
    
    override func subscribe<Observer: ObserverType>(_ observer: Observer) where Observer.Element == Element {
        let sink = ObservableSequenceSink(parent: self, observer: observer)
        sink.run()
    }
    
    
    class ObservableSequenceSink<Sequence: Swift.Sequence, Observer: ObserverType, Element> {
        let parent: ObservableSequence<Sequence, Element>
        let observer: Observer
        
        init(parent: ObservableSequence<Sequence, Element>, observer: Observer) {
            self.parent = parent
            self.observer = observer
        }
        
        func run() {
            parent.elements.forEach { element in
                if let next = element as? Observer.Element {
                    observer.on(.next(next))
                }
            }
            observer.on(.completed)
        }
    }
}
