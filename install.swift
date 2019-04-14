//  Created by Fauzi Sholichin on 23/02/2019.
//  Copyright © 2019 Fauzi Sholichin. All rights reserved.
//

import Foundation

let templateMVP = "MVP Kit.xctemplate"
let templateMVVM = "MVVM Kit.xctemplate"
let destinationRelativePath = "/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application"

func printInConsole(_ message:Any){
    print("====================================")
    print("\(message)")
    print("====================================")
}

func moveTemplate(){

    let fileManager = FileManager.default
    let destinationPath = bash(command: "xcode-select", arguments: ["--print-path"]).appending(destinationRelativePath)
    do {
        if !fileManager.fileExists(atPath:"\(destinationPath)/\(templateMVP)"){
        
            try fileManager.copyItem(atPath: templateMVP, toPath: "\(destinationPath)/\(templateMVP)")
            
            printInConsole("✅  Architecture Kit MVP installed succesfully 🎉. Enjoy it 🙂")
            
        }else{
            
            try _ = fileManager.replaceItemAt(URL(fileURLWithPath:"\(destinationPath)/\(templateMVP)"), withItemAt: URL(fileURLWithPath:templateMVP))
            
            printInConsole("✅  Architecture Kit MVP already exists. So has been replaced succesfully 🎉. Enjoy it 🙂")
        }

        if !fileManager.fileExists(atPath:"\(destinationPath)/\(templateMVVM)"){
        
            try fileManager.copyItem(atPath: templateMVVM, toPath: "\(destinationPath)/\(templateMVVM)")
            
            printInConsole("✅  Architecture Kit MVVM installed succesfully 🎉. Enjoy it 🙂")
            
        }else{
            
            try _ = fileManager.replaceItemAt(URL(fileURLWithPath:"\(destinationPath)/\(templateMVVM)"), withItemAt: URL(fileURLWithPath:templateMVVM))
            
            printInConsole("✅  Architecture Kit MVVM already exists. So has been replaced succesfully 🎉. Enjoy it 🙂")
        }
    }
    catch let error as NSError {
        printInConsole("❌  Ooops! Something went wrong 😡 : \(error.localizedFailureReason!)")
    }
}

func shell(launchPath: String, arguments: [String]) -> String
{
    let task = Process()
    task.launchPath = launchPath
    task.arguments = arguments
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: String.Encoding.utf8)!
    if output.characters.count > 0 {
        //remove newline character.
        let lastIndex = output.index(before: output.endIndex)
        return String(output[output.startIndex ..< lastIndex])
    }
    return output
}

func bash(command: String, arguments: [String]) -> String {
    let whichPathForCommand = shell(launchPath: "/bin/bash", arguments: [ "-l", "-c", "which \(command)" ])
    return shell(launchPath: whichPathForCommand, arguments: arguments)
}

moveTemplate()
