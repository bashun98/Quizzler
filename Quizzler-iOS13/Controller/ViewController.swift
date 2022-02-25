//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Евгений Башун on 31.01.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    private var timer = Timer()
    private var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let userAnswer = sender.currentTitle else {return}
        let check = quizBrain.checkAnswer(userAnswer)
        
        if check {
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc private func updateUI() {
        [firstAnswer, secondAnswer, thirdAnswer].forEach {
            $0?.backgroundColor = .clear
        }
        scoreLabel.text = "Score = \(quizBrain.getScore())"
        questionLabel.text = quizBrain.getQuestionText()
        firstAnswer.setTitle(quizBrain.getButtonTitle(for: 0), for: .normal)
        secondAnswer.setTitle(quizBrain.getButtonTitle(for: 1), for: .normal)
        thirdAnswer.setTitle(quizBrain.getButtonTitle(for: 2), for: .normal)
        progressBar.progress = quizBrain.getProgress()
    }
    
}

