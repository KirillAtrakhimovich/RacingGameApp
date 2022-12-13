//
//  GameStart.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 9.05.21.
//

import UIKit

class GameStart: UIViewController {

    let userDefaults = UserDefaults.standard
    var userSettings: UserSettings? = nil
    var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    let roadImage = UIImage(named: "road_image")
    let firstCarImage = UIImage(named: "first_car_image")
    let secondCarImage = UIImage(named: "second_car_image")
    let thirdCarImage = UIImage(named: "third_car_image")
    let barrierImage = UIImage(named: "barrier_image")
    let barrierCarImage = UIImage(named: "barrier_car_image")
    let pauseImage = UIImage(named: "pause_image")
    let barrierImageView = UIImageView()
    let barrierImageView1 = UIImageView()
    let barrierImageView2 = UIImageView()
    let roadImageViewNext = UIImageView()
    let carImageView = UIImageView()
    var pauseImageView = UIImageView()
    var roadImageView = UIImageView()
    var carCrashed = false
    var barrierArray: [UIImageView] = []
    var roadArray: [UIImageView] = []
    var buttonPause = UIButton()
    var gameIsStoped = false
    var timerOfBarrier = Timer()
    var pauseView = UIView()
    var resumeButton = UIButton()
    var scoreLabel = UILabel()
    var totalScores = 0
    var listOfSessionScore:String = ""
    var scoreCount = 0 {
        didSet {
            self.scoreLabel.text = "Score:  \(scoreCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = userDefaults.value(forKey: UserDefaultKeys.settings.rawValue) as? Data{
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserSettings.self, from: data) {
                userSettings = user
            } else {
                userSettings = UserSettings(name: "", car: .car3, barrier: .barrier2)
            }
        }
        
        pauseImageView.image = pauseImage
        
        scoreLabel.text = "Score: 0"
        scoreLabel.frame = CGRect(x: (view.frame.width / 2) - 50, y: 30, width: 130, height: 50)
        scoreLabel.font = UIFont.deadSpace(of: 22)
        scoreLabel.textColor = .black
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        buttonPause.frame = CGRect(x: view.frame.origin.x + 40, y: view.frame.origin.y + 40, width: 35, height: 35)
        buttonPause.backgroundColor = .black
        pauseImageView.frame = CGRect(x: view.frame.origin.x + 40, y: view.frame.origin.y + 40, width: 35, height: 35)
        pauseView.frame = CGRect(x: view.frame.width / 4, y: view.frame.height / 4, width: view.frame.width / 2 , height: view.frame.height / 2)
        pauseView.backgroundColor = .white
        
        resumeButton.frame = CGRect(x: (view.frame.width - 150) / 9, y: view.frame.height / 16, width: 150, height: 35)
        resumeButton.backgroundColor = .systemPink
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.titleLabel?.font = UIFont.deadSpace(of: 22)
        
        switch userSettings!.car {
            case .car1:
                carImageView.image = firstCarImage
            case .car2:
                carImageView.image = secondCarImage
            case .car3:
                carImageView.image = thirdCarImage
        }
        roadImageView.image = roadImage
        roadImageViewNext.image = roadImage

