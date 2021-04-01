//
//  DBModel.swift
//  CalendarApp
//
//  Created by 福本伊織 on 2021/04/01.
//

import Foundation
import Firebase

class DBModel{
    
    var title:String = ""
    var memo:String = ""
    var startTime:String = ""
    var stopTime:String = ""
    var date:String = ""
    
    let ref:DatabaseReference!
    
    init(title:String,memo:String,startTime:String,stopTime:String,date:String){
        
        self.title = title
        self.memo = memo
        self.startTime = startTime
        self.stopTime = stopTime
        self.date = date
        
        
        //usersのuserIDの下に保存してくださいね、という意味。
        ref = Database.database().reference().child("Todo").childByAutoId()
    }
    
    
    
    //受信用
    init(snapshot:DataSnapshot) {
        
        ref = snapshot.ref
        if let value = snapshot.value as? [String:Any]{
            
            title = (value["title"] as? String)!
            memo = (value["memo"] as? String)!
            startTime = (value["startTime"] as? String)!
            stopTime = (value["stopTime"] as? String)!
            date = (value["date"] as? String)!
            
        }
    }
    
    
  
    
    //イニシャライザで入ってきた値を辞書型に変換
    func toContents() -> [String:Any]{
        
        return ["title":title,"memo":memo,"startTime":startTime,"stopTime":stopTime,"date":date]
        
    }
    
    
    func save() {
        
        //firebaseに保存
        ref.setValue(toContents())
        
    }
    
    
}

