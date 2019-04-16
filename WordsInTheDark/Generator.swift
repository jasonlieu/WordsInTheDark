//
//  Generator.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/2/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit

class Generator{
    var grid : [[Character]] = []
    let dictionary : Dictionary
    var currentOrientation : Bool       //true -    false |
    var currentWord: (String, String)?
    var currentX : Int!
    var currentY : Int!
    
    var previousWordLength : Int?
    var previousWordX: Int?
    var previousWordY: Int?
    var previousIntersect: Int?
    init() {
        grid = [
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "],
            [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        ]
        dictionary = Dictionary()
        currentOrientation = true
        currentWord = nil
        previousWordX = nil
        previousWordY = nil
        previousIntersect = nil
        previousWordLength = nil
        currentX = 0
        currentY = 0
    }
    func startGame(){
        // first word horizontal -
        dictionary.mixItUp()
        currentWord = dictionary.firstWord()
        var insert : [Character] = []
        currentY = Int.random(in: 3...5)
        currentX = Int.random(in: 1...2)
        for _ in 0..<currentX{
            insert.append(" ")
        }
        for letter in currentWord!.0{
            insert.append(letter)
        }
        for _ in 0...(8 - currentWord!.0.count - currentX){
            insert.append(" ")
        }
        grid[currentY] = insert
    }
    func nextBoard() -> (Int, Int, (String, String), Int, Int, Int) {
        var intersectIndex = Int.random(in: 0 ..< currentWord!.0.count)
        var intersect : Character = currentWord!.0[currentWord!.0.index(currentWord!.0.startIndex, offsetBy: intersectIndex)]
        if previousWordLength == nil {
            previousWordY = currentY
            previousWordX = currentX
            previousWordLength = currentWord!.0.count
            previousIntersect = intersectIndex
        }
        else {
            removeFromGrid(prevX: previousWordX!, prevY: previousWordY!, prevLength: previousWordLength!, prevIntersect: previousIntersect!)
            previousWordY = currentY
            previousWordX = currentX
            previousWordLength = currentWord!.0.count
            previousIntersect = intersectIndex
        }
        if currentOrientation { // ---
            var nextWord = dictionary.pullWordFromDict(intersectLetter: intersect, intersectX: currentX + intersectIndex, intersectY: currentY, orientation: true)
            while nextWord == nil || nextWord!.0! == currentWord! {
                intersectIndex = Int.random(in: 0 ..< currentWord!.0.count)
                previousIntersect = intersectIndex
                intersect = currentWord!.0[currentWord!.0.index(currentWord!.0.startIndex, offsetBy: intersectIndex)]
                nextWord = dictionary.pullWordFromDict(intersectLetter: intersect, intersectX: currentX + intersectIndex, intersectY: currentY, orientation: true)
            }
            let pre = nextWord!.1[0]
            let post = nextWord!.1[1]
            //X = currentX + intersectIndex
            //Y = currentY
            if pre.count > 0 {
                for i in 1...pre.count{
                    grid[currentY - (pre.count - i + 1)][currentX + intersectIndex] = pre[pre.index(pre.startIndex, offsetBy: i - 1)]
                }
            }
            if post.count > 0 {
                for i in 1...post.count{
                    grid[currentY + i][currentX + intersectIndex] = post[post.index(post.startIndex, offsetBy: i - 1)]
                }
            }
            currentOrientation = false
            currentX += intersectIndex
            currentY -= pre.count
            currentWord = nextWord!.0
            return (currentX, currentY, nextWord!.0!, previousWordX!, previousWordY!, previousIntersect!)
        }
        else {
            var nextWord = dictionary.pullWordFromDict(intersectLetter: intersect, intersectX: currentX, intersectY: currentY + intersectIndex, orientation: false)
            while nextWord == nil || nextWord!.0! == currentWord!{
                intersectIndex = Int.random(in: 0 ..< currentWord!.0.count)
                previousIntersect = intersectIndex
                intersect = currentWord!.0[currentWord!.0.index(currentWord!.0.startIndex, offsetBy: intersectIndex)]
                nextWord = dictionary.pullWordFromDict(intersectLetter: intersect, intersectX: currentX, intersectY: currentY + intersectIndex, orientation: false)
            }
            let pre = nextWord!.1[0]
            let post = nextWord!.1[1]
            if pre.count > 0{
                for i in 1...pre.count{
                    grid[currentY + intersectIndex][currentX - (pre.count - i + 1)] = pre[pre.index(pre.startIndex, offsetBy: i - 1)]
                }
            }
            if post.count > 0 {
                for i in 1...post.count{
                    grid[currentY + intersectIndex][currentX + i] = post[post.index(post.startIndex, offsetBy: i - 1)]
                }
            }
            currentOrientation = true
            currentX -= pre.count
            currentY += intersectIndex
            currentWord = nextWord!.0
            return (currentX, currentY, nextWord!.0!, previousWordX!, previousWordY!, previousIntersect!)
        }
    }
    func removeFromGrid(prevX : Int, prevY : Int, prevLength : Int, prevIntersect: Int){
        for i in 0..<prevLength{
            if i != previousIntersect {
                if currentOrientation {
                    grid[prevY + i][prevX] = " "
                }
                else {
                    grid[prevY][prevX + i] = " "
                }
            }
        }
    }
}
