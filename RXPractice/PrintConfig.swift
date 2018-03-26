//
//  Print.swift
//  EFParents
//
//  Created by yuency on 17/08/2017.
//  Copyright © 2017 yuency. All rights reserved.
//

import Foundation
import QuartzCore

func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\n📍 \((file as NSString).lastPathComponent), line:\(line), \(method), \(message) \n")
    #endif
}

func printInThread() {
    #if DEBUG
        print( "\n〽️ MainThread: \(Thread.main), \n ** CurrentThread: \(Thread.current), \n ** InMain: \(Thread.isMainThread) \n")
    #endif
}

func lllog(_ item: @autoclosure () -> Any) {
    #if DEBUG
        print(item())
    #endif
}

func measure(f: ()->()) {
    let start = CACurrentMediaTime()
    f()
    let end = CACurrentMediaTime()
    print("\n⚡️ Measure Time：\(end - start)")
}
