//
//  Dictionary.swift
//  WordsInTheDark
//
//  Created by Jason Lieu on 4/3/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit

class Dictionary {
    var words : [(String, String)] =
        [   //cannot start with double letters
            ("APPLE", "Red fruit"),
            ("COW", "Moo"),
            ("BOX", "Hollow cube"),
            ("GEM", "Precious stone"),
            ("LAMB", "Young sheep"),
            ("HOME", "____ sweet ____"),
            ("RUN", "Faster than walking"),
            ("JUMP", "Leap in the air"),
            ("BEER", "Booze"),
            ("ZEBRA", "Striped horse"),
            ("SOCK" , "Foot glove"),
            ("WEAK", "Not very strong"),
            ("YELL", "Exclaim loudly"),
            ("ASK", "To question"),
            ("WIPE", "Clean with towel"),
            ("SHOE", "Goes over your sock"),
            ("WIRE", "Electric string"),
            ("ALL", "Everything"),
            ("CAN", "Sealed aluminum cup"),
            ("KELP", "Seaweed"),
            ("USE", "Utilize"),
            ("JUNK" , "Garbage"),
            ("SHIN", "Below the knee"),
            ("KID", "Young person"),
            ("JOG", "Fast walk, slow run"),
            ("WAND", "Magic stick"),
            ("WEST", "Opposite of East"),
            ("QUIZ", "Test"),
            ("ZEN", "Relaxed"),
            ("FIZZ", "Bubbling or hissing"),
            ("COZY", "Comfortable"),
            ("PARTY", "Social gathering"),
            ("BEAR", "Teddy ____"),
            ("HELP", "To support"),
            ("FRAME", "Falsely accuse"),
            ("SORT", "To arrange"),
            ("HAPPY", "Cheerful mood"),
            ("SAD", "Feeling down"),
            ("BEE", "Insects that make honey"),
            ("SWIM", "Propel in water"),
            ("WIND", "Breeze"),
            ("EAST", "Opposite of West"),
            ("WARM", "Hot and cold"),
            ("RAIN", "Water is falling from the sky"),
            ("SUN", "Star"),
            ("CLOUD", "Puffs in the sky"),
            ("PUPPY", "Young dog"),
            ("FELINE", "Kitty"),
            ("AVIAN", "Bird"),
            ("HAT", "Headwear"),
            ("QUICK", "Fast"),
            ("QUEASY", "Nauseous"),
            ("GRAY", "Light black"),
            ("AQUA", "Water"),
            ("WALTZ", "Ballroom dance"),
            ("JEWEL", "Precious gem"),
            ("WIZARD", "Mage"),
            ("JUMBO", "Large"),
            ("BOOTY", "Pirate's treasure"),
            ("SEEK", "Find"),
            ("SHRIMP", "Prawn"),
            ("BISHOP", "Chess piece"),
            ("ROOK", "Chess piece"),
            ("CITRUS", "Oranges and lemons"),
            ("FRUIT", "Apples and oranges"),
            ("QUEUE", "Waiting line"),
            ("DELETE", "Backspace"),
            ("OPTION", "Choice"),
            ("PEPPER", "Salt and ______"),
            ("PINKY", "Promise finger"),
            ("ROCKET", "Spacecraft"),
            ("LABOR", "Manual work"),
            ("PIECE", "Part of a whole"),
            ("LAUNCH", "Blast off"),
            ("ALIEN", "Extraterrestrial"),
            ("RIOT", "Public disturbance"),
            ("PITCH", "Throw"),
            ("GUILD", "Clan"),
            ("ROUND", "No edges"),
            ("LEMON", "Sour fruit"),
            ("GRAPE", "Wine berry"),
            ("GOOSE", "Waterfowl"),
            ("NEXUS", "Center, focal point"),
            ("NARK", "Tattletale"),
            ("ARES", "Greek god of war")
        ]
    var recentlyUsed : [(String, String)] = []

    func mixItUp(){
        words.shuffle()
    }
    func firstWord() -> (String, String){
        let index = Int.random(in: 0..<words.count)
        let result = words[index]
        words.remove(at: index)
        return result
    }
    func pullWordFromDict(intersectLetter: Character, intersectX: Int, intersectY: Int, orientation: Bool) -> ((String, String)?, [String])?{
        if recentlyUsed.count > 4 {
            words.append(recentlyUsed[0])
            recentlyUsed.remove(at: 0)
        }
        for current in words{
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
                        words.remove(at: index!)
                        
                        //check if valid
                        if !checkValid(intersectX: intersectX, intersectY: intersectY, cut: cut, grid: grid, orientation: orientation) {
                            continue
                        }
                        return (current, cut)
                    }
                }
                else {
                    if intersectX - cut[0].count >= 1 && 14 - cut[1].count > intersectX {
                        let index = words.index {
                            $0 == current.0 && $1 == current.1
                        }
                        words.remove(at: index!)
                        if !checkValid(intersectX: intersectX, intersectY: intersectY, cut: cut, grid: grid, orientation: orientation) {
                            continue
                        }
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
                    /*if grid[intersectY - (pre.count - i + 1)][intersectX].horizontal != nil { //is intersecting
                        if grid[intersectY - (pre.count - i + 1)][intersectX].letter != pre[pre.index(pre.startIndex, offsetBy: i - 1)] { //not same letter
                            return false
                        }
                    }*/
                    if grid[intersectY - (pre.count - i + 1)][intersectX].letter != pre[pre.index(pre.startIndex, offsetBy: i - 1)] { //not same letter
                        return false
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
                    /*if grid[intersectY][intersectX - (pre.count - i + 1)].vertical != nil { //is intersecting
                        if grid[intersectY][intersectX - (pre.count - i + 1)].letter != pre[pre.index(pre.startIndex, offsetBy: i - 1)] { //not same letter
                            return false
                        }
                    }*/
                    if grid[intersectY][intersectX - (pre.count - i + 1)].letter != pre[pre.index(pre.startIndex, offsetBy: i - 1)] { //not same letter
                        return false
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
                }
            }
        }
        return true
    }
}
