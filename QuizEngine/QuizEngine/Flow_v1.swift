//
//  Flow_v1.swift
//  QuizEngine
//
//  Created by Pavel Palancica on 8/28/22.
//

import Foundation

protocol Router_v1 {
    func routeTo(question: String)
}

class Flow_v1 {
    let router: Router_v1
    let questions: [String]
    
    init(questions: [String], router: Router_v1) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion)
        }
    }
}
