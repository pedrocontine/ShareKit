//
//  File.swift
//  ShareKit
//
//  Created by Pedro Contine on 30/01/21.
//

import UIKit

class Image: Drawable {
    var rect: CGRect = .zero
    var image: UIImage
    
    init(_ image: UIImage) {
        self.image = image
    }
    
    func draw(in document: PDFCreator) {
        self.rect = rect(at: document, maxRect: document.availableRect)
        image.draw(in: self.rect)
    }
    
    private func rect(at document: PDFCreator, maxRect: CGRect) -> CGRect {
        let aspectWidth = maxRect.width / image.size.width
        let aspectHeight = maxRect.height / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)
        
        let scaledWidth = image.size.width * aspectRatio
        let scaledHeight = image.size.height * aspectRatio
        
        let imageX = (document.rect.width - scaledWidth) / 2.0
        
        var fixedYPos = document.nextDrawYPos + scaledHeight >= document.rect.height ?
            document.margin :
            document.nextDrawYPos
        
        if document.shouldCenterElement {
            fixedYPos = (document.availableRect.height / 2) - scaledHeight / 2
        }
        
        return CGRect(x: imageX, y: fixedYPos, width: scaledWidth, height: scaledHeight)
    }
}
