//
//  ViewController.swift
//  CameraFilterApp
//
//  Created by 재영신 on 2021/12/14.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let photoCollectionVC = segue.destination as! PhotoCollectionViewController
        photoCollectionVC.selectedPhoto.subscribe(onNext: {
           [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            print("onNext!!!")
        }, onCompleted: {
            print("onCompleted!!!")
        } ,onDisposed: {
            print("onDisposed!!!")
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func clickApplyButton(_ sender: Any) {
        guard let photo = self.photoImageView.image else { return }
        FilterService().applyFilter(to: photo).subscribe(onNext: {
            image in
            self.photoImageView.image = image
        })
    }
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
}

