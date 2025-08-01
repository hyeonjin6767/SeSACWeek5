//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import Alamofire


struct Photo : Decodable {
    
    let id: String
    let author: String
    let download_url: String
    
}

class PhotoViewController: UIViewController {
    
    var firstList: [Photo] = []
    var secondList: [Photo] = []

    //테이블뷰 2개 얹기
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.allowsSelection = false //클릭이 아예 안되게
        return tableView
    }() //요건 클로저 함수를 실행하는거고 : 끝에 () 괄호 //역전달시 함수 내용만 전달
    
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        return tableView
    }()
     
    let button = {
       let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.backgroundColor = .brown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        //callRequst()
        //callRequstAuthor()
        
        
        
        //예를 들어 한쪽이 통신 실패시 : group.leave()가 실행이 안되서 : 0이 되기 전까지는 notify하지 않아서 :둘다 테이블뷰 갱신이 안됨
        //네트워크 실패시에도 group.leave()는 실행되도록 해서 테이블뷰가 갱신은 되게 해야함

        
        let group = DispatchGroup()
        //DispatchQueue.global().async(group: group) {
        group.enter() //enter에 대해 +1을 기록, +1을 기록: 총2개의 엔터를 기록
            self.call(url: "https://picsum.photos/v2/list?page=1") { value in
                self.firstList.append(contentsOf: value)
                print("111111111")
                group.leave() //끝나는 시점 확인을 위해: 일끝나서 떠나면 -1이 됨
            }
        //}

        //위아래 둘 중에 어느 콜 메서드가 먼저 끝날지 알 수 없어: DispatchGruop으로 해결?
        print("두명의 알바생 중 누가 먼저 끝낼까")
        //DispatchQueue.global().async(group: group) {
        group.enter()
            self.call(url: "https://picsum.photos/v2/list?page=3") { value in
                self.secondList.append(contentsOf: value)
                print("222222222")
                group.leave()
            }
        //}
        
        // 2에서 0이 되는 순간 notify가 실행됨 //통신이 많을 때 여러번의 갱신을 방지하기 위해 사용됨 : 단 한번만 테이블뷰 갱신을 해
        group.notify(queue: .main) { //가장 마지막에 실행되니까 여기서 테이블뷰를 갱신같은 것을 함
            print("끝났습니다!")
            //동시에 따닥하게 여기서 갱신 : 위에 알바생은 담는 역할만 하고 갱신은 여기서 동시에!
            self.tableView.reloadData()
            self.authorTableView.reloadData()
            print("33333333333")

        }
       
    }
    
    //데이터 통신도 해보자
    //https://picsum.photos/v2/list?page=1
    //struct : id, author, download_url
    //callRequst, callRequstAuthor 2개의 메서드 합치기
    
    //2개(callRequest, callRequstAuthor) 호출 메서드를 합쳐보자
    func call(url: String , completionHandler : @escaping ([Photo]) -> Void) {
        
        AF.request(url).responseDecodable(of: [Photo].self) {
            response in dump(response)
            
            switch response.result {
            case .success(let value):
                
                completionHandler(value)
                
            case .failure(let error):
                print("오류 발생 ")
            }
        }
    }
    
    func callRequest() {
        let url = "https://picsum.photos/v2/list?page=1"
        AF.request(url).responseDecodable(of: [Photo].self) {
            response in dump(response)
            
            //server > struct > array > tableview
            switch response.result {
            case .success(let value):
                    
                
                self.firstList.append(contentsOf: value)
                self.tableView.reloadData()
                
                
            case .failure(let error):
                print("오류 발생 , \(error)")
            }
        }
  
    }
  
    func callRequstAuthor() {
        let url = "https://picsum.photos/v2/list?page=3"
        AF.request(url).responseDecodable(of: [Photo].self) {
            response in dump(response)
            
            //server > struct > array > tableview
            switch response.result {
            case .success(let value):
                    
                self.secondList.append(contentsOf: value)
                self.authorTableView.reloadData()

            case .failure(let error):
                print("오류 발생, \(error)")
            }
        }
    }
 
}

//델리게이트, 데이터소스 이건 한번만 호출 가능
extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        //테이블뷰 2개 얹기
        if tableView == authorTableView {
            return secondList.count
        } else {
            return firstList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == authorTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as! AuthorTableViewCell
            let row = secondList[indexPath.row]
            cell.authorLabel.text = row.author
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            let row = firstList[indexPath.row]
            cell.titleLabel.text = row.author
            //셀의 클릭 자체가 안되게 할 수도 있어
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, tableView)
        
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
     
}

extension PhotoViewController {
    
    func configureHierarchy() {
        view.addSubview(authorTableView)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func configureLayout() {
         
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.top.equalTo(button.snp.bottom)
        }
        
        authorTableView.snp.makeConstraints { make in
            make.leading.equalTo(tableView.snp.trailing)
            make.verticalEdges.equalTo(tableView)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "통신 테스트"
        view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        print(#function)
        
        let vc = DetailViewController()
       
        let nav = UINavigationController(rootViewController: vc) //뒤에 화면에도 네비게이션컨이 있으면 네비아이템바 타이틀 설정 가능
        //navigationController?.pushViewController(vc, animated: true)
        present(nav, animated: true)
        
        //vc.content = "안녕하세요"
        //역으로 값전달 : 클로저 활용 : 스트링 대신 함수를 화면 전환시 전달.
//        vc.content = {
//        self.button.setTitle("안녕하세요", for: .normal)
//        }
        //실행을 하는게 아니라 내용을 전달만하고 실행은 저쪽에서 : 역으로 화면 전달시 함수 그 자체를 전달 저쪽 화면에서 실행을 하지 않으면 실행되지 않음
        
//        vc.content: ((String) -> Void)? = {
//            self.button.setTitle("안녕하세요", for: .normal)
//        }
//
        //역전달이라고 하지만 사실상 그냥 클로저함수를 전달하는 것 : 함수의 실행과 내용을 분리를 해서 역전달처럼 보이게 했다
        //매개변수가 response인 반환값은 없는 함수의 표현
        vc.content = { response in
            self.button.setTitle(response, for: .normal) //response(클로저의 헤더)에 textfield.text글자를
        }
        
    }
}
