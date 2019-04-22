//
//  Dictionary.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/3/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit

class Dictionary {
    var words : [(String, String)] = []
    var recentlyUsed : [(String, String)] = []

    func mixItUp(){
        words.shuffle()
    }
    func firstWord() -> (String, String){
        var result : (String, String) = ("","")
        var index = Int.random(in: 0..<words.count)
        while result.0.count > 6 || result.0 == ""{
            index = Int.random(in: 0..<words.count)
            result = words[index]
        }
        words.remove(at: index)
        return result
    }
    func pullWordFromDict(intersectLetter: Character, intersectX: Int, intersectY: Int, orientation: Bool) -> ((String, String)?, [String])?{
        if recentlyUsed.count > 4 {
            words.append(recentlyUsed[0])
            recentlyUsed.remove(at: 0)
        }
        for current in words{
            if current.0.count > 6 {
                continue
            }
            if current.0.contains(intersectLetter){
                let index = words.index {
                    $0 == current.0 && $1 == current.1
                }
                let cut = splitWord(word: current.0, splitLetter: intersectLetter)
                if orientation { // -
                    if intersectY - cut[0].count >= 0 && 6 - cut[1].count > intersectY {
                        words.remove(at: index!)
                        recentlyUsed.append(current)
                        return (current, cut)
                    }
                }
                else {
                    if intersectX - cut[0].count >= 1 && 9 - cut[1].count > intersectX {
                        words.remove(at: index!)
                        recentlyUsed.append(current)
                        return (current, cut)
                    }
                }
            }
        }
        return nil
        //pass in a grid. check if current hits a used square
        //if nil, do 3 more times, if still nil, trapped
        //if trapped, back track one
    }
    func splitWord(word: String, splitLetter: Character) -> [String]{
        var result: [String] = ["" , ""]
        var flip : Bool = true
        for i in word {
            if i == splitLetter && flip{
                flip = !flip
                continue
            }
            if flip {
                result[0].append(i)
            }
            else {
                result[1].append(i)
            }
        }
        return result
    }
    func standardGetWord(intersectLetter: Character, intersectX: Int, intersectY: Int, orientation: Bool, grid: [[StandardSquare]]) -> ((String, String), [String])? {
        for current in words {
            if current.0.count < 4 {
                continue
            }
            if current.0.contains(intersectLetter){
                let cut = splitWord(word: current.0, splitLetter: intersectLetter)
                if orientation {
                    if intersectY - cut[0].count >= 0 && 14 - cut[1].count > intersectY {
                        let index = words.index {
                            $0 == current.0 && $1 == current.1
                        }
                        if !checkValid(intersectX: intersectX, intersectY: intersectY, cut: cut, grid: grid, orientation: orientation) {
                            continue
                        }
                        words.remove(at: index!)
                        return (current, cut)
                    }
                }
                else {
                    if intersectX - cut[0].count >= 1 && 14 - cut[1].count > intersectX {
                        let index = words.index {
                            $0 == current.0 && $1 == current.1
                        }
                        if !checkValid(intersectX: intersectX, intersectY: intersectY, cut: cut, grid: grid, orientation: orientation) {
                            continue
                        }
                        words.remove(at: index!)
                        return (current, cut)
                    }
                }
            }
        }
        return nil
    }
    func checkValid(intersectX: Int, intersectY: Int, cut: [String], grid: [[StandardSquare]], orientation: Bool) -> Bool {
        let pre = cut[0]
        let post = cut[1]
        if orientation {
            if intersectY - pre.count > 0 && grid[intersectY - pre.count - 1][intersectX].letter != " " && intersectY - pre.count > 0 && grid[intersectY - pre.count - 1][intersectX].letter != "-" {
                return false
            }
            if intersectY + post.count < 14 && grid[intersectY + post.count + 1][intersectX].letter != " " && intersectY + post.count < 14 && grid[intersectY + post.count + 1][intersectX].letter != "-" {
                return false
            }
            if pre.count > 0 {
                for i in 1 ... pre.count{
                    if grid[intersectY - (pre.count - i + 1)][intersectX].letter == "-" { //intersect with end of another word
                        return false
                    }
                    if grid[intersectY - (pre.count - i + 1)][intersectX].horizontal != nil { //is intersecting
                        if grid[intersectY - (pre.count - i + 1)][intersectX].letter != pre[pre.index(pre.startIndex, offsetBy: i - 1)] { //not same letter
                            return false
                        }
                    }
                    else {  //not intersection
                        if intersectX > 0 && (grid[intersectY - (pre.count - i + 1)][intersectX - 1].letter != " " &&
                            grid[intersectY - (pre.count - i + 1)][intersectX - 1].letter != "-") {
                            return false //next to another word, left
                        }
                        if intersectX < 14 && (grid[intersectY - (pre.count - i + 1)][intersectX + 1].letter != " " &&
                            grid[intersectY - (pre.count - i + 1)][intersectX + 1].letter != "-") {
                            return false //next to another word, right
                        }
                    }
                }
            }
            if post.count > 0 {
                for i in 1 ... post.count{
                    if grid[intersectY + i][intersectX].letter == "-" {
                        return false
                    }
                    if grid[intersectY + i][intersectX].horizontal != nil {
                        if grid[intersectY + i][intersectX].letter != post[post.index(post.startIndex, offsetBy: i - 1)] {
                            return false
                        }
                    }
                    else {  //not intersection
                        if intersectX > 0 && (grid[intersectY + i][intersectX - 1].letter != " " &&
                            grid[intersectY + i][intersectX - 1].letter != "-") {
                            return false //next to another word, left
                        }
                        if intersectX < 14 && (grid[intersectY + i][intersectX + 1].letter != " " &&
                            grid[intersectY + i][intersectX + 1].letter != "-") {
                            return false //next to another word, right
                        }
                    }
                }
            }
        }
        else{
            // check space before first letter, if is "-" or " "
            if intersectX - pre.count > 0 && grid[intersectY][intersectX - pre.count - 1].letter != "-" && intersectX - pre.count > 0 && grid[intersectY][intersectX - pre.count - 1].letter != " " {
                return false
            }
            if intersectX + post.count < 14 && grid[intersectY][intersectX + post.count + 1].letter != "-" && intersectX + post.count < 14 && grid[intersectY][intersectX + post.count + 1].letter != " " {
                return false
            }
            if pre.count > 0 {
                for i in 1 ... pre.count{
                    if grid[intersectY][intersectX  - (pre.count - i + 1)].letter == "-" { //intersect with end of another word
                        return false
                    }
                    if grid[intersectY][intersectX - (pre.count - i + 1)].vertical != nil { //is intersecting
                        if grid[intersectY][intersectX - (pre.count - i + 1)].letter != pre[pre.index(pre.startIndex, offsetBy: i - 1)] { //not same letter
                            return false
                        }
                    }
                    else {
                        if intersectY > 0 && (grid[intersectY - 1][intersectX  - (pre.count - i + 1)].letter != "-" &&
                            grid[intersectY - 1][intersectX  - (pre.count - i + 1)].letter != " "){
                            return false
                        }
                        if intersectY < 14 && (grid[intersectY + 1][intersectX  - (pre.count - i + 1)].letter != "-" &&
                            grid[intersectY + 1][intersectX  - (pre.count - i + 1)].letter != " "){
                            return false
                        }
                    }
                }
            }
            if post.count > 0 {
                for i in 1 ... post.count{
                    if grid[intersectY][intersectX + i].letter == "-" {
                        return false
                    }
                    if grid[intersectY][intersectX + i].vertical != nil {
                        if grid[intersectY][intersectX + i].letter != post[post.index(post.startIndex, offsetBy: i - 1)] {
                            return false
                        }
                    }
                    else {
                        if intersectY > 0 && (grid[intersectY - 1][intersectX + i].letter != "-" &&
                            grid[intersectY - 1][intersectX + i].letter != " "){
                            return false
                        }
                        if intersectY > 14 && (grid[intersectY + 1][intersectX + i].letter != "-" &&
                            grid[intersectY + 1][intersectX + i].letter != " "){
                            return false
                        }
                    }

                }
            }
        }
        return true
    }
    init() {
        guard let path = Bundle.main.path(forResource: "wordFile", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let parsed = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let wordsArray = parsed as? [Any] else {return}
            for entry in wordsArray {
                guard let wordEntry = entry as? [String: Any] else {return}
                guard let word = wordEntry["word"] as? String else {return}
                guard let hint = wordEntry["hint"] as? String else {return}
                words.append((word, hint))
            }
            
        }
        catch {
            print(error)
        }
    }
}
