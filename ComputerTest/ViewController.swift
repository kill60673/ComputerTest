//
//  ViewController.swift
//  ComputerTest
//
//  Created by harrison on 2020/8/6.
//  Copyright © 2020 harrison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextPageBt: UIButton!
    @IBOutlet weak var nameTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageBt.isEnabled = false
        nameTf.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    //跳轉到計算機頁得按鈕設定
    @IBAction func nextPageBt(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ComputerVC") as? ComputerViewController
        vc?.name = nameTf.text!
        show(vc!, sender: self)
        nameTf.text = ""
    }
    //若輸入為空按鈕顏色為灰色並且不可輸入,若以有輸入文字則可以點擊按鈕進入下一頁,這邊可加入正規表示法寫入去判斷是否輸入正確
    @objc func textDidChange(_ textField:UITextField) {
        if nameTf.text != ""{
            nextPageBt.backgroundColor = UIColor.blue
            nextPageBt.isEnabled = true
            }else{
            nextPageBt.backgroundColor = UIColor.lightGray
            nextPageBt.isEnabled = false
        }
    }

}

