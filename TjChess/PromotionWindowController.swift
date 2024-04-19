//
//  PromotionWindowController.swift
//  TjChess
//
//  Created by Tony on 18/04/2024.
//

import Cocoa

class PromotionWindowController : NSWindowController, NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NSApp.stopModal()
    }
}

