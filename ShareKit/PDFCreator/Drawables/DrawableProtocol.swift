//
//  DrawableProtocol.swift
//  ShareKit
//
//  Created by Pedro Contine on 30/01/21.
//

import UIKit

public protocol Drawable {
    var rect: CGRect { get set }
    func draw(in document: PDFCreator)
}
