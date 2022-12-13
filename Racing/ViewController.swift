//
//  ViewController.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 9.05.21.
//

import UIKit

class ViewController: UIViewController {

    let startImageCar = UIImage(named: "start_image")
    let startImageView = UIImageView()
    let settingsButton = UIButton()
    let gameButton = UIButton()
    let recordButton = UIButton()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main menu"
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchDown)
        gameButton.addTarget(self, action: #selector(startButtonPressed), for: .touchDown)
        recordButton.addTarget(self, action: #selector(recordsButtonPressed), for: .touchDown)
        
        
        startImageView.image = startImageCar
        startImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(startImageView)
        
        gameButton.frame = CGRect(x: view.frame.width / 2 - 100 , y: 200, width: 200, height: 35)
        gameButton.layer.shadowColor = UIColor.purple.cgColor
        gameButton.layer.shadowOffset = .zero
        gameButton.layer.shadowRadius = 20
        gameButton.layer.shadowOpacity = 1.0
        gameButton.layer.cornerRadius = gameButton.frame.height / 2
        gameButton.backgroundColor = .systemPink
        gameButton.setTitleColor(.white, for: .normal)
        gameButton.setTitle("Start", for: .normal)
        gameButton.titleLabel?.font = UIFont.deadSpace(of: 22)
        

        
        settingsButton.frame = CGRect(x: view.frame.width / 2 - 100 , y: 250, width: 200, height: 35)
        settingsButton.layer.shadowColor = UIColor.purple.cgColor
        settingsButton.layer.shadowOffset = .zero
        settingsButton.layer.shadowRadius = 20
        settingsButton.layer.shadowOpacity = 1.0
        settingsButton.layer.cornerRadius = settingsButton.frame.height / 2
        settingsButton.backgroundColor = .systemPink
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.font = UIFont.deadSpace(of: 22)
        
        recordButton.frame = CGRect(x: view.frame.width / 2 - 100 , y: 300, width: 200, height: 35)
        recordButton.layer.shadowColor = UIColor.purple.cgColor
        recordButton.layer.shadowOffset = .zero
        recordButton.layer.shadowRadius = 20
        recordButton.layer.shadowOpacity = 1.0
        recordButton.layer.cornerRadius = recordButton.frame.height / 2
        recordButton.backgroundColor = .systemPink
        recordButton.setTitleColor(.white, for: .normal)
        recordButton.setTitle("Score Table", for: .normal)
        recordButton.titleLabel?.font = UIFont.deadSpace(of: 22)
        
        view.addSubview(gameButton)
        view.addSubview(settingsButton)
        view.addSubview(recordButton)
    }
    
    @objc func settingsButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "Settings") as Settings
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func startButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "GameStart") as GameStart
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func recordsButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "RecordTable") as RecordTable
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
}


