//
//  ViewController.swift
//  CalendarApp
//
//  Created by 福本伊織 on 2021/04/01.
//

import UIKit
import FSCalendar
import Firebase

class ViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    
    var getDate = String()
    var dataModelArray = [DBModel]()
    
    //初期化
    var favRef = Database.database().reference()
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var label: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerDateFormat = "YYYY年MM月"
        
        // Do any additional setup after loading the view.
    }
    
    

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
     
        let formattar = DateFormatter()
                   formattar.dateFormat = "YYYY-MM-dd"
                self.getDate = formattar.string(from: date)
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        label.text = "\(year)/\(month)/\(day)"
        print(getDate)

        
        //userID以下を取得する
        favRef.child("Todo").observe(.value) { (snapShot) in
            
            //配列を空にする
            self.dataModelArray.removeAll()
            
            //オートIDの数データを取得していく
            for child in snapShot.children{
                
                //オートIDをひとつずつDataSnapshot型に変換
                let childSnapshot = child as! DataSnapshot
                //インスタンス化＆値を入れる
                let data = DBModel(snapshot: childSnapshot)
                
          //      print(childSnapshot.key)
                
                //MusicDataModelのプロパティの値を配列に入れていく
                self.dataModelArray.insert(data, at: 0)
                
            }
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func addButton(_ sender: Any) {
        
        performSegue(withIdentifier: "plus", sender: nil)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "plus"{
            
            let plusVC = segue.destination as! plusTodoViewController
            plusVC.date = getDate
            
        }
        
    }
    
    
    

}

