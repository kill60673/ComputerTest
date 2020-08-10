//
//  ComputerViewController.swift
//  ComputerTest
//
//  Created by harrison on 2020/8/7.
//  Copyright © 2020 harrison. All rights reserved.
//

import UIKit

class ComputerViewController: UIViewController {
    //運算的型別的列舉
    enum OperationType{
        case add
        case subtract
        case multiply
        case divide
        case none
    }
    var name = ""
    var numberOnScreen: Double = 0 //儲存目前畫面上的數字
    var previousNumber: Double = 0 //儲存運算之前畫面上的數字
    var performingMath = false //紀錄目前是否在運算之過程
    var opertion:OperationType = .none //紀錄運算的型別
    var startNew = true //是否是一個新的運算
    
    //顯示數字的Label
    @IBOutlet weak var numberLb: UILabel!
    override func viewDidLoad() {
        self.title = "\(name)的計算機"
        super.viewDidLoad()
    }
    //顯示原本的狀態列(反白)
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //如果數字不是小數點運算則顯示Int格式
    func makeOKNumberString(from number:Double){
        if floor(number) == number{
            if number.toInt() == nil{
                numberLb.text = "\(number)"
            }else{
                numberLb.text = "\(number.toInt()!)"
            }
        }else{
            numberLb.text = "\(number)"
        }
    }
    //點擊運算符號時所改變的狀態
    func opertionclick(typestr:String,type:OperationType){
        numberLb.text = "\(typestr)"
        opertion = type
        performingMath = true
        previousNumber = numberOnScreen
        print("畫面上數字",numberOnScreen)
        print("存取的數字",previousNumber)
    }
    //利用button上面的tag存入並顯示於畫面,並且判斷是否為運算符號
    @IBAction func numbersBt(_ sender: UIButton) {
        let inputNumber = sender.tag - 1
        if numberLb.text != nil{
            print("有進來")
            if startNew == true{
                print("第一區")
                numberLb.text = "\(inputNumber)"
                startNew = false
            }else{
                if numberLb.text == "0" || numberLb.text == "+" || numberLb.text == "-" || numberLb.text == "x" || numberLb.text == "÷"{
                    print("第二區")
                    numberLb.text = "\(inputNumber)"
                }else{
                    print("第三區")
                    numberLb.text = numberLb.text! + "\(inputNumber)"
                }
            }
            numberOnScreen = Double(numberLb.text!) ?? 0
        }
    }
    //點擊將數字歸零並將運算狀態改為false,opertion改為none,startNew改為truer
    @IBAction func clearBt(_ sender: UIButton) {
        numberLb.text = "0"
        numberOnScreen = 0
        previousNumber = 0
        performingMath = false
        opertion = .none
        startNew = true
    }
    //加號的按鈕
    @IBAction func addBt(_ sender: UIButton) {
        if performingMath == true{
            print("一")
            answer(performingMagtType: true)
        }
        opertionclick(typestr: "+", type: .add)
    }
    //剪好的按鈕
    @IBAction func subtractBt(_ sender: UIButton) {
        if performingMath == true{
            print("一")
            answer(performingMagtType: true)
        }
        opertionclick(typestr: "-", type: .subtract)
    }
    //乘號的按鈕
    @IBAction func multiplyBt(_ sender: UIButton) {
        if performingMath == true{
            print("一")
            answer(performingMagtType: true)
        }
        opertionclick(typestr: "x", type: .multiply)
    }
    //除號的按鈕
    @IBAction func divideBt(_ sender: UIButton) {
        if performingMath == true{
            answer(performingMagtType: true)
        }
        opertionclick(typestr: "÷", type: .divide)
    }
    //加入+/-的按鈕將畫面上的數字乘上-1並且存入並顯示於畫面
    @IBAction func negativeBt(_ sender: Any) {
        numberOnScreen = numberOnScreen * -1
        makeOKNumberString(from: numberOnScreen)
        startNew = true
        performingMath = true
        previousNumber = numberOnScreen
    }
    //加入小數點
    @IBAction func dutBt(_ sender: Any) {
        if numberLb.text?.contains(".") == false {
            //點下小數點時輸入0.讓接下來的數字輸入在後,startNew改為False才可順利輸入
            if startNew == true{
                numberLb.text = "0."
                startNew = false
                //若不是一筆新的運算時直接加入.
            }else{
                //判斷是否為運算符號是的話直接加入0.
                if numberLb.text?.contains("x") == true || numberLb.text?.contains("-") == true || numberLb.text?.contains("+") == true || numberLb.text?.contains("÷") == true{
                    numberLb.text = "0."
                }else{
                    numberLb.text = numberLb.text! + "."
                }
            }
        }
    }
    //x!的運算
    @IBAction func factorialBt(_ sender: UIButton) {
        var factorialvalue : Double = 1
        //如果計算時含有.或者-的情況為錯誤回傳錯誤
        if numberLb.text?.contains(".") == true || numberLb.text?.contains("-") == true {
            numberLb.text = "錯誤"
            startNew = true
        }else{
            //規定若數字為0回傳1
            if numberOnScreen == 0 {
                numberLb.text = "1"
            }else{
                //x等於畫面上數字並且帶入階乘算式做運算
                let x = Int(numberOnScreen)
                for i in 1...x{
                    factorialvalue = factorialvalue * Double(i)
                    makeOKNumberString(from: factorialvalue)
                    //判斷若是答案等於Inf則回傳錯誤顯示於畫面上
                    if factorialvalue.isInfinite{
                        numberLb.text = "錯誤"
                    }
                }
                startNew = true
                performingMath = true
                numberOnScreen = factorialvalue
                print(numberOnScreen)
            }
        }
    }
    //等於的按鈕及各算式
    @IBAction func answerBt(_ sender: UIButton) {
        answer(performingMagtType: false)
    }
    func answer(performingMagtType:Bool){
        if performingMath == true{
            switch opertion {
            case .add:
                numberOnScreen = previousNumber + numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .subtract:
                numberOnScreen = previousNumber - numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .multiply:
                numberOnScreen = previousNumber * numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .divide:
                numberOnScreen = previousNumber / numberOnScreen
                makeOKNumberString(from: numberOnScreen)
            case .none:
                numberLb.text = "0"
            }
            performingMath = performingMagtType
            startNew = true
        }
    }
}

//擴展double在轉成Int之前先判斷是否會超過IntMax或是小於IntMin
extension Double {
    func toInt() -> Int? {
        guard (self <= Double(Int.max).nextDown) && (self >= Double(Int.min).nextUp) else {
            return nil
        }
        return Int(self)
    }
}

