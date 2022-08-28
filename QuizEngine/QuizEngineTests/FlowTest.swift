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
        
    func test_start_withNoQuestions_doesNotRouteToQuestions_v2() {
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
        
    func test_start_withOneQuestion_routesToQuestion_v2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
        
    func test_start_withOneQuestion_routesToCorrectQuestion_v3() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
        
    func test_start_withTwoQuestions_routesToFirstQuestion_v2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
        
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice_v2() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        
        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    class RouterSpy: Router {
        var answerCallback: (String) -> Void = { _ in }
        var routedQuestions: [String] = []

        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
