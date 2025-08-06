//
//  IdentifierProtocol.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/4/25.
//

import Foundation
import UIKit

// 1. UIView컨트롤러든 셀이든 대부분 identifier가 필요 : 모든 요소들에 대해 기본적으로 static let identifier를 가지면 안되나(네이밍 규칙도 같아)




//identifier이름을 여기서만 쓰겠다고 일부러 굳이 프로토콜을 만듬
protocol IdentifierProtocol {
    static var identifier: String { get }
}




extension UIViewController: IdentifierProtocol {
    
    //매개변수도 필요없을 거같으니     //연산프로퍼티를 활용해보자
    static var identifier: String {
        
        return String(describing: self)

    }

//    //한공간에서 재생이 되도록 만들어보자
//    func identifier() -> String {
//        
//        return String(describing: self) //네이밍 규칙이 자기 자신 이름이라
//    }

    func idTest() {
        print(self)
        print(String(describing: self))
    }
}

extension UITableViewCell: IdentifierProtocol {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
//    static func identifier() -> String {
//        
//        return String(describing: self)
//    }
    
}

extension UICollectionViewCell: IdentifierProtocol {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
//    static func identifier() -> String {
//        
//        return String(describing: self)
//    }
}
