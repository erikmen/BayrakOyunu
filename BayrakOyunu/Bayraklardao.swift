//
//  Bayraklardao.swift
//  BayrakOyunu
//
//  Created by Kaan Deniz Erikmen on 16.09.2023.
//

import Foundation

class Bayraklardao{
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    func rasgele5Getir() -> [Bayraklar] {
        var liste = [Bayraklar]()
        
        db?.open()
        
            do{
                let rs = try db!.executeQuery("SELECT * FROM bayraklar ORDER BY RANDDOM() LIMIT 5 ", values: nil)
                while (rs.next()){
                    let bayrak = Bayraklar(bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!,
                                           bayrak_ad: rs.string(forColumn: "bayrak_ad")!,
                                           bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                    liste.append(bayrak)
                }
            }catch{
                print(error.localizedDescription)
            }
        
        
        db?.close()
        return liste
    }
    
    func rasgele3YanlisGetir(bayrak_id:Int) -> [Bayraklar] {
        var liste = [Bayraklar]()
        
        db?.open()
        
            do{
                let rs = try db!.executeQuery("SELECT * FROM bayraklar WHERE bayrak_id != ? ORDER BY RANDDOM() LIMIT 3 ", values: [bayrak_id])
                while (rs.next()){
                    let bayrak = Bayraklar(bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!,
                                           bayrak_ad: rs.string(forColumn: "bayrak_ad")!,
                                           bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                    liste.append(bayrak)
                }
            }catch{
                print(error.localizedDescription)
            }
        
        
        db?.close()
        return liste
    }

}
