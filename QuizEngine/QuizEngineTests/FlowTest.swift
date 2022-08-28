//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Pavel Palancica on 8/28/22.
//

import Foundation
import XCTest

@testable import QuizEngine

class FlowTest: XCTestCase {
    
    func test_start_withNoQuestions_doesNotRouteToQuestions() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_v1() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_v2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q2")
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        
        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
        }
    }
}
