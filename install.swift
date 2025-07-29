//  Created by Fauzi Sholichin on 23/02/2019.
//  Copyright © 2019 Fauzi Sholichin. All rights reserved.
//

import Foundation

// Get the actual logged-in user's home directory (e.g., /Users/yourname)
func getUserHomePath() -> String? {
    // Option 1: Use environment variable $HOME
    if let home = ProcessInfo.processInfo.environment["HOME"], !home.isEmpty {
        return home
    }
    
    // Fallback: Use NSHomeDirectory()
    return NSHomeDirectory()
}

// Template names
let templateMVP = "MVP Kit.xctemplate"
let templateMVVM = "MVVM Kit.xctemplate"
let templateVIPER = "VIPER Kit.xctemplate"

// ✅ Use real user's home, not root's
guard let userHome = getUserHomePath() else {
    print("❌ Could not determine user home directory.")
    exit(1)
}

let xcodeTemplatesPath = "\(userHome)/Library/Developer/Xcode/Templates/Project Templates/Application"

func printInConsole(_ message: Any) {
    print("====================================")
    print("\(message)")
    print("====================================")
}

func moveTemplate() {
    let fileManager = FileManager.default
    let currentDir = fileManager.currentDirectoryPath

    // Ensure destination directory exists
    do {
        if !fileManager.fileExists(atPath: xcodeTemplatesPath) {
            try fileManager.createDirectory(
                atPath: xcodeTemplatesPath,
                withIntermediateDirectories: true,
                attributes: nil
            )
            printInConsole("✅ Created: \(xcodeTemplatesPath)")
        }
    } catch let error {
        printInConsole("❌ Failed to create path: \(error.localizedDescription)")
        return
    }

    let templates = [templateMVP, templateMVVM, templateVIPER]

    for template in templates {
        let src = "\(currentDir)/\(template)"
        let dst = "\(xcodeTemplatesPath)/\(template)"

        guard fileManager.fileExists(atPath: src) else {
            printInConsole("⚠️  Not found: \(src)")
            continue
        }

        do {
            if fileManager.fileExists(atPath: dst) {
                try fileManager.removeItem(atPath: dst)
            }
            try fileManager.copyItem(atPath: src, toPath: dst)
            printInConsole("✅ Installed: \(template) in \(dst)")
        } catch let error {
            printInConsole("❌ Copy failed \(template): \(error.localizedDescription)")
        }
    }

    printInConsole("🎉 Done! Check Xcode → New Project")
}

moveTemplate()
