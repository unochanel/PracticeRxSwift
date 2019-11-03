struct Bag<T> {
    var dictionary: [BagKey: T]?
    private var nextKey = BagKey(rawValue: 0)
    
    //structの値を変換する時にmutatingfuncを使うことで出来る
    mutating func insert(_ element: T) {
        let key = nextKey
        nextKey = BagKey(rawValue: nextKey.rawValue + 1)
        
        if let _ = dictionary {
            dictionary![key] = element
        } else {
            dictionary = [key: element]
        }
    }
}
