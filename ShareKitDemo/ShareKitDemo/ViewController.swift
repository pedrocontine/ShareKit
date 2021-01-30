//
//  ViewController.swift
//  ShareKitDemo
//
//  Created by Pedro Contine on 26/01/21.
//

import UIKit
import ShareKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images: [UIImage] = [loadTestImage(named: "document", ext: "JPG"),
                                 loadTestImage(named: "image", ext: "png")]
        
        let pdfCreator = PDFCreator(images, pageType: .regular, elementsInPage: 2, margin: 30)
        pdfCreator.display(in: view)
    }
    
    func loadTestImage(named: String, ext: String) -> UIImage {
        guard let path = Bundle.main.url(forResource: named, withExtension: ext)?.path,
              let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        
        return image
    }
}

