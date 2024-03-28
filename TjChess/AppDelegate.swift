//
//  AppDelegate.swift
//  TjChess
//
//  Created by Tony on 26/02/2024.
//

import Cocoa
import ChessLib

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    @IBAction func computerPlaysWhite(_ sender: Any) {
        let position = try! Notation.parseFen(fen: "k1K5/8/8/8/8/8/8/8 w");
        getEventDispatcher().dispatch(.showPosition(position: position))
    }
    
    @IBAction func computerPlaysBlack(_ sender: Any) {
    }
    
    @IBAction func computerPlaysItself(_ sender: Any) {
    }
    
    
    @IBAction func enterMoves(_ sender: Any) {
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

