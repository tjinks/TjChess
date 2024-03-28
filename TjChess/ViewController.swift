//
//  ViewController.swift
//  TjChess
//
//  Created by Tony on 26/02/2024.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet private weak var boardView: BoardView!
    
    private var eventHandler: ViewEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler = ViewEventHandler(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private class ViewEventHandler : EventHandler {
        private weak var viewController: ViewController?
        
        init(_ viewController: ViewController) {
            self.viewController = viewController
            super.init()
        }
        
        override public func processEvent(_ event: Event) -> Bool {
            switch event {
            case .showPosition(let position):
                viewController!.boardView.position = position
                return true
            default:
                return false
            }
        }
    }
}

