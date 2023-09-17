//
//  SonucEkraniViewController.swift
//  BayrakOyunu
//
//  Created by Kaan Deniz Erikmen on 16.09.2023.
//

import UIKit

class SonucEkraniViewController: UIViewController {
    @IBOutlet weak var lblsonuc: UILabel!
    
    var dogruSayisi:Int?
    
    
    @IBOutlet weak var lblYuzdeSonuc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        if let d = dogruSayisi {
            lblsonuc.text = "\(d) DOĞRU \(5-d) YANLIŞ"
            lblYuzdeSonuc.text = "% \(d*100/5) BAŞARI"
        }
    }
    

    
    @IBAction func btnTekrarDene(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
