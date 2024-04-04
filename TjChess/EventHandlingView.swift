//
//  TjChessView.swift
//  TjChess
//
//  Created by Tony on 30/03/2024.
//

import Cocoa

class EventHandlingView: NSView, EventHandler {
    private var handler: Handler?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        handler = Handler(view: self)
    }
    
    func processEvent(_ event: Event) {
    }
    
    func raiseEvent(_ event: Event) {
        handler!.raiseEvent(event)
    }

    private class Handler: EventHandlerBase {
        private weak var view: EventHandlingView?
        
        init(view: EventHandlingView) {
            super.init(dispatcher: getDispatcher())
            self.view = view
        }
        
        override func processEvent(_ event: Event) {
            view?.processEvent(event)
        }
    }
}


