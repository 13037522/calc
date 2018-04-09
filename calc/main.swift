//  Created by Reza Vatandoust on 1/4/18.



//  Copyright © 2018 Reza Vatandoust. All rights reserved.



//



// This program is basic command line calculator





import Foundation







let arithmeticOps: Set = ["x","/","+","-"]

let isInteger: Set = ["0","1","2","3","4","5","6","7","8","9"]



//function to calculate alowed operations

func calculate(val1: Int, val2: Int, sign: Character) -> Int {
    
    if val2 == 0 && sign == "/" {
        
        print("Invalid format /0 ")
        
        exit(8)
        
    }
    
    switch sign {
        
    case "x":
        
        return val1 * val2
        
    case "/":
        
        return val1 / val2
        
    case "%":
        
        return val1 % val2
        
    case "+":
        
        return val1 + val2
        
    case "-":
        
        return val1 - val2
        
    default:
        
        return 0
        
    }
    
}



//This function calculates any string of characters back into integers

func calculateValue(char: [Character]) -> Int {
    
    var intArray = [Int]()
    
    var signArray = [Character]()
    
    var charArray = [Character]()
    
    //Put all integer strings in charArray and all signs in signArray
    
    for value in char {
        if value != " "
        {
            if isInteger.contains(String(value)) {
                charArray.append(value)
            }
            else {
                signArray.append(value)
                intArray.append(Int(String(charArray))!)
                charArray.removeAll()
            }
        }
    }
    
    if !charArray.isEmpty {
        
        intArray.append(Int(String(charArray))!)
        
    }
    
    
    
    //get X / % first
    
    var pos = 0
    
    var value = 0
    
    for i in signArray{
        
        if i != "+" && i != "-"{
            
            value = calculate(val1: intArray[pos], val2: intArray[pos+1], sign: i)
            
            intArray.remove(at: pos)
            
            intArray.remove(at: pos)
            
            intArray.insert(value, at: pos)
            
            signArray.remove(at: pos)
            
        }
            
        else {
            
            pos += 1 }
        
    }
    
    pos = 0
    
    if !signArray.isEmpty{
        
        for i in signArray{
            
            value = calculate(val1: intArray[pos], val2: intArray[pos+1], sign: i)
            
            intArray[pos+1] = value
            
            pos += 1
            
        }
        
    }
    
    return value
    
}

// work out brackets first and the rest after

func calcBracketsFirst(strValue: String) -> Int {
    
    var commandLine = Array(strValue)
    
    var bracket = [Character]()
    
    var tally = 0
    
    var counter = 0
    
    var insideBracket = false
    
    var openBracket = false
    
    for item in commandLine {
        
        if (item != "(" && !insideBracket && item != ")") {
            
            counter += 1
            
        }
            
        else {
            
            openBracket = true
            
            if item != "(" && item != ")" {
                
                bracket.append(item)
                
            }
            
            commandLine.remove(at: counter)
            
            insideBracket = true
            
            if item == ")" {
                
                let res: Int = calculateValue(char: bracket)
                
                for i in String(res) {
                    
                    commandLine.insert(i, at: counter)
                    
                    counter += 1
                    
                }
                
                insideBracket = false
                
                openBracket = false
                
                bracket.removeAll()
                
            }
            
        }
        
    }
    
    let res: Int = calculateValue(char: commandLine)
    
    tally = tally + res
    
    if openBracket {
        
        print("incomplete Statement")
        
        exit(5)
        
    }
    
    return tally
    
}



func main() {
    
    var BYE = false
    
    print("Welcome to command line calculator by Reza \n")
    
    print("Type BYE to end\n")
    
    print("Please enter your equation using only Integers \n")
    
    while !BYE {
        
        if let inputLine = readLine() {
            
            if inputLine != "BYE" && inputLine != "" {
                
                let result: Int = calcBracketsFirst(strValue: inputLine)
                
                print(inputLine,"= \(result)")
                
            }
                
            else {
                
                print("Bye!")
                
                BYE = true
                
            }
            
        }
        
    }
    
}



main()
