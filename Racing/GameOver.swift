//
//  GameOver.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 6.06.21.
//

import UIKit

class GameOver: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        backButton.backgroundColor = .systemPink
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.font = UIFont.deadSpace(of: 12)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func backToMainMenuPressed(_ sender: Any) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.popToRootViewController(animated: true)
    }
}
