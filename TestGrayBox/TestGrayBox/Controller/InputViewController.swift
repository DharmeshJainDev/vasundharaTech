//
//  ViewController.swift
//  TestGrayBox
//
//  Created by Dharmesh Kochar on 16/10/23.
//

import UIKit

class InputViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - IBAction

    @IBAction func startBtnTaped(_ sender: UIButton) {
        guard let numberText = numberInput.text,
              let number = Int(numberText), number >= 10 else {
            let alert = UIAlertController(title: "Invalid Input", message: "Number should be minimum 10", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true,completion: nil)
            return
        }
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        secondVC?.totalInputNumber = number
        self.navigationController?.pushViewController(secondVC ?? UIViewController(), animated: true)
    }
}

