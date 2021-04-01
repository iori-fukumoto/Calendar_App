//
//  plusTodoViewController.swift
//  CalendarApp
//
//  Created by 福本伊織 on 2021/04/01.
//

import UIKit
import Firebase

class plusTodoViewController: UIViewController,UITextFieldDelegate {

    
    
    @IBOutlet weak var TodoTextField: UITextField!
    @IBOutlet weak var MemoTextView: UITextView!
    
    @IBOutlet weak var StartTimeView: UITextField!
    @IBOutlet weak var StopTimeView: UITextField!
    
    @IBOutlet weak var OKbutton: UIButton!
    
    var titleText = String()
    var memo = String()
    var startTime = String()
    var stopTime = String()
    var date = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartTimeView.delegate = self
        StopTimeView.delegate = self
        //キーボードをtimePickerに変更
        StartTimeView.inputView = timePicker
        StopTimeView.inputView = timePicker
        
        OKbutton.layer.cornerRadius = 10.0
        
        // Do any additional setup after loading the view.
    }
    
    
    //UIDatePickerをインスタンス化。HHは大文字。.wheelsでホイールに。
    let timePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.preferredDatePickerStyle = .wheels
        dp.frame = CGRect(x: 0, y: 590, width: 400, height: 300)
        dp.datePickerMode = UIDatePicker.Mode.time
        dp.timeZone = NSTimeZone.local
        //時間をJapanese(24時間表記)に変更
        dp.locale = Locale.init(identifier: "Japanese")
        dp.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        //最小単位（分）を設定
        dp.minuteInterval = 10
        return dp
    }()
    @objc func dateChange(){
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        StartTimeView.text = "\(formatter.string(from: timePicker.date))"
        StopTimeView.text = "\(formatter.string(from: timePicker.date))"
    }
    
    
    @IBAction func OKButton(_ sender: Any) {
        
        
        let dbModel = DBModel(title: TodoTextField.text!, memo: MemoTextView.text!, startTime: StartTimeView.text!, stopTime: StopTimeView.text!, date: date)
        dbModel.save()
        
        TodoTextField.text = ""
        MemoTextView.text = ""
        StartTimeView.text = ""
        StopTimeView.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        TodoTextField.resignFirstResponder()
        MemoTextView.resignFirstResponder()
        StartTimeView.resignFirstResponder()
        StopTimeView.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
