class Observable<Element> {
    func subscribe<Observer: ObserverType>(_ observer: Observer) where Observer.Element == Element {
        fatalError()
    }
}

extension Observable {
    static func just(_ element: Element) -> Observable {
        return Just(element: element)
    }
}

extension Observable {
    static func of(_ element: Element ...) -> Observable {
        return ObservableSequence(elements: element)
    }
}

extension Observable {
    // Elementから別の型のElementに変換後で返すとObservableを流す
    // map自身がクロージャーを引数で受け取るから、{ $0 * 10 }と言ったようにクロージャーで書くことが出来る
    // クロージャーへの変換が終わり次第、Observable型で値を返す
    func map(_ handler: @escaping ((_ element: Element) -> Element)) -> Observable {
        return Map(source: self, transform: handler)
    }
}

extension Observable {
    func subscribe(onNext: ((_ element: Element) -> ())? = nil, onCompleted: (() -> ())? = nil) {
        let observer = AnyObserver<Element> { event in
            switch event {
            case .next(let value):
                onNext?(value)
            case .completed:
                onCompleted?()
            case .error:
                break
            }
        }
        subscribe(observer)
    }
}

extension Observable {
    func publish() -> ConnectableObservable<Element> {
        let subject = PublishSubject<Element>()
        return ConnectableObservable(source: self, subject: subject)
    }
}
