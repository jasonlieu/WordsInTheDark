//
//  StandardGenerator.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/11/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit

class StandardGenerator {
    let dictionary : Dictionary = Dictionary()
    var wordHistory : [((String, String), Int, Int, Bool)] = [] //(word, hint) , X, Y, orientation
    var currentWord : (String, String) = (" ", " ")
    var currentX : Int = 1
    var currentY : Int = 1
    var currentOrientation : Bool = true
    var grid : [[StandardSquare]] = (0...14).map { _ in (0...14).map { _ in StandardSquare() } }
    func startGame(){
        dictionary.mixItUp()
        currentWord = dictionary.firstWord()
        while currentWord.0.count < 4 {
            currentWord = dictionary.firstWord()
        }
        var index = 0
        if currentX - 1 >= 0 {
            grid[currentY][currentX - 1].letter = "-"
        }
        for letter in currentWord.0 {
            grid[currentY][currentX + index].letter = letter
            grid[currentY][currentX + index].horizontal = (currentX, currentY, currentWord.0.count)
            index += 1
        }
        grid[currentY][currentX + index].letter = "-"
        wordHistory.insert((currentWord, currentX, currentY, currentOrientation), at: 0)
    }
    func nextBoard(){
        var pass : Bool =  nextBoardAlg(word: currentWord, x: currentX, y: currentY)
        print(currentOrientation)
        while !pass {
            if wordHistory.count == 0 {
                gameOver()
                return
            }
            else {
                currentWord = wordHistory[0].0
                currentX = wordHistory[0].1
                currentY = wordHistory[0].2
                currentOrientation = wordHistory[0].3
                print("backtrack cW: ", currentWord, "cX: ", currentX, "cY:",currentY)
            }
            pass = nextBoardAlg(word: currentWord, x: currentX, y: currentY)
            wordHistory.remove(at: 0)
        }
        currentOrientation = !currentOrientation
        wordHistory.insert((currentWord, currentX, currentY, currentOrientation), at: 0)
        print(wordHistory)
        print("cW: ", currentWord, "cX: ", currentX, "cY:",currentY)
    }
    func nextBoardAlg(word: (String, String), x: Int, y: Int) -> Bool {
        var intersectIndex = Int.random(in: 0...1)
        var nextWord : ((String, String), [String])? = nil
        print(intersectIndex)
        while nextWord == nil {
            if currentOrientation {
                var eligible : Bool = false
                while !eligible {
                    if grid[currentY][currentX + intersectIndex].vertical != nil { //chosen index is already intersection
                        intersectIndex += 2
                        print("-1",intersectIndex)
                    }
                    else if currentX + intersectIndex > 0 && grid[currentY][currentX + intersectIndex - 1].vertical != nil { //has int on left
                        intersectIndex += 1
                        print("-2", intersectIndex)
                    }
                    else if currentX + intersectIndex < 14 && grid[currentY][currentX + intersectIndex + 1].vertical != nil { //has int on right
                        intersectIndex += 3
                        print("-3", intersectIndex)
                    }
                    else { eligible = true }
                    
                    if intersectIndex >= grid[currentY][currentX].horizontal!.2 { //intersectIndex passed word length
                        print("nextBoardAlg - false")
                        return false
                    }
                }
                let intersect : Character = currentWord.0[currentWord.0.index(currentWord.0.startIndex, offsetBy: intersectIndex)]
                nextWord = dictionary.standardGetWord(intersectLetter: intersect, intersectX: currentX + intersectIndex, intersectY: currentY, orientation: currentOrientation, grid: grid)
            }
            else {
                var eligible : Bool = false
                while !eligible {
                    if grid[currentY + intersectIndex][currentX].horizontal != nil {
                        intersectIndex += 2
                        print("|1",  intersectIndex)
                    }
                    else if currentY + intersectIndex > 0 && grid[currentY + intersectIndex - 1][currentX].horizontal != nil {
                        intersectIndex += 1
                        print("|2",intersectIndex)
                    }
                    else if currentY + intersectIndex < 14 && grid[currentY + intersectIndex + 1][currentX].horizontal != nil {
                        intersectIndex += 3
                        print("|3",intersectIndex)
                    }
                    else { eligible = true }
                    print("|", intersectIndex, grid[currentY][currentX].vertical!.2)
                    if intersectIndex >= grid[currentY][currentX].vertical!.2 {
                        print("nextBoardAlg | false")
                        return false
                    }
                }
                let intersect : Character = currentWord.0[currentWord.0.index(currentWord.0.startIndex, offsetBy: intersectIndex)]
                nextWord = dictionary.standardGetWord(intersectLetter: intersect, intersectX: currentX, intersectY: currentY + intersectIndex, orientation: currentOrientation, grid: grid)
            }
            if nextWord == nil {
                print("nextWord is nil")
                intersectIndex += 1
                
            }
        }
        insertInGrid(cut: nextWord!.1, intersectIndex: intersectIndex, orientation: currentOrientation)
        currentWord = nextWord!.0
        return true
    }
    func insertInGrid(cut: [String], intersectIndex: Int, orientation: Bool) {
        let pre = cut[0]
        let post = cut[1]
        if currentOrientation { //new word is |
            print("insert vertical")
            if currentY - pre.count > 0 {
                grid[currentY - pre.count - 1][currentX + intersectIndex].letter = "-"
            }
            if pre.count > 0 {
                for i in 1 ... pre.count {
                    grid[currentY - (pre.count - i + 1)][currentX + intersectIndex].letter = pre[pre.index(pre.startIndex, offsetBy: i - 1)]
                    grid[currentY - (pre.count - i + 1)][currentX + intersectIndex].vertical = (currentX + intersectIndex, currentY - pre.count, cut[0].count + cut[1].count + 1)
                }
            }
            grid[currentY][currentX + intersectIndex].vertical = (currentX + intersectIndex, currentY - pre.count, cut[0].count + cut[1].count + 1)
            if post.count > 0 {
                for i in 1 ... post.count {
                    grid[currentY + i][currentX + intersectIndex].letter = post[post.index(post.startIndex, offsetBy: i - 1)]
                    grid[currentY + i][currentX + intersectIndex].vertical = (currentX + intersectIndex, currentY - pre.count, cut[0].count + cut[1].count + 1)
                }
            }
            if currentY + post.count < 14 {
                grid[currentY + post.count + 1][currentX + intersectIndex].letter = "-"
            }
        }
        else {
            print("insert horizontal")
            if currentX - pre.count > 0 {
                grid[currentY + intersectIndex][currentX - pre.count - 1].letter = "-"
            }
            if pre.count > 0 {
                for i in 1 ... pre.count {
                    grid[currentY + intersectIndex][currentX - (pre.count - i + 1)].letter = pre[pre.index(pre.startIndex, offsetBy: i - 1)]
                    grid[currentY + intersectIndex][currentX - (pre.count - i + 1)].horizontal = (currentX - pre.count, currentY + intersectIndex, cut[0].count + cut[1].count + 1)
                }
            }
            grid[currentY + intersectIndex][currentX].horizontal = (currentX - pre.count, currentY + intersectIndex, cut[0].count + cut[1].count + 1)
            if post.count > 0 {
                for i in 1 ... post.count {
                    grid[currentY + intersectIndex][currentX + i].letter = post[post.index(post.startIndex, offsetBy: i - 1)]
                    grid[currentY + intersectIndex][currentX + i].horizontal = (currentX - pre.count, currentY + intersectIndex, cut[0].count + cut[1].count + 1)
                }
            }
            if currentX + post.count < 14 {
                grid[currentY + intersectIndex][currentX + post.count + 1].letter = "-"
            }
        }
        if currentOrientation {
            currentX += intersectIndex
            currentY -= pre.count
        }
        else {
            currentX -= pre.count
            currentY += intersectIndex
        }
    }
    func gameOver(){
    }
}