        buttonPause.addTarget(self, action: #selector(buttonPausePressed), for: .touchDown)
        resumeButton.addTarget(self, action: #selector(resumeButtonPressed), for: .touchDown)
        
        carImageView.frame = CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: view.frame.width / 4, height: view.frame.height / 8)
        roadImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        roadImageViewNext.frame = CGRect(x: 0, y: -view.frame.height, width: view.frame.width, height: view.frame.height)
        barrierImageView.frame = CGRect(x: CGFloat(Int.random(in: 0...Int(view.frame.width - barrierImageView1.frame.width))), y: 0, width: view.frame.width / 7, height: view.frame.height / 9)
        barrierImageView1.frame = CGRect(x: CGFloat(Int.random(in: 0...Int(view.frame.width - barrierImageView.frame.width))), y: -view.frame.height / 1.5, width: view.frame.width / 7, height: view.frame.height / 9)
        barrierImageView2.frame = CGRect(x: CGFloat(Int.random(in: 0...Int(view.frame.width - barrierImageView.frame.width))), y: -view.frame.height / 3, width: view.frame.width / 7, height: view.frame.height / 9)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(movingCar))
        view.addGestureRecognizer(panGestureRecognizer)
    
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            for barrierArrayView in self.barrierArray {
                if self.carImageView.frame.intersects(barrierArrayView.frame) {
                    timer.invalidate()
                    self.carIsCrashed()
                }
            }
        }
        
        view.addSubview(roadImageView)
        view.addSubview(roadImageViewNext)
        view.addSubview(carImageView)
        view.addSubview(buttonPause)
        view.addSubview(pauseImageView)
        view.addSubview(scoreLabel)
        view.bringSubviewToFront(pauseImageView)
        view.bringSubviewToFront(pauseView)
        view.bringSubviewToFront(scoreLabel)
     
        roadAnimation(roadView: roadImageView, moveTo: 0, whenMove: view.frame.height)
        roadAnimation(roadView: roadImageViewNext, moveTo: -view.frame.height, whenMove: 0)
        timerBarrier()
        scoreTimer()
    }
    
    func scoreTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if !self.gameIsStoped {
                self.scoreCount += 1
            } else {
                self.scoreCount += 0
            }
    }
}
    
    func timerBarrier() {
        timerOfBarrier = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] (timer) in
            let newBarrierImageView = UIImageView()
            switch self.userSettings!.barrier {
                case .barrier1:
                    newBarrierImageView.image = self.barrierCarImage
                case .barrier2:
                    newBarrierImageView.image = self.barrierImage
            }
            
            newBarrierImageView.frame = CGRect(x: CGFloat(Int.random(in: 0...Int(self.view.frame.width - self.barrierImageView.frame.width))), y: 0, width: self.view.frame.width / 7, height: self.view.frame.height / 9)
            self.barrierArray.append(newBarrierImageView)
            self.view.addSubview(newBarrierImageView)
            self.barrierAnimation(newBarrier: newBarrierImageView)
            self.removeBarrierImageView(newBarrier: newBarrierImageView)
        }
    }
    
    func roadAnimation (roadView: UIImageView, moveTo: CGFloat, whenMove: CGFloat) {
        UIImageView.animate(withDuration: 0.03, delay: 0, options: [.curveLinear]) {
            roadView.frame.origin.y += 10
        } completion: { (_) in
            if !self.gameIsStoped {
                if roadView.frame.origin.y >= whenMove {
                    roadView.frame.origin.y = moveTo
                }
                self.roadAnimation(roadView: roadView, moveTo: moveTo, whenMove: whenMove)
            }
        }
    }
    
    func barrierAnimation(newBarrier: UIImageView) {
        UIImageView.animate(withDuration: 0.03, delay: 0, options: .curveLinear) {
            newBarrier.frame.origin.y += 10
        } completion: { (_) in
            if !self.gameIsStoped{
                self.barrierAnimation(newBarrier: newBarrier)
            }
        }
    }

    @objc func movingCar(recognizer: UIPanGestureRecognizer){
        if gameIsStoped {
            return
        }
        
        if recognizer.state == .began {
        } else if recognizer.state == .changed {
            let translation = recognizer.translation(in: self.view)
            
            let newX = carImageView.center.x + translation.x
            let newY = carImageView.center.y + translation.y
            
            carImageView.center = CGPoint(x: newX, y: newY)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            
            if carImageView.frame.maxX > self.view.frame.width || carImageView.frame.minX < 0 || carImageView.frame.maxY > self.view.frame.height ||  carImageView.frame.minY < 0{
                carIsCrashed()
            }
        }
    }
    
    @objc func buttonPausePressed() {
       gameIsStoped = !gameIsStoped
        if !gameIsStoped {
            timerBarrier()
            continueBarrierAnimaton()
            roadAnimation(roadView: roadImageView, moveTo: 0, whenMove: view.frame.height)
            roadAnimation(roadView: roadImageViewNext, moveTo: -view.frame.height, whenMove: 0)
            barrierAnimation(newBarrier: barrierImageView)
            blurEffectView.alpha = 0
            pauseView.removeFromSuperview()
        } else {
            blurEffectView.frame = view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(blurEffectView)
            blurEffectView.alpha = 0.8
            view.addSubview(pauseView)
            pauseView.addSubview(resumeButton)
            timerOfBarrier.invalidate()
        }
    }
    
    @objc func resumeButtonPressed() {
        gameIsStoped = !gameIsStoped
         if !gameIsStoped {
             timerBarrier()
             continueBarrierAnimaton()
             roadAnimation(roadView: roadImageView, moveTo: 0, whenMove: view.frame.height)
             roadAnimation(roadView: roadImageViewNext, moveTo: -view.frame.height, whenMove: 0)
             barrierAnimation(newBarrier: barrierImageView)
             blurEffectView.alpha = 0
             pauseView.removeFromSuperview()
         }
    }
    
    func continueBarrierAnimaton() {
        for barrier in barrierArray {
            barrierAnimation(newBarrier: barrier)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func carIsCrashed () {
        carCrashed = true
        if carCrashed == true{
            self.userDefaults.setValue(scoreCount, forKey: .score)
            removeBarrierImageView(newBarrier: barrierImageView)
            timerOfBarrier.invalidate()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "GameOver") as GameOver
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
   
    func removeBarrierImageView(newBarrier:UIImageView) {
        var newArray:[UIImageView] = []
        for newBarrier in barrierArray{
            if newBarrier.frame.origin.y < view.frame.height {
                newArray.append(newBarrier)
            }
        }
        barrierArray = newArray
    }
}
