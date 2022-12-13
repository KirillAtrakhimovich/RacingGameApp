//
//  RecordTable.swift
//  Racing
//
//  Created by Kirill Atrakhimovich on 9.05.21.
//

import UIKit

class RecordTable: UIViewController {

    @IBOutlet weak var scoreImage: UIImageView!
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var scoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Records table"
    
        let scoreImagePicture = UIImage(named: "score_image")
        scoreImage.image = scoreImagePicture
        
        userDefaults.value(forKey: "score")
        scoreLabel.text = "Last score : \(userDefaults.string(forKey: "score")  ?? "")"
        scoreLabel.textColor = UIColor.systemPink
        scoreLabel.font = UIFont.deadSpace(of: 22)
    }
   
    

}
