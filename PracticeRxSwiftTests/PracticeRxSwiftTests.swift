//
//  PracticeRxSwiftTests.swift
//  PracticeRxSwiftTests
//
//  Created by 宇野凌平 on 2019/11/03.
//  Copyright © 2019 宇野凌平. All rights reserved.
//

import XCTest
@testable import PracticeRxSwift

class PracticeRxSwiftTests: XCTestCase {
    
    func testExample() {
        let exp = expectation(description: "foo")
        exp.expectedFulfillmentCount = 1
        
        let stram = Observable.just(2)
            .map {
                exp.fulfill()
                return $0 * 10
        }
        .publish()
        
        let observerA = AnyObserver<Int> { event in
            switch event {
            case .next(let element):
                XCTAssertEqual(element, 20)
            case .completed:
                break
            case .error:
                break
            }
        }
        
        let _ = stram.subscribe(observerA)
        
        let observerB = AnyObserver<Int> { event in
            switch event {
            case .next(let element):
                XCTAssertEqual(element, 20)
            case .completed:
                break
            case .error:
                break
            }
        }
        
        let _ = stram.subscribe(observerB)
        stram.connect()
        
        wait(for: [exp], timeout: 1.0)
    }

}
