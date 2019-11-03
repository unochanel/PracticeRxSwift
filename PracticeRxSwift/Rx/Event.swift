enum Event<Element> {
    case next(Element)
    case completed
    case error(Error)
}
