//
//  ViewController.swift
//  TjChess
//
//  Created by Tony on 26/02/2024.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet private weak var boardView: BoardView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        boardView!.installClickHandler()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

