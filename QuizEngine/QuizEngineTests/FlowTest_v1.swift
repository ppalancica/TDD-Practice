//
//  FlowTest_v1.swift
//  QuizEngineTests
//
//  Created by Pavel Palancica on 8/28/22.
//

import Foundation
import XCTest

@testable import QuizEngine

class FlowTest_v1: XCTestCase {
    
    func test_start_withNoQuestions_doesNotRouteToQuestions_v1() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: [], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withNoQuestions_doesNotRouteToQuestions_v2() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: [], router: router)
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToQuestion_v1() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToQuestion_v2() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_v1() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_v2() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q2")
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_v3() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion_v1() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion_v2() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1", "Q2"], router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice_v1() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice_v2() {
        let router = RouterSpy()
        let sut = Flow_v1(questions: ["Q1", "Q2"], router: router)

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
        
    class RouterSpy: Router_v1 {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        var routedQuestions: [String] = []

        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
            routedQuestions.append(question)
        }
    }
    
//    class RouterSpy: Router {
//        var routedQuestions: [String] = []
//
//        func routeTo(question: String) {
//            routedQuestions.append(question)
//        }
//    }
}
