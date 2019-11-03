class Map<SourceType, ResultType>: Observable<ResultType> {
    typealias Element = ResultType
    //SourceTypeは受け取る型, ResultTypeは返す型
    typealias Transform = (SourceType) -> ResultType
    
    private let source: Observable<SourceType>
    private let transform: Transform
    
    init(source: Observable<SourceType>, transform: @escaping Transform) {
        self.source = source
        self.transform = transform
    }
    
    override func subscribe<Observer>(_ observer: Observer) where Element == Observer.Element, Observer : ObserverType {
        let sink = MapSink(transform: transform, observer: observer)
        source.subscribe(sink)
    }
    
    class MapSink<SourceType, Observer: ObserverType>: ObserverType {
        typealias Element = SourceType
        typealias Transform = (SourceType) -> ResultType
        typealias ResultType = Observer.Element
        
        private let transform: Transform
        private let observer: Observer
        
        init(transform: @escaping Transform, observer: Observer) {
            self.transform = transform
            self.observer = observer
        }
        
        func on(_ event: Event<SourceType>) {
            switch event {
            case .next(let element):
                let mappedElement = transform(element)
                observer.on(.next(mappedElement))
            case .completed:
                observer.on(.completed)
            case .error:
                break
            }
        }
    }
}
