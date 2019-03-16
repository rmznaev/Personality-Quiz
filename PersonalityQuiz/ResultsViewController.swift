//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Ramazan Abdullayev on 3/10/19.
//  Copyright © 2019 Ramazan Abdullayev. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculatePersonalityResult()
        
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map { $0.type }
//        let frequentAnswersSorted = frequencyOfAnswers.sorted(by:
//        { (pairOne, pairTwo) -> Bool in
//            return pairOne.value > pairTwo.value
//        })
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
        navigationItem.hidesBackButton = true
    }

}
