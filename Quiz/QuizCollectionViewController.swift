//
//  QuizCollectionViewController.swift
//  Quiz
//
//  Created by Chinsyo on 2017/6/22.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "QuizCollectionViewCell"

class QuizCollectionViewController: UICollectionViewController {

    // MARK: - Property
    var questions = JSONFactory.questions(with: "zquestions")
        
    lazy var progressLabel: UILabel = {
        $0.font = UIFont(name: "Avenir-Black", size: 36)
        $0.text = "02:00"
        $0.textColor = UIColor.black
        $0.textAlignment = .center
        return $0
    }(UILabel())

    lazy var submitButton: UIButton = {
        $0.backgroundColor = UIColor.white
        $0.titleLabel?.font = UIFont(name: "Avenir", size: 24)
        $0.setTitle("Submit", for: .normal)
        $0.setTitleColor(Constant.Color.blue, for: .normal)
        $0.setTitleColor(UIColor.lightGray, for: .disabled)
        $0.addTarget(self, action: #selector(didTappedSubmitButton), for: .touchUpInside)
        $0.isEnabled = false
        return $0
    }(UIButton(type: .custom))
    
    var timer = Timer()
    var remain: TimeInterval = 120

    // MARK: - Life Cycle
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.collectionView?.backgroundColor = Constant.Color.blue
        self.collectionView?.isPagingEnabled = true

        questions.shuffle()
        for question in questions {
            question.options.shuffle()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: nil) { notify in
            
            self.timer.fireDate = Date.distantFuture
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { notify in
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let modal = storyboard.instantiateViewController(withIdentifier: "modal") as! ModalViewController
            modal.modalPresentationStyle = .custom
            modal.transitioningDelegate = self
            if self.remain >= 120 {
                modal.content = "You have 2 minutes to finish the quiz."
                modal.action = "Start"
            } else {
                modal.content = "Continue the quiz?"
                modal.action = "Continue"
            }
            
            modal.buttonHandler = { _ in
                self.runTimer()
            }
            self.present(modal, animated: true, completion: nil)
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        self.view.addSubview(self.progressLabel)
        self.view.bringSubview(toFront: self.progressLabel)
        self.progressLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(40)
            maker.left.right.equalToSuperview().inset(20)
            maker.height.equalTo(40)
        }
        
        self.view.addSubview(self.submitButton)
        self.view.bringSubview(toFront: self.submitButton)
        self.submitButton.snp.makeConstraints { maker in
            maker.left.right.bottom.equalToSuperview().inset(20)
            maker.height.equalTo(40)
        }
        self.submitButton.layer.masksToBounds = true
        self.submitButton.layer.cornerRadius = 20
    }
    
    
    // MARK: - Action
    func formatTimeString(seconds: TimeInterval) -> String {
        let m = Int(seconds) / 60
        let s = Int(seconds) % 60
        return String(format: "%02i:%02i", m, s)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(QuizCollectionViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        
        if remain < 1 {
            self.submitAnswer()
            self.submitButton.isEnabled = false
        } else {
            remain -= 1
            self.progressLabel.text = formatTimeString(seconds: remain)
            self.submitButton.isEnabled = self.caculateEnableSubmit()
        }
    }
    
    func caculateEnableSubmit() -> Bool {
        // TODO
        return self.questions.map { $0.choice != nil }.reduce(true, { $0 && $1 })
    }
    
    func caculateScore() -> Int {
        var score = 0
        for question in questions {
            if let choice = question.choice, choice == question.answer {
                score += 1
            }
        }
        return score
    }
    
    func submitAnswer() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let modal = storyboard.instantiateViewController(withIdentifier: "modal") as! ModalViewController
        modal.modalPresentationStyle = .custom
        modal.transitioningDelegate = self
        modal.content = "Your score is \(self.caculateScore()) / \(self.questions.count), retake?"
        modal.action = "Retake"
        modal.buttonHandler = { _ in
            
            self.remain = 120
            self.progressLabel.text = self.formatTimeString(seconds: self.remain)
            
            for question in self.questions {
                question.choice = nil
            }
            self.collectionView?.reloadData()
            self.collectionView?.setContentOffset(CGPoint.zero, animated: true)
            self.timer.fireDate = Date.distantPast
        }
        
        self.timer.fireDate = Date.distantFuture
        self.present(modal, animated: true, completion: nil)
    }
    
    func didTappedSubmitButton(_ sender: UIButton) {
        self.submitAnswer()
    }
}

extension QuizCollectionViewController {
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.questions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuizCollectionViewCell
    
        cell.question = self.questions[indexPath.row]

        
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }

}

// MARK: - Animator
extension QuizCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissingAnimator()
    }
}
