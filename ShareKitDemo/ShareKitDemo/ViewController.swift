//
//  ViewController.swift
//  ShareKitDemo
//
//  Created by Pedro Contine on 26/01/21.
//

import UIKit
import ShareKit

class ViewController: UIViewController {

    private var pdfCreator: PDFCreator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images: [UIImage] = [loadTestImage(named: "document", ext: "JPG"),
                                 loadTestImage(named: "image", ext: "png")]
        
        pdfCreator = PDFCreator(images, pageType: .regular, elementsInPage: 2, margin: 30, title: "Documents")
    }
    
    @IBAction func showPDFPreview() {
        pdfCreator?.display(in: view)
    }
    
    @IBAction func shareButtonPressed() {
        guard let itemsToShare = pdfCreator?.create()?.dataRepresentation() else {
            return
        }
        
        ShareView.present(in: self, itemsToShare: [itemsToShare], removeShareOptions: [])
    }
    
    func loadTestImage(named: String, ext: String) -> UIImage {
        guard let path = Bundle.main.url(forResource: named, withExtension: ext)?.path,
              let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        
        return image
    }
}

