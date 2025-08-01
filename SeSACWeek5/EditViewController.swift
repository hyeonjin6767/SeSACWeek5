//
//  EditViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    
    //인트로로 앞화면에서 전달 받아보자
    //var jack: Int?
    //var jack: ((Int) -> Void)?
    //var jack: TransitionViewController? //:뷰컨을 통으로 가져와? : 이게 가능? //우리눈에 보이는 트렌지션뷰컨이 아니라 새로운 인스턴스를 생성한거라 새로운 트렌지션뷰컨인것 : 내가 사용하는 애가 아니야: 게다가 너무 많은 것들이 넘어옴 통째로 싹다. :과해
    var jack: DatePassProtocol? //타입으로서의 프로토콜(DatePassProtocol를 채택받고 있는 누구나 다 해줄께) : 이것도 여전히 과하게 가져오는거긴 한데 그래도 접근가능한게 getRandomNum메서드 하나로 줄어들었으니까.
    
    
    //var space: String? //데이터 받을 공간 : 이전화면에서 문자열 전달옴
    var space: ((String) -> Void)? //함수를 전달 받아보자
    
     
    private let textField1 = UITextField()
    private let textField2 = UITextField()
    private let textField3 = UITextField()
     
    private let button1 = UIButton()
    private let button2 = UIButton()
    private let button3 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(rightButtonTapped))
        
        
        setupUI()
        setupConstraints()
        setupActions()
        
        
        //textField1.text = "숫자 \(jack ?? 0)을 입력햇습니다."
        
//        textField1.text = space //한군데 전달이지만 두군데 받음
//        textField2.text = space //한군데 전달이지만 두군데 받음

        //space?() //스페이스라는 곳에 함수가 들어있으면 함수호출연산자로 실행을 해달라 : 원하는 실행시점으로 옮겨서 사용하면 됨
        
        //jack?.getRandomNum(a: <#T##Int#>) //타입으로서의 프로토콜로 함수만 접근가능
    }
    
    @objc func rightButtonTapped() {
        let vc = NextViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        setupTextField(textField1, placeholder: "Delegate 데이터")
        setupTextField(textField2, placeholder: "Closure 데이터")
        setupTextField(textField3, placeholder: "Notification 데이터")
         
        setupButton(button1, title: "Delegate", color: .systemBlue)
        setupButton(button2, title: "Closure", color: .systemGreen)
        setupButton(button3, title: "Notification", color: .systemOrange)
         
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setupButton(_ button: UIButton, title: String, color: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setupConstraints() {
        // 첫 번째 텍스트필드
        textField1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 첫 번째 버튼
        button1.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 두 번째 텍스트필드
        textField2.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 두 번째 버튼
        button2.snp.makeConstraints { make in
            make.top.equalTo(textField2.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 세 번째 텍스트필드
        textField3.snp.makeConstraints { make in
            make.top.equalTo(button2.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 세 번째 버튼
        button3.snp.makeConstraints { make in
            make.top.equalTo(textField3.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
    }
    
    @objc private func button1Tapped() {
        print("Delegate 버튼 눌림")
        
        
        //jack?(Int.random(in: 1...100))
        //TransitionViewController().getRandomNum(a: <#T##Int#>) : d이렇게 할 순없나?
        let random = Int.random(in: 1...100)
        jack?.getRandomNum(a: random) // 이게 가능? : 이건 왜 안될까?
        
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func button2Tapped() {
        print("Closure 버튼 눌림")
        
        //space?()
        space?(textField2.text!) //매개변수 있는 함수 전달받음

        
        navigationController?.popViewController(animated: true)
    }
    
    
    //Notification 버튼
    @objc private func button3Tapped() {
        print("Notification 버튼 눌림")
        
        
        //NotificationCenter(와이파이같은 느낌) : 이미 만들어져 있는 걸 쓰는거 (Uderdefaults같은애) :post가 "데이터를 전달한다" :포스트에서 방송을 쏨
        //텍스트필드에 작성된 문자를 앞화면 버튼으로 보내주
        NotificationCenter.default.post(
            name: NSNotification.Name("TextEdited"), //메서드명을 만드는 것처럼 이 이름(TextEdited)을 가진 형태로 신호를 보내겠다
            object: nil, //object는 항상 닐
            userInfo: ["nickname": "jack", "text" : textField3.text!]) //userInfo:데이터를 전달하는 구간 :(딕셔너리타입인데 데이터를 안넘길 수도 있어서 닐을 포함을 할수도 있음) ("키:내용" 형태)2개의 내용을 담아서 데이터를 보내겟다 : "addObserver"로 받음
        
        
        
        navigationController?.popViewController(animated: true)
    }
}
