//
//  TransitionViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit


protocol DatePassProtocol {
    func getRandomNum(a: Int)
}



class TransitionViewController: UIViewController {
    
    private let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        
        
        //포스트(와이파이같은놈)로 보내는걸 받겠다
        NotificationCenter.default.addObserver(
            self, //누기 처리할지 : 자기 자신
            selector: #selector(notificationReceived),
            name: NSNotification.Name("TextEdited"), //라디오 주파수처럼 안맞으면 안되서 TextEdited로 설정한 이름 스펠링 주의
            object: nil)
        
        
    }
    //Name("TextEdited") 이 이름을 통해 신호를 받아서 셀렉터의 함수를 실행
    //addObserver가 신호를 받으면 뭘 실행을 해줄지 에드타겟과 유사
    @objc func notificationReceived(notification: NSNotification) {
        print(#function)
        
        //let a = [3: "안녕", 6: "하이"] //딕셔너리는 옵셔널
        //a[3] //안녕
        //a[6] //하이
        // 매개변수 notification을 통해 :userInfo라는 프로퍼티의 딕셔너리에 내용을 숨겨둔 상태에서 키값으로 접근
        print(notification.userInfo?["nickname"]) //userInfo, 딕셔너리 둘다 자체가 옵셔널 //벨류 "jack" 출력
        print(notification.userInfo?["text"]) //입력 값이 없어서 ""로 출력
        print(notification.userInfo?["jack"]) //없는 키: nil 출력

        //text키에 값이 있으면 text에 담아서 스트링으로
        //userInfo가 벨류 타입이 Any라서 우리는 스트링으로 필요하니까 옵셔널 바인딩(이프렛)으로 스트링으로 떨어지는 친구인지 확인이 필요 + text키에 값이 있는지
        //셀 매칭하는 것처럼 스트링타입으로도 연결이 되는지 체크
        if let text = notification.userInfo?["text"] as? String { //text에 데이터가 있는지랑 그게 스트링인지 확인후 맞으면 text에 넣어달라
            print(type(of: notification.userInfo?["text"]))
            centerButton.setTitle(text, for: .normal)
        }

    }
    
    private func setupUI() {
        view.addSubview(centerButton)
        view.backgroundColor = .white
         
        centerButton.setTitle("중앙 버튼", for: .normal)
        centerButton.setTitleColor(.white, for: .normal)
        centerButton.backgroundColor = .purple
        centerButton.layer.cornerRadius = 8
         
        centerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        // SnapKit을 사용하여 버튼을 화면 정중앙에 배치
        centerButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    //델리게이트 버튼
    @objc private func buttonTapped() {
        
        let vc = EditViewController() 
        
        //vc.jack = Int.random(in: 1...100)
        //vc.jack = getRandomNum // 함수 자체 전달
        //vc.jack = self //나자신을 넘겨주기? : 이게 가능? //"타입으로서의 프로토콜"로 변경해서 해결해보자 : 같은 프로토콜을 채택하고 있으면 서로 다 들어갈수 있어
        
        
        
        
        //vc.space = "앞화면에서 데이터 전달합니다."
        //변수에 함수 넣기
        //vc.space = test //함수 내용만 전달: 실행은 아직 : 실행은 받은 쪽에서 원하는 시점에 실행
        vc.space = { name in //name(클로저의 헤더)
            //클로저의 바디 : 내용 부분
            print("안녕하세요 저는 고래밥입니다")
            self.centerButton.setTitle(name, for: .normal)
        }
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // (Int) -> Void
//    func getRandomNum(a: Int) {
//        
//        self.centerButton.setTitle("숫자\(a)", for: .normal)
//    }
    
    
    // () -> Void 형태 함수를 스페이스에 전달해보자
    // (String) -> Void 형태로 변경 : 담음 ㄹ그릇도 같이 변경
//    func test(name: String) {
//        print("안녕하세요 저는 고래밥입니다")
//        centerButton.setTitle(name, for: .normal)
//    }
    //이름없는 함수로도 변경가능 : 위로 함수 내용 복붙 : name in~

}

extension TransitionViewController : DatePassProtocol {
    func getRandomNum(a: Int) {
        self.centerButton.setTitle("숫자\(a)", for: .normal)
    }
    
    
}


