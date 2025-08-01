//
//  DetailViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 7/31/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    let textfield = UITextField()
    
    
    //var content: String?
    //var content: (() -> Void)? //스트링이 아니라 빈 함수를 값전달시 담는 그릇 역할로 "클로저"를 사용 : 역전달
    var content: ((String) -> Void)? //스트링을 매개변수로 가진 함수를 받는 그릇
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Detail", #function)
        view.backgroundColor = .lightGray

        navigationItem.title = "디테일 화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        
        view.addSubview(textfield)
        
        textfield.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        textfield.placeholder = "입력해보세요"
        //textfield.text = content
        
        //responder chain : 우리가 화면 터치시에 체인방식으로 다 연결해주는 것 : 가장첫반응 연결
        textfield.becomeFirstResponder() //화면전환이 될때 동시에 키보드가 뜨게 하는 : 위치는 뷰디드로드일수도 다른데 일수도
        
    }
    
    @objc func closeButtonClicked() {
        print(#function)
        
        
        //content?()
        //버튼 클릭시 content메서드를 실행 : content프로퍼티 자체가 옵셔널이라 물음표
        content?(textfield.text!)

        dismiss(animated: true)
        
        //responder chain
        textfield.resignFirstResponder() //더이상 반응할 필요가 없다는 뜻: 키보드가 내려감(엔드에디팅같은)
        
    }
    


}
