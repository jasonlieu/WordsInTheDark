//
//  MenuVC.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/4/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit

class MenuVC : UIViewController {
    @IBOutlet var W : UILabel!
    @IBOutlet var O : UILabel!
    @IBOutlet var R : UILabel!
    @IBOutlet var D : UILabel!
    @IBOutlet var S : UILabel!
    @IBOutlet var IN : UILabel!
    @IBOutlet var THE : UILabel!
    @IBOutlet var A : UILabel!
    @IBOutlet var R2 : UILabel!
    @IBOutlet var K : UILabel!
    @IBOutlet var endlessButton : UIButton!
    @IBOutlet var standardButton : UIButton!
    @IBOutlet var lightLabel : UILabel!
    
    @IBAction func standard(_ sender: UIButton){
        UIView.animate(withDuration: 1.5, animations: {
            self.view.alpha = 0
        }, completion: {
            _ in
            self.performSegue(withIdentifier: "toStandard", sender: self)
        })
    }
    @IBAction func endless(_ sender: UIButton){
        UIView.animate(withDuration: 1.5, animations: {
            self.view.alpha = 0
        }, completion: {
            _ in
            self.performSegue(withIdentifier: "toEndless", sender: self)
        })
    }
    func turnOn(){
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveEaseOut, animations: {
            self.W.alpha = 1
            self.O.alpha = 1
            self.R.alpha = 1
            self.D.alpha = 1
            self.S.alpha = 1
            self.IN.alpha = 1
            self.THE.alpha = 1
            self.A.alpha = 1
            self.R2.alpha = 1
            self.K.alpha = 1
            self.endlessButton.alpha = 1
            self.standardButton.alpha = 1
            self.lightLabel.alpha = 0.05
        }, completion: {
            _ in
            UIView.animate(withDuration: 0.05, delay: 0.05, options: .curveEaseOut, animations: {
                self.W.alpha = 0
                self.O.alpha = 0
                self.R.alpha = 0
                self.D.alpha = 0
                self.S.alpha = 0
                self.IN.alpha = 0
                self.THE.alpha = 0
                self.A.alpha = 0
                self.R2.alpha = 0
                self.K.alpha = 0
                self.endlessButton.alpha = 0
                self.standardButton.alpha = 0
                self.lightLabel.alpha = 0
            }, completion: {
                _ in
                UIView.animate(withDuration: 0.05, delay: 0.05, options: .curveEaseOut, animations: {
                    self.W.alpha = 1
                    self.O.alpha = 1
                    self.R.alpha = 1
                    self.D.alpha = 1
                    self.S.alpha = 1
                    self.IN.alpha = 1
                    self.THE.alpha = 1
                    self.A.alpha = 1
                    self.R2.alpha = 1
                    self.K.alpha = 1
                    self.endlessButton.alpha = 1
                    self.standardButton.alpha = 1
                    self.lightLabel.alpha = 0.05
                }, completion: {
                    _ in
                    UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseOut, animations: {
                        self.W.alpha = 0
                        self.O.alpha = 0
                        self.R.alpha = 0
                        self.D.alpha = 0
                        self.S.alpha = 0
                        self.IN.alpha = 0
                        self.THE.alpha = 0
                        self.A.alpha = 0
                        self.R2.alpha = 0
                        self.K.alpha = 0
                        self.endlessButton.alpha = 0
                        self.standardButton.alpha = 0
                        self.lightLabel.alpha = 0
                        self.endlessButton.isEnabled = true
                        self.standardButton.isEnabled = true
                    }, completion: {
                        _ in
                        UIView.animate(withDuration: 1.5, delay: 0.8, options: .curveEaseOut, animations: {
                            self.W.alpha = 1
                            self.O.alpha = 1
                            self.R.alpha = 1
                            self.D.alpha = 1
                            self.S.alpha = 1
                            self.IN.alpha = 1
                            self.THE.alpha = 1
                            self.A.alpha = 1
                            self.R2.alpha = 1
                            self.K.alpha = 1
                            self.endlessButton.alpha = 1
                            self.standardButton.alpha = 1
                            self.lightLabel.alpha = 0.1
                        }, completion: {
                            _ in
                            UIView.animate(withDuration: 1.5, animations: {
                                self.lightLabel.alpha = 0.2
                            })
                        })
                    })
                })
            })
        })
    }
    func noFlash(){
        standardButton.isEnabled = true
        endlessButton.isEnabled = true
        UIView.animate(withDuration: 1.5, delay: 0.8, options: .curveEaseOut, animations: {
            self.W.alpha = 1
            self.O.alpha = 1
            self.R.alpha = 1
            self.D.alpha = 1
            self.S.alpha = 1
            self.IN.alpha = 1
            self.THE.alpha = 1
            self.A.alpha = 1
            self.R2.alpha = 1
            self.K.alpha = 1
            self.endlessButton.alpha = 1
            self.standardButton.alpha = 1
            self.lightLabel.alpha = 0.1
        }, completion: {
            _ in
            UIView.animate(withDuration: 1.5, animations: {
                self.lightLabel.alpha = 0.2
            })
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        W.textColor = UIColor(displayP3Red: 60/255, green: 72/255, blue: 74/255, alpha: 1)
        O.textColor = UIColor(displayP3Red: 60/255, green: 72/255, blue: 74/255, alpha: 1)
        R.textColor = UIColor(displayP3Red: 60/255, green: 72/255, blue: 74/255, alpha: 1)
        D.textColor = UIColor(displayP3Red: 50/255, green: 62/255, blue: 64/255, alpha: 1)
        S.textColor = UIColor(displayP3Red: 60/255, green: 72/255, blue: 74/255, alpha: 1)
        IN.textColor = UIColor(displayP3Red: 60/255, green: 72/255, blue: 74/255, alpha: 1)
        THE.textColor = UIColor(displayP3Red: 60/255, green: 72/255, blue: 74/255, alpha: 1)
        A.textColor = UIColor(displayP3Red: 50/255, green: 62/255, blue: 64/255, alpha: 1)
        R2.textColor = UIColor(displayP3Red: 50/255, green: 62/255, blue: 64/255, alpha: 1)
        K.textColor = UIColor(displayP3Red: 50/255, green: 62/255, blue: 64/255, alpha: 1)
        W.alpha = 0
        O.alpha = 0
        R.alpha = 0
        D.alpha = 0
        S.alpha = 0
        IN.alpha = 0
        THE.alpha = 0
        D.alpha = 0
        A.alpha = 0
        R2.alpha = 0
        K.alpha = 0
        endlessButton.setTitle("E N D L E S S", for: .normal)
        standardButton.setTitle("S T A N D A R D", for: .normal)
        endlessButton.setTitleColor(UIColor(displayP3Red: 70/255, green: 82/255, blue: 84/255, alpha: 1), for: .normal)
        standardButton.setTitleColor(UIColor(displayP3Red: 70/255, green: 82/255, blue: 84/255, alpha: 1), for: .normal)
        endlessButton.alpha = 0
        standardButton.alpha = 0
        lightLabel.alpha = 0
        endlessButton.isEnabled = false
        standardButton.isEnabled = false
        view.backgroundColor = UIColor(displayP3Red: 49/255, green: 51/255, blue: 53/255, alpha: 1)
        lightLabel.transform = CGAffineTransform(rotationAngle: 45 * 3.14/180)
    }
    override func viewDidAppear(_ animated: Bool) {
        view.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.view.alpha = 1
        }, completion:  {
            _ in
            self.noFlash()
        })
        
    }
}
