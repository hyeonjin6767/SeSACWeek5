//
//  ViewController.swift
//  SeSACWeek5
//
//  Created by 박현진 on 7/29/25.
//

import UIKit
import SnapKit
//동기 비동기


class ViewController: UIViewController {
    
    
    //let a = APIKey() //굳이 인스턴스 생성할 필요가 없느데 생성은 됨..: 아예 생성도 안되게 막아두자 : private
    
    
    let imageView = UIImageView()
    let button = UIButton()
    
    let s = UISwitch() //동작이 자연스럽지 않음.. : 지금 전자레인지 한 대뿐이라 : 혼자 다 담당해서 버거워
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //serialSync()
        //serialAsync()
        //concurrentAsync()
        //concurrentSync()
        //globalQualityOfServie()
        //test()
        
        
        dispatchGruopA()
        
        
    }
    
    //DispatchGruop:두가지 방식이 존재
    func dispatchGruopA() {
        
        //1번 방법 : 그룹으로 묶는다.
        //동기메서드에 적합: 왜냐면 알바생이 하청(또 다른알바생)을 줄 수도 있어서 그럼 그 하청 알바생을 관리할 수 없어서 마지막 타이밍을 잡기 어려움: 네트워크통신에는 안쓰는게 좋아서 방법2인 B를 사용
        //알바생들을 하나의 그룸으로 합쳐 : 애들이 일이 끝나면 신호를 보내
        let group = DispatchGroup()
        
        print("AAAAAAAAA")
        DispatchQueue.global().async(group: group) {
            for i in 1...50 {
                print(i)
            }
        }
        print("BBBBBBBBBB")
        DispatchQueue.global().async(group: group) {
            for i in 51...100 {
                print(i)
            }
        }
        print("CCCCCCCC")
        DispatchQueue.global().async(group: group) {
            
             for i in 101...150 {
                 print(i)
             }
        }
        print("DDDDDDDD")
        DispatchQueue.global().async(group: group) {
            for i in 151...200 {
                print(i)
            }
           
        }
        print("EEEEEEEEE")

        //모든 알바생이 끝났다고 신호를 보내면 이 신호를 어떤 알바생에게 전달할까? : 보통 메인알바생(닭벼슬)에게 알려줌
        group.notify(queue: .main) { //가장 마지막에 실행되니까 여기서 테이블뷰를 갱신같은 것을 함
            print("끝났습니다!")
        }
       
        
    }
    
    //2번 방법: 
    func dispatchGruopB() {
        
    }
    
    
    
    
    func test() {
        
        //DispatchQueue.global().async {
            for i in 1...10 {
                //DispatchQueue.global().async {
                print(i, terminator: " ")
                //}
            //}
            //}
            DispatchQueue.global().async {
            for i in 11...20 {
                //DispatchQueue.global().async {
                print(i, terminator: " ")
                //}
            }
            }
                
            //DispatchQueue.global().async {
            for i in 21...30 {
                //DispatchQueue.global().async {
                print(i, terminator: " ")
                //}
            }
            //}
                /*
            //DispatchQueue.global().async {
            for i in 41...50 {
                //DispatchQueue.global().async {
                print(i, terminator: " ")
                //}
            }
            //}
            */
        }
    }
        
        func globalQualityOfServie() {
            
            print("START")
            
            
            
            //여러알바생이 골고루 나눠 일하면//끝나는 타이밍이 일정하지 않아 아쉬운점
            //여러 알바생이 일을 고루 나눠하니까 작업은 더 빨리 끝날 수 있지만 100,200,300중 어느게 마지막에 끝날지 알 수 없는 것이 아쉽다.:
            //마지막이 언제 끝날지 알기 위해서는 우리가 어떻게 해야할까 "DispatchGroup"
            //여러 알바생 중에 동시에 일을 시켜서 빠르게 하고 싶어. 조금 더 빠르게 끝났으면 하는 기능들을 이렇게 사용
            /*
             DispatchQueue.global(qos: .background).async { //qos: .background 여긴 조금 천천히하게
             for i in 1...100 {
             print(i, terminator: " ")
             }
             }
             DispatchQueue.global().async {
             for i in 101...200 {
             print(i, terminator: " ")
             }
             }
             DispatchQueue.global(qos: .userInteractive).async { //qos: .userInteractive로 우선위를 줘보자(부스터)
             for i in 201...300 {
             print(i, terminator: " ")
             }
             }
             print("END")
             */
            
            for i in 1...100 {
                DispatchQueue.global(qos: .background).async { //qos: .background 여긴 조금 천천히하게
                    print(i, terminator: " ")
                }
            }
            
            for i in 101...200 {
                DispatchQueue.global().async {
                    print(i, terminator: " ")
                }
            }
            for i in 201...300 {
                DispatchQueue.global(qos: .userInteractive).async { //qos: .userInteractive로 우선위를 줘보자(부스터)
                    print(i, terminator: " ")
                }
            }
            print("END")
            
        }
        
        func serialSync() { //동기인데 직렬인 형태 :
            
            // 알바생이 4개의일을 혼자 다하는 상황
            print("START", terminator: " ")
            
            //        DispatchQueue.main.sync { //DispatchQueue.main.sync 뜻 : 메인(직렬)이자 싱크(동시) : 이것도 억지로 쓰면 알바생과 중간관리자가 서로 누가먼저일하냐로 무한싸움나서 앱이 터짐 : 교착상태(deadlock, 무한대기상태)
            for i in 1...100 {
                print(i, terminator: " ")
            }
            //        }
            
            
            for i in 101...200 {
                print(i, terminator: " ")
            }
            print("END")
            
        }
        //닭은 다른 알바생에게 일을 보내 놓고도 자기 일을 미루지 않고 실행하는(비동기)
        //다른알바생한테 골고루 안나눠주고 한 알바생에게 몰아줌(직렬)
        func serialAsync() { //비동기이면서 직렬
            print("START", terminator: " ")
            
            DispatchQueue.main.async { //다른 알바생에게 맡겼으니 나는 내 할 일 먼저 하겠다 : 근데 그 다른 알바생도 나였네(main) :그래서 이 일도 마지막에 실행됨
                for i in 1...100 {
                    print(i, terminator: " ")
                }
            }
            for i in 101...200 { //위에보다 먼저 실행됨
                print(i, terminator: " ")
            }
            print("END")
        }
        
        //비동기이면서 동시(concurrent):global()
        //닭은 다른 알바생에게 일을 보내 놓고도 자기 일을 미루지 않고 실행하는(비동기)
        //중간관리자가 일을 여러 알바생에게 골고루 분배해주겠다(동시)
        func concurrentAsync() {
            print("START", terminator: " ")
            
            //        DispatchQueue.global().async { //global이 동시 : 닭벼슬이 다른알바생이 일을 끝내기도 전에 먼저 자기 일을 끝내버린것
            //            for i in 1...100 {
            //                print(i, terminator: " ")
            //            }
            //        }
            for i in 1...100 {
                DispatchQueue.global().async { //100개의 일을 관리자가 골고루 분배하다보니 각기 다른 알바생의 일처리 속도에 따라 일을 처리하다보니 순서가 중구난방
                    print(i, terminator: " ")
                }
            }
            
            for i in 101...200 {
                print(i, terminator: " ")
            }
            print("END")
        }
        
        //동기이면서 동시
        //닭벼슬은 일이 다끝날때까지 놀다가 내 일을 나중에 하겠다 + 다른알바생에게 일을 골고루 나눠줌
        //다른 알바생 중에 닭벼슬(얘도 알바생 중 하나) 니가 해도 마찬가지 잖아 : 실질적으로 메인쓰레드(닭벼슬)이 수행하게 되는 구조 : 그래서 동기+직렬 구조와 같은 결과가 나온것
        func concurrentSync() {
            
            print("START", terminator: " ")
            DispatchQueue.global().sync {
                for i in 1...100 {
                    print(i, terminator: " ")
                }
            }
            for i in 101...200 {
                print(i, terminator: " ")
            }
            print("END")
        }
        
        
        
        //GCD(Grand Central Dispatch) :  비동기 처리 : 기다릴 순 없으니 다른 알바생 :  GCD의 한계로 나온것도 있음 ex)async/await
        //Alamofire가 여태 알아서 해주고 있었음..
        
        func configureView() {
            
            print(APIKey.kakaoKey) //안에 내용은 깃에서 모름
            view.backgroundColor = .yellow
            
            navigationItem.title = "네비게이션 타이틀" //네비게이션 컨트롤러 임베드 필수 : 이것도 코드로
            
            view.addSubview(imageView)
            view.addSubview(button)
            view.addSubview(s)
            
            button.setTitle(("클릭하기"), for: .normal)
            button.backgroundColor = .red
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(100)
            }
            button.snp.makeConstraints { make in
                make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                make.height.equalTo(50)
            }
            s.snp.makeConstraints { make in
                make.center.equalTo(view)
            }
        }
        
        //지금 전자레인지 한 대뿐이라 : 아래 일들 혼자 다 담당해서 버거워
        //알바생(스레드?)을 여러명 두면 해결가능 :여태 우리가 짰던 코드들..
        //여러 알바생을 두고 작업을 나누자 : 그러다보면 중간 관리자가 필요 : 관리자가 균등하게 알맞은 알바생에게 역할 분배
        @objc func buttonClicked() {
            
            //https://apod.nasa.gov/apod/image/2507/Helix_GC_1080.jpg
            //imageView.image = UIImage(named: <#T##String#>)
            //imageView.image = UIImage(systemName: <#T##String#>)
            
            let url = URL(string: "https://apod.nasa.gov/apod/image/2507/Helix_GC_1080.jpg")! // 여기서 시간이 너무 오래 걸려서 스위치가 정상작동X
            print("111111111111")
            
            
            //다른알바생에게 일을 맡기는 것
            //일을 하다 여길 만나면 패스하고 다른 알바생이 알아서 하겠지 하고 아래 자기 일을 먼저 시작 : 비동기
            DispatchQueue.global().async { //다른 알바생에게 맡길 일들을 여기에 복붙
                let data = try! Data(contentsOf: url) // 아직 안배운 문법 try : 나중에
                print("22222222222") //3번보다 나중에 출력
                
                DispatchQueue.main.async {  //ui이미지가 달라지는 행위는 "애플이 정한" 담당 알바생(메인쓰레드:닭벼슬)이 정해져 있어서 무조건 바꿔줘야함
                    self.imageView.image = UIImage(data: data)
                }
            }
            
            //동기(Sync) : 일이 "순서대로" 진행되는것 : 뒤에 일을 하지 않고 기다리는게 동기
            //비동기(Async) : 다른 알바생과 일을 나눠서 하는것 : 중간관리자가(Queue) : 일을 알맞게 분배해줌(동시) : 뒤에 일을 기다리지 않고 순서를 땡겨서 하면 비동기
            //동시(Concurrent) vs 직렬(Serial)(일을 알맞게 분배안해주고 그냥 한 알바생에서 다 맡기는것이 직렬)
            
            //        let data = try! Data(contentsOf: url) // 아직 안배운 문법 try
            //        print("22222222222")
            //        imageView.image = UIImage(data: data)
            print("333333333333333333") //2번보다 먼저 출력
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            
            
            //showAlert(title: "상품을 좋아요에 등록할까요", message: "만족스러우신가요?", ok: "저장", vc: self)
            //
            //        showAlert(title: "테스트", message: "얼럿이 떴어요", ok: "배경바꾸기") {
            //            print("버튼이 클릭됐어요")
            //            self.view.backgroundColor = .yellow //이름없는 함수: 클로저가 들어감
            //        }
        }
    }
    
