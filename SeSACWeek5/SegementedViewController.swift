//
//  SegementedViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 8/1/25.
//

import UIKit
import SnapKit




// 열거형(인스턴스 생성 불가) : 대신 static은 사용가능(스태틱은타입프로퍼티라서)
//"멤버와 값의 분리" : Int, String :rawValue(원시값): 이건 고유값이라 같은 케이스 네이밍으로 할당 안됨: 그래서 무조건 좋은건 아니라 케이스에 따라 static(얘는 네이밍 중복 가능)과 둘중에 선택해서 사용해야 : cf. Nested Enum
enum Student: Int { //케이스 하나하나를 맴버라고 함 /
    case elementary
    case middle
    case high = 20
    case university //rawValue:21
    
    static let barCancel = "취소" //"취소" 네이밍 중복가능
    static let alertCancel = "취소"
    
    //연산 프로퍼티 활용 : self로 자동완성 가능
    var introduce: String {
        switch self {
        case .elementary:
            return "초등학생입니다."
        case .middle:
            return "중학생입니다."

        case .high:
            return "고등학생입니다."

        case .university:
            return "대학생입니다."

        }
    }
}

class SegmentedViewController: UIViewController {
    
    private let segmentedControl = UISegmentedControl()
    private let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        
        print(Student.elementary)
        print(Student.elementary.rawValue) //0
        print(Student.middle)
        print(Student.middle.rawValue) //1
        print(Student.high)
        print(Student.high.rawValue) //2
        print(Student.university)
        print(Student.university.rawValue) //3 :"rawValue"(원시값) : int값을 채택받고 있기때문에 뽑아볼 수 있는 값 : 알아서 순차적으로 갖음 : 원하는 인트값으로 할당도 가능은 함 : 지정하지 않으면 순차적으로 +1 : high값을 20으로 할당하게 되면 자동으로 university는 21이 됨: 스트링도 채택 가능: 아무것도 할당안하면 스트링을 가지고 있는 멤버 이름과 알아서 같아짐

    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        segmentedControl.insertSegment(withTitle: "초등학생", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "중학생", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "고등학생", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "대학생", at: 3, animated: false)
        
        // 첫 번째 세그먼트를 기본 선택
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .systemGray6
        segmentedControl.selectedSegmentTintColor = .systemBlue
        
        // 레이블 설정
        resultLabel.text = "초등학생입니다"
        resultLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        resultLabel.textAlignment = .center
        resultLabel.textColor = .label
        resultLabel.backgroundColor = .systemGray6
        resultLabel.layer.cornerRadius = 12
        resultLabel.clipsToBounds = true
        
        // 뷰에 추가
        view.addSubview(segmentedControl)
        view.addSubview(resultLabel)
    }
    
    private func setupConstraints() {
        // 세그먼트 컨트롤
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 결과 레이블
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }
    
    private func setupActions() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
        let index = segmentedControl.selectedSegmentIndex
        
        let result = Student(rawValue: index) ?? .university //이렇게도 원시값을 활용가능
        
        var student = Student.elementary
        
        
        //cf.//resultLabel.textAlignment = .center // 이런 쩜센터 들도 열거형이었음..
        //열거형으로 자동완성 가능 : 케이스 숫자 몇번인지 고려하지 않아도 되서 조아
//        switch result {
//        case .elementary:
//            resultLabel.text = result.introduce //"초등학생입니다"
//        case .middle:
//            resultLabel.text = result.introduce //"중학생입니다"
//        case .high:
//            resultLabel.text = result.introduce //"고등학생입니다"
//        case .university:
//            resultLabel.text = result.introduce //"대학생입니다"
//        }
        //케이스가 다 똑같으니 아래처럼 한줄로 끝
        resultLabel.text = result.introduce //연산프로퍼티 활용하면 간결하게 가능
        
//
//        switch index {
//        case 0: resultLabel.text = "초등학생입니다"
//        case 1: resultLabel.text = "중학생입니다"
//        case 2: resultLabel.text = "고등학생입니다"
//        case 3: resultLabel.text = "대학생입니다"
//        default: resultLabel.text = "대학생입니다"
//        }
        
        //아래 이프문을 위의 스위치문으로
        if index == 0 {
            resultLabel.text = "초등학생입니다"
        } else if index == 1 {
            resultLabel.text = "중학생입니다"
        } else if index == 2 {
            resultLabel.text = "고등학생입니다"
        } else if index == 3 {
            resultLabel.text = "대학생입니다"
        }
    }
}

