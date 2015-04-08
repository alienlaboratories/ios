// Database Playground

import Foundation
import XCPlayground

// Allow testing async.
//XCPSetExecutionShouldContinueIndefinitely()

// TODO: Import Nexus, SwiftyJSON
// https://developer.apple.com/library/ios/recipes/xcode_help-source_editor/chapters/ImportingaFrameworkIntoaPlayground.html#//apple_ref/doc/uid/TP40009975-CH27-SW1

//import SwiftyJSON

func test(v: String?) {
    let title = v ?? ""
    println(title)
}

test("Hello")
test(nil)
