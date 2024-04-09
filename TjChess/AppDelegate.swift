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
    let dispatcher = EventDispatcher()
    
    @IBAction func computerPlaysWhite(_ sender: Any) {
        let gameStateDto = try! Notation.parseFen(fen: "k1K5/8/8/8/8/8/8/8 w");
        dispatcher.dispatch(UiEvent.showGameState(state: gameStateDto))
    }
    
    @IBAction func computerPlaysBlack(_ sender: Any) {
    }
    
    @IBAction func computerPlaysItself(_ sender: Any) {
    }
    
    
    @IBAction func enterMoves(_ sender: Any) {
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _ = GameController(dispatcher: dispatcher)
        dispatcher.dispatch(SetGameState(fen: "k7/8/K7/8/8/8/8/8 w"))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

func getDispatcher() -> EventDispatcher {
    let app = NSApplication.shared.delegate as! AppDelegate
    return app.dispatcher
}

