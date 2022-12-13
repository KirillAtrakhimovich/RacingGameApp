//
//  Settings.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 9.05.21.
//

import UIKit

class Settings: UIViewController {
    @IBOutlet weak var secondButtonBarrier: UIButton!
    @IBOutlet weak var firstButtonBarrier: UIButton!
    @IBOutlet weak var firstButtonCar: UIButton!
    @IBOutlet weak var secondButtonCar: UIButton!
    @IBOutlet weak var thirdButtonCar: UIButton!
    var carType: CarsType = .car1
    var barrierType: BarriersType = .barrier2
    var name = ""
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var textField: UITextField!
    let settingsImage = UIImage(named: "settings_image")
    @IBOutlet weak var settingsView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        settingsView.image = settingsImage
        
        if let data = userDefaults.value(forKey: UserDefaultKeys.settings.rawValue) as? Data{
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserSettings.self, from: data) {
                textField.text = user.name
                carType = user.car
                barrierType = user.barrier
            }
        }
    }
 
    @IBAction func firstCarButtonPressed(_ sender: UIButton) {
        carType = .car1
        
            secondButtonCar.layer.shadowColor = UIColor.clear.cgColor
            thirdButtonCar.layer.shadowColor = UIColor.clear.cgColor
            firstButtonCar.layer.shadowColor = UIColor.green.cgColor
            firstButtonCar.layer.shadowOffset = .zero
            firstButtonCar.layer.shadowRadius = 10
            firstButtonCar.layer.shadowOpacity = 100
            firstButtonCar.layer.cornerRadius = firstButtonCar.frame.height / 2
    }
    
    @IBAction func secondCarButtonPressed(_ sender: UIButton) {
        carType = .car2
    
            firstButtonCar.layer.shadowColor = UIColor.clear.cgColor
            thirdButtonCar.layer.shadowColor = UIColor.clear.cgColor
            secondButtonCar.layer.shadowColor = UIColor.green.cgColor
            secondButtonCar.layer.shadowOffset = .zero
            secondButtonCar.layer.shadowRadius = 10
            secondButtonCar.layer.shadowOpacity = 100
            secondButtonCar.layer.cornerRadius = secondButtonCar.frame.height / 2
    }
    
    @IBAction func thirdCarButtonPressed(_ sender: UIButton) {
        carType = .car3
 
            secondButtonCar.layer.shadowColor = UIColor.clear.cgColor
            firstButtonCar.layer.shadowColor = UIColor.clear.cgColor
            thirdButtonCar.layer.shadowColor = UIColor.green.cgColor
            thirdButtonCar.layer.shadowOffset = .zero
            thirdButtonCar.layer.shadowRadius = 10
            thirdButtonCar.layer.shadowOpacity = 100
            thirdButtonCar.layer.cornerRadius = thirdButtonCar.frame.height / 2
    }
    
    @IBAction func firstBarrierButtonPressed(_ sender: UIButton) {
        barrierType = .barrier1
        
        secondButtonBarrier.layer.shadowColor = UIColor.clear.cgColor
        firstButtonBarrier.layer.shadowColor = UIColor.green.cgColor
        firstButtonBarrier.layer.shadowOffset = .zero
        firstButtonBarrier.layer.shadowRadius = 10
        firstButtonBarrier.layer.shadowOpacity = 100
        firstButtonBarrier.layer.cornerRadius = firstButtonBarrier.frame.height / 2
    }
    @IBAction func secondBarrierButtonPressed(_ sender: UIButton) {
        barrierType = .barrier2
        
        firstButtonBarrier.layer.shadowColor = UIColor.clear.cgColor
        secondButtonBarrier.layer.shadowColor = UIColor.green.cgColor
        secondButtonBarrier.layer.shadowOffset = .zero
        secondButtonBarrier.layer.shadowRadius = 10
        secondButtonBarrier.layer.shadowOpacity = 100
        secondButtonBarrier.layer.cornerRadius = secondButtonBarrier.frame.height / 2
    }
    
    @IBAction func saveSettingsPressed(_ sender: Any) {
        name = textField?.text ?? ""
        let settings = UserSettings(name: name, car: carType, barrier: barrierType)
        let settingsData = try? JSONEncoder().encode(settings)
        if let currentSettingsData = settingsData  {
            userDefaults.setValue(currentSettingsData, forKey: .settings)
        }
        navigationController?.popToRootViewController(animated: false)
    }
}
