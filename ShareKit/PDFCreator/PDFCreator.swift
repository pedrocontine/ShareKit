//
//  PDFCreator.swift
//  ShareKit
//
//  Created by Pedro Contine on 26/01/21.
//

import PDFKit

public class PDFCreator {

    // Draw control
    var elementsToDraw: [Drawable] = []
    var drawElements: [Drawable] = []
    
    // UI
    var pageType: PageType
    var elementsInPage: Int
    var margin: CGFloat
    var title: String
    
    // Initializer for images
    public init(_ images: [UIImage],
                pageType: PageType,
                elementsInPage: Int,
                margin: CGFloat,
                title: String) {
        
        self.pageType = pageType
        self.elementsInPage = elementsInPage
        self.margin = margin
        self.title = title
        
        self.elementsToDraw = images.map { image -> Image in
            Image(image)
        }
    }
    
    public func create() -> PDFDocument? {
        let format = UIGraphicsPDFRendererFormat()

        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        let data = renderer.pdfData { (context) in
            for _ in 1...Int(pageCount) {
                drawPage(in: context)
            }
        }
        
        let document = PDFKit.PDFDocument(data: data)
        var metadata = document?.documentAttributes!
        metadata?[PDFDocumentAttribute.titleAttribute] = title
        document?.documentAttributes = metadata
        
        return document
    }
    
    public func display(in view: UIView) {
        let pdfView = PDFView()

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        pdfView.document = create()
    }
    
    // MARK: - Internal variables
    
    var pageCount: Double {
        round(Double(elementsToDraw.count) / Double(elementsInPage))
    }
    
    var rect: CGRect {
        pageType.size
    }
    
    var availableRect: CGRect {
        let ratio = 1 - ((margin / rect.height) * 2)
        
        let elementHeight = (rect.height * ratio) / CGFloat(elementsInPage)
        let elementWidth = rect.width * ratio
        
        return CGRect(x: 0, y: 0, width: elementWidth, height: elementHeight)
    }
    
    var nextDrawYPos: CGFloat {
        let lastPos = drawElements.last?.rect.yPos ?? margin
        return lastPos >= rect.height ? margin : lastPos
    }
    
    var shouldCenterElement: Bool {
        elementsInPage == 1
    }
    
    private func drawPage(in context: UIGraphicsPDFRendererContext) {
        let elementsToDrawInPage = Array(elementsToDraw.prefix(elementsInPage))
        
        context.beginPage()
        
        for element in elementsToDrawInPage {
            element.draw(in: self)
            drawElements.append(element)
            elementsToDraw.removeFirst()
        }
    }
}
