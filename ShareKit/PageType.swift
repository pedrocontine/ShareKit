//
//  PageType.swift
//  ShareKit
//
//  Created by Pedro Contine on 30/01/21.
//

import UIKit

public enum PageType {
    case regular
}

extension PageType {
    var size: CGRect {
        switch self {
        case .regular:
            return CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: 11 * 72.0)
        }
    }
}
