//
//  ViewController.swift
//  SwiftDemo
//
//  Created by JC Harden on 2018/7/28.
//  Copyright © 2018年 JC Harden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func StartAction(_ sender: Any) {
        present(selectorController, animated: true, completion: nil)
    }

}

extension ViewController {
    /// MARK: 用于弹出选择的对话框界面;
    var selectorController: UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil)) // 取消按钮;
        controller.addAction(UIAlertAction(title: "相机", style: .default, handler: { (action) in
            print("调用摄像头")
            self.selectorSourceType(type: .camera)
        }))
        controller.addAction(UIAlertAction(title: "相册", style: .default, handler: { (action) in
            print("调用相册")
            self.selectorSourceType(type: .photoLibrary)
        }))
        return controller
    }
    
    func selectorSourceType(type: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {  // 如果是要访问相机只需要将.photoLibrary改为.camera即可
            print("无法获取相册授权!");
            return
        }
        let picker = UIImagePickerController()
//        picker.allowsEditing = true   // 允许编辑图片;
        picker.sourceType = type  // 选择器访问的是相册(如果是访问相机则将.photoLibrary改为.camere)
        picker.delegate = self  // 设置代理
        if type == .camera {
            picker.cameraDevice = UIImagePickerControllerCameraDevice.front // 设置前摄像头;
            picker.showsCameraControls = true  // 是否显示相机控制器
            picker.videoQuality = UIImagePickerControllerQualityType.typeHigh // 设置摄像图像品质;
        }
        self.present(picker, animated: true, completion: nil)  // 以模态视图弹出选择器
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// UIImagePickerControllerDelegate必须要先设置picker的代理;
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //被点击的图片的信息保存在info字典中;
        let img = info[UIImagePickerControllerOriginalImage]
        self.startButton.setBackgroundImage(img as? UIImage, for: .normal)
        self.startButton.imageView?.contentMode = .scaleAspectFill
        self.startButton.imageView?.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    /// 取消调用相机;
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

