//
//  OyunEkraniViewController.swift
//  BayrakOyunu
//
//  Created by Kaan Deniz Erikmen on 16.09.2023.
//

import UIKit

class OyunEkraniViewController: UIViewController {
    @IBOutlet weak var lblDogru: UILabel!
    @IBOutlet weak var lblSoruSayisi: UILabel!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var imgBayrak: UIImageView!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var lblYanlıs: UILabel!
    
    var sorular = [Bayraklar]()
    var yanlisSecenekler = [Bayraklar]()
    
    var dogruSoru2 = Bayraklar()
    
    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
    
    var secenekler = [Bayraklar]()
    var seceneklerKaristirmaListesi = Set <Bayraklar>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sorular = Bayraklardao().rasgele5Getir()
        soruYukle()
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC =  segue.destination as! SonucEkraniViewController
        gidilecekVC.dogruSayisi = dogruSayac
    }
    
    func soruYukle(){
        lblSoruSayisi.text = "\(soruSayac+1). SORU"
        lblDogru.text = "Doğru: \(dogruSayac)"
        lblYanlıs.text = "Yanlış: \(yanlisSayac)"
        
        
        dogruSoru2 = sorular[soruSayac]
        
        imgBayrak.image = UIImage(named: dogruSoru2.bayrak_resim!)
        
        yanlisSecenekler = Bayraklardao().rasgele3YanlisGetir(bayrak_id: dogruSoru2.bayrak_id!)
        
        seceneklerKaristirmaListesi.removeAll()
        
        seceneklerKaristirmaListesi.insert(dogruSoru2)
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[0])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[1])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[2])
        
        secenekler.removeAll()
        
        
        for b in seceneklerKaristirmaListesi{
            secenekler.append(b)
        }
        
        buttonA.setTitle(secenekler[0].bayrak_ad, for: .normal)
        buttonB.setTitle(secenekler[1].bayrak_ad, for: .normal)
        buttonC.setTitle(secenekler[2].bayrak_ad, for: .normal)
        buttonD.setTitle(secenekler[3].bayrak_ad, for: .normal)
    }
    
    func DogruKontrol(button:UIButton){
        let buttonYazi = button.titleLabel?.text
        let dogruCevap = dogruSoru2.bayrak_ad
        
        print("Button Yazi \(buttonYazi!)")
        print("Dogru  Cevap \(dogruCevap!)")
        
        if dogruCevap == buttonYazi{
            dogruSayac = dogruSayac + 1
        }else{
            yanlisSayac = yanlisSayac + 1
        }
        lblDogru.text = "Doğru : \(dogruSayac)"
        lblYanlıs.text = "Yanlış : \(yanlisSayac)"
        
    }
    
    func SoruSayacKontrol(){
        soruSayac = soruSayac + 1
        
        if soruSayac != 5{
            soruYukle()
        }else{
            performSegue(withIdentifier: "toSonucEkrani", sender: nil)
        }
    }
    @IBAction func btnA(_ sender: Any) {
        DogruKontrol(button: buttonA)
        SoruSayacKontrol()
            }
    
    @IBAction func btnB(_ sender: Any) {
        DogruKontrol(button: buttonB)
        SoruSayacKontrol()    }
    @IBAction func btnC(_ sender: Any) {
        DogruKontrol(button: buttonC)
        SoruSayacKontrol()
    }
    @IBAction func btnD(_ sender: Any) {
        DogruKontrol(button: buttonD)
        SoruSayacKontrol()
    }
    
}

