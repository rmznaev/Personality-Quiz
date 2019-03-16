//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Ramazan Abdullayev on 3/10/19.
//  Copyright © 2019 Ramazan Abdullayev. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var singleButtonOne: UIButton!
    
    @IBOutlet weak var singleButtonTwo: UIButton!
    
    @IBOutlet weak var singleButtonThree: UIButton!
    
    @IBOutlet weak var singleButtonFour: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    
    @IBOutlet weak var multiLabelOne: UILabel!
    
    @IBOutlet weak var multiLabelTwo: UILabel!
    
    @IBOutlet weak var multiLabelThree: UILabel!
    
    @IBOutlet weak var multiLabelFour: UILabel!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedLabelOne: UILabel!
    
    @IBOutlet weak var rangedLabelTwo: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var multiSwitchOne: UISwitch!
    
    @IBOutlet weak var multiSwitchTwo: UISwitch!
    
    @IBOutlet weak var multiSwitchThree: UISwitch!
    
    @IBOutlet weak var multiSwitchFour: UISwitch!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                    ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
                    ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
                    ])
    ]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    @IBAction func singleAnswerButton(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
            
        case singleButtonOne:
            answersChosen.append(currentAnswers[0])
            
        case singleButtonTwo:
            answersChosen.append(currentAnswers[1])
            
        case singleButtonThree:
            answersChosen.append(currentAnswers[2])
            
        case singleButtonFour:
            answersChosen.append(currentAnswers[3])
            
        default:
            break
            
        }
        
        nextQuestion()
        
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitchOne.isOn {
            
            answersChosen.append(currentAnswers[0])
            
        }
        
        if multiSwitchTwo.isOn {
            
            answersChosen.append(currentAnswers[1])
            
        }
        
        if multiSwitchThree.isOn {
            
            answersChosen.append(currentAnswers[2])
            
        }
        
        if multiSwitchFour.isOn {
            
            answersChosen.append(currentAnswers[3])
            
        }
        
        nextQuestion()
        
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: Any) {
        
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
    }
    
    func nextQuestion() {
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            
            updateUI()
            
        } else {
            
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ResultsSegue" {
            
            let resultsViewController = segue.destination as! ResultsViewController
            
            resultsViewController.responses = answersChosen
            
        }
        
    }
    
    func updateUI() {
        
        singleStackView.isHidden = true
        
        multipleStackView.isHidden = true
        
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        
        let currentAnswers = currentQuestion.answers
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        if questionIndex == 0 {
            
            navigationItem.title = "First Question"
            
        } else if questionIndex == 1 {
            
            navigationItem.title = "Second Question"
            
        } else if questionIndex == 2 {
            
            navigationItem.title = "Third Question"
            
        }
        
        questionLabel.text = currentQuestion.text
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        switch currentQuestion.type {
            
        case .single:
            updateSingleStack(using: currentAnswers)
            
        case .multiple:
            updateMultipleStack(using: currentAnswers)
            
        case .ranged:
            updateRangedStack(using: currentAnswers)
            
        }
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        
        singleStackView.isHidden = false
        
        singleButtonOne.setTitle(answers[0].text, for: .normal)
        
        singleButtonTwo.setTitle(answers[1].text, for: .normal)
        
        singleButtonThree.setTitle(answers[2].text, for: .normal)
        
        singleButtonFour.setTitle(answers[3].text, for: .normal)
        
    }

    func updateMultipleStack(using answers: [Answer]) {
        
        multipleStackView.isHidden = false
        
        multiSwitchOne.isOn = false
        
        multiSwitchTwo.isOn = false
        
        multiSwitchThree.isOn = false
        
        multiSwitchFour.isOn = false
        
        multiLabelOne.text = answers[0].text
        
        multiLabelTwo.text = answers[1].text
        
        multiLabelThree.text = answers[2].text
        
        multiLabelFour.text = answers[3].text
        
    }
    
    func updateRangedStack(using answers: [Answer]) {
        
        rangedStackView.isHidden = false
        
        rangedSlider.setValue(0.5, animated: true)
        
        rangedLabelOne.text = answers.first?.text
        
        rangedLabelTwo.text = answers.last?.text
        
    }
    
}
