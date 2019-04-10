//
//  ViewController.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/1/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button00 : CustomButton!
    @IBOutlet var button01 : CustomButton!
    @IBOutlet var button02 : CustomButton!
    @IBOutlet var button03 : CustomButton!
    @IBOutlet var button04 : CustomButton!
    @IBOutlet var button05 : CustomButton!
    @IBOutlet var button06 : CustomButton!
    @IBOutlet var button07 : CustomButton!
    @IBOutlet var button08 : CustomButton!

    @IBOutlet var button10 : CustomButton!
    @IBOutlet var button11 : CustomButton!
    @IBOutlet var button12 : CustomButton!
    @IBOutlet var button13 : CustomButton!
    @IBOutlet var button14 : CustomButton!
    @IBOutlet var button15 : CustomButton!
    @IBOutlet var button16 : CustomButton!
    @IBOutlet var button17 : CustomButton!
    @IBOutlet var button18 : CustomButton!
    
    @IBOutlet var button20 : CustomButton!
    @IBOutlet var button21 : CustomButton!
    @IBOutlet var button22 : CustomButton!
    @IBOutlet var button23 : CustomButton!
    @IBOutlet var button24 : CustomButton!
    @IBOutlet var button25 : CustomButton!
    @IBOutlet var button26 : CustomButton!
    @IBOutlet var button27 : CustomButton!
    @IBOutlet var button28 : CustomButton!
    
    @IBOutlet var button30 : CustomButton!
    @IBOutlet var button31 : CustomButton!
    @IBOutlet var button32 : CustomButton!
    @IBOutlet var button33 : CustomButton!
    @IBOutlet var button34 : CustomButton!
    @IBOutlet var button35 : CustomButton!
    @IBOutlet var button36 : CustomButton!
    @IBOutlet var button37 : CustomButton!
    @IBOutlet var button38 : CustomButton!
    
    @IBOutlet var button40 : CustomButton!
    @IBOutlet var button41 : CustomButton!
    @IBOutlet var button42 : CustomButton!
    @IBOutlet var button43 : CustomButton!
    @IBOutlet var button44 : CustomButton!
    @IBOutlet var button45 : CustomButton!
    @IBOutlet var button46 : CustomButton!
    @IBOutlet var button47 : CustomButton!
    @IBOutlet var button48 : CustomButton!
    
    @IBOutlet var button50 : CustomButton!
    @IBOutlet var button51 : CustomButton!
    @IBOutlet var button52 : CustomButton!
    @IBOutlet var button53 : CustomButton!
    @IBOutlet var button54 : CustomButton!
    @IBOutlet var button55 : CustomButton!
    @IBOutlet var button56 : CustomButton!
    @IBOutlet var button57 : CustomButton!
    @IBOutlet var button58 : CustomButton!
    
    @IBOutlet var button60 : CustomButton!
    @IBOutlet var button61 : CustomButton!
    @IBOutlet var button62 : CustomButton!
    @IBOutlet var button63 : CustomButton!
    @IBOutlet var button64 : CustomButton!
    @IBOutlet var button65 : CustomButton!
    @IBOutlet var button66 : CustomButton!
    @IBOutlet var button67 : CustomButton!
    @IBOutlet var button68 : CustomButton!
    @IBOutlet var hintLabel : UILabel!
    var buttons : [[CustomButton?]] = []
    var grid : [[Character]] = []
    let invisTextField = UITextField(frame: CGRect.zero)
    var board : Generator!
    var currentButtonX : Int!
    var currentButtonY : Int!
    var currentWordLength : Int!
    var currentLetterCount : Int!
    var currentWordX: Int?
    var currentWordY: Int?
    var currentOrientation: Bool?
    var currentIntersectX: Int?
    var currentIntersectY: Int?
    var currentIntersectIndex: Int?
    var intersectionCounted: Bool?

    @IBAction func buttonPressed(_ sender: CustomButton){
        currentButtonX = sender.X
        currentButtonY = sender.Y
        sender.borderWidth = 2
        sender.borderColor = UIColor(displayP3Red: 1, green: 203/255, blue: 5/255, alpha: 1)
        invisTextField.becomeFirstResponder()
    }
    @IBAction func textFieldEditingDidChange( sender: UITextField){
        buttons[currentButtonY][currentButtonX]?.setTitle((invisTextField.text)?.uppercased(), for: .normal)
        buttons[currentButtonY][currentButtonX]?.borderWidth = 1
        buttons[currentButtonY][currentButtonX]?.borderColor = UIColor(displayP3Red: 49/255, green: 51/255, blue: 53/255, alpha: 1)
        if buttons[currentButtonY][currentButtonX]?.titleLabel?.text == " "{
            currentLetterCount += 1
            print(currentLetterCount)
        }
        else if currentOrientation! {
            if currentButtonX == currentIntersectX! && !intersectionCounted! {
                currentLetterCount += 1
                intersectionCounted = true
            }
        }
        else if !currentOrientation! {
            if currentButtonY == currentIntersectY! && !intersectionCounted! {
                currentLetterCount += 1
                intersectionCounted = true
            }
        }
        grid[currentButtonY][currentButtonX] = Character(invisTextField.text!.uppercased())
        invisTextField.text = nil
        if currentLetterCount < currentWordLength {
            var canMoveToNext = true
            if currentOrientation! && currentButtonX < 8{
                currentButtonX += 1
                if currentButtonX >= currentWordX! + currentWordLength {
                    canMoveToNext = false
                }
            }
            else if currentButtonY < 6{
                currentButtonY += 1
                if currentButtonY >= currentWordY! + currentWordLength {
                    canMoveToNext = false
                }
            }
            if canMoveToNext {
                buttonPressed(buttons[currentButtonY][currentButtonX]!)
            }
        }
        else{
            print("check")
            invisTextField.resignFirstResponder()
            checkWord()
        }
    }
    func startGame(){
        board.startGame()
        hintLabel.text = board.currentWord?.1
        currentWordLength = 0
        currentLetterCount = 0
        currentIntersectX = 0
        currentIntersectY = 0
        currentOrientation = board.currentOrientation
        intersectionCounted = false
        for y in 0...6{
            for x in 0...8{
                if board.grid[y][x] == " "{
                    buttons[y][x]?.backgroundColor = UIColor(displayP3Red: 49/255, green: 51/255, blue: 53/255, alpha: 1)
                    buttons[y][x]?.isEnabled = false
                }
                else{
                    currentWordLength += 1
                    if currentWordX == nil {
                        currentWordX = x
                        currentWordY = y
                        currentButtonX = x
                        currentButtonY = y
                    }
                }
            }
        }
    }
    func checkWord() {
        if grid.elementsEqual(board.grid, by: ==) {
            let newXY = board.nextBoard()
            print(newXY)
            currentIntersectX = newXY.3
            currentIntersectY = newXY.4
            currentIntersectIndex = newXY.5
            hintLabel.text = board.currentWord?.1
            currentWordLength = newXY.2.0.count
            currentLetterCount = 0
            currentWordX = newXY.0
            currentWordY = newXY.1
            currentOrientation = !currentOrientation!
            intersectionCounted = false
            refreshBoard()
            buttonPressed(buttons[currentWordY!][currentWordX!]!)
        }
        else {
            print("WRONG")
        }
    }
    func refreshBoard() {
        grid = board.grid
        for y in 0...6{
            for x in 0...8{
                if board.grid[y][x] == " "{
                    buttons[y][x]?.backgroundColor = UIColor(displayP3Red: 49/255, green: 51/255, blue: 53/255, alpha: 1)

                    buttons[y][x]?.setTitle(" ", for: .normal)
                }
                else{
                    buttons[y][x]?.isEnabled = true
                    buttons[y][x]?.backgroundColor = UIColor.white
                    if currentWordX == nil {
                        currentWordX = x
                        currentWordY = y
                    }
                }
                if buttons[y][x]?.currentTitle != String(grid[y][x]) {
                    buttons[y][x]?.setTitle(" ", for: .normal)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(invisTextField)
        invisTextField.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
        buttons = [
            [button00, button01, button02, button03, button04, button05, button06, button07, button08],
            [button10, button11, button12, button13, button14, button15, button16, button17, button18],
            [button20, button21, button22, button23, button24, button25, button26, button27, button28],
            [button30, button31, button32, button33, button34, button35, button36, button37, button38],
            [button40, button41, button42, button43, button44, button45, button46, button47, button48],
            [button50, button51, button52, button53, button54, button55, button56, button57, button58],
            [button60, button61, button62, button63, button64, button65, button66, button67, button68]
        ]
        grid = [
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        ]
        currentButtonX = 0
        currentButtonY = 0
        board = Generator()
        view.backgroundColor = UIColor(displayP3Red: 49/255, green: 51/255, blue: 53/255, alpha: 1)
        for i in 0...6{
            for j in 0...8 {
                buttons[i][j]?.setTitle(" ", for: .normal)
                buttons[i][j]?.borderColor = UIColor(displayP3Red: 49/255, green: 51/255, blue: 53/255, alpha: 1)
                buttons[i][j]?.borderWidth = 1
                buttons[i][j]?.X = j
                buttons[i][j]?.Y = i
                
                buttons[i][j]?.backgroundColor = UIColor.white
                buttons[i][j]?.isEnabled = true
            }
        }
        startGame()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.buttonPressed(self.buttons[self.currentButtonY][self.currentButtonX]!)
            })
    }
}

