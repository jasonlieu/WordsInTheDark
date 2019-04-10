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
            ("CUP", "Holds water"),
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
            ("USE", "To utilize"),
            ("JUNK" , "Garbage"),
            ("SHIN", "Below the knee"),
            ("KID", "Young person"),
            ("JOG", "Fast walk, slow run"),
            ("WAND", "Magic stick"),
            ("WEST", "Opposite of East"),
            ("EAST", "Opposite of West"),
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
            ("SWIM", "To propel self in water"),
            ("FIRE", "Hot hot hot"),
            ("WIND", "Breeze"),
            ("WATER", "Liquid"),
            ("EYES", "Used for seeing"),
            ("MOUTH", "Food hole"),
            ("WARM", "Sort of hot, sort of cold"),
            ("RAIN", "Water is falling from the sky"),
            ("SUN", "Our big bright star"),
            ("CLOUD", "Puffs in the sky"),
            ("DOG", "Woof woof"),
            ("CAT", "Kitty"),
            ("BIRD", "Avian creature"),
            ("AVIAN", "Bird"),
            ("HAT", "Headwear"),
            ("GET", "To acquire")
        ]
    var recentlyUsed : [(String, String)] = []
    func getWord(letter: Character, orientation: Bool, X: Int, Y: Int) -> (String, String){
        return words[0]
    }
    func firstWord() -> (String, String){
        return words[Int.random(in: 0..<words.count)]
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
                //let cut = current.0.components(separatedBy: String(intersectLetter))
                let cut = splitWord(word: current.0, splitLetter: intersectLetter)
                if cut.count == 1 {
                    let singleCut = cut[0]
                    if intersectLetter == singleCut[singleCut.index(singleCut.startIndex, offsetBy: 0)] {
                        
                    }
                }
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
}
