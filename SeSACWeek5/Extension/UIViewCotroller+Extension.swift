//
//  UIViewCotroller+Extension.swift
//  SeSACWeek5
//
//  Created by 박현진 on 7/29/25.
//

import Foundation

import UIKit
extension UIViewController {
    
    func showAlert(title: String, message: String, ok: String, okHandler: @escaping () -> Void) { //@escaping는 블럭안에 블럭(함수안에 함수)이라 탈출 시켜달라고 하는 의미 : "탈출 클로저" : 이미 showAlert의 메서드의 생명주기는 끝난 상태(아래 프린트 체크)라 탈출시켜줘야함
        
        print("---------------1---------------")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        //let ok = UIAlertAction(title: ok, style: .default)
//        let ok = UIAlertAction(title: "저장", style: .default) { jack in
//            print(jack.title, "버튼을 클릭했어요")
//        }
        let ok = UIAlertAction(title: "저장", style: .default) { _ in
            print("버튼을 클릭했어요")
            okHandler() //클로저를 실행해달라
            print("---------------3---------------")
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        print("---------------2---------------")

    }
}
