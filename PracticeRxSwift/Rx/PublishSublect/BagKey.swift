struct BagKey: Hashable {
    let rawValue: UInt64
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

