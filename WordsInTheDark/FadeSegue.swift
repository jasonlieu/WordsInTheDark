//
//  FadeSegue.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/9/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit
class FadeSegue: UIStoryboardSegue{
    override func perform() {
        let sourceVC = self.source.view
        let destVC = self.destination.view
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        destVC!.frame = CGRect(x: 0, y: 0, width: width, height: height)
        destVC?.alpha = 0
        
        sourceVC?.addSubview(destVC!)
        UIView.animate(withDuration: 1.5, animations: {
            destVC?.alpha = 1
        }, completion: {
            _ in
            self.source.present(self.destination, animated: false, completion: nil)
        })
        
    }
}
