//
//  ViewController.swift
//  RockYouTextFieldSample
//
//  Created by seedante on 15/12/1.
//  Copyright © 2015年 seedante. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var letUsRock = false
    var willThrowColorText = false
    @IBOutlet weak var AnimationTextField: UITextField!
    @IBOutlet weak var inputEffectTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AnimationTextField.delegate = self
        inputEffectTextField.delegate = self
        AnimationTextField.addSDEEffect()
        //❤️💕💞💗💖💛💚💙💜❣️💝💟💖💘😂⚽️
        //AnimationTextField.inputAnimationText = "❤️"
    }


    @IBAction func switchOnorOFFInputSkakeEffect(sender: UISegmentedControl) {
        letUsRock = sender.selectedSegmentIndex == 0 ? false : true
    }

    @IBAction func switchOnorOffColorTextEffect(sender: UISegmentedControl) {
        AnimationTextField.colorDeleteAnimationEnabled = sender.selectedSegmentIndex == 0 ? false : true
    }

    @IBAction func switchOnorOffInputEffect(sender: UISegmentedControl) {
        AnimationTextField.inputAnimationEnabled = sender.selectedSegmentIndex == 0 ? false : true
        AnimationTextField.inputAnimationText = inputEffectTextField.text
    }


    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == AnimationTextField{
            if string != "" && letUsRock{
                AnimationTextField.shakeY()
            }
        }else{
            AnimationTextField.inputAnimationText = inputEffectTextField.text
        }


        return true
    }
}

