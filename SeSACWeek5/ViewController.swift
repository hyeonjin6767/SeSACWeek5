//
//  ViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 7/29/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    //let a = APIKey() //굳이 인스턴스 생성할 필요가 없느데 생성은 됨..: 아예 생성도 안되게 막아두자 : private
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(APIKey.kakaoKey) //안에 내용은 깃에서 모름
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //showAlert(title: "상품을 좋아요에 등록할까요", message: "만족스러우신가요?", ok: "저장", vc: self)

        showAlert(title: "테스트", message: "얼럿이 떴어요", ok: "배경바꾸기") {
            print("버튼이 클릭됐어요")
            self.view.backgroundColor = .yellow //이름없는 함수: 클로저가 들어감
        }
    }


}

