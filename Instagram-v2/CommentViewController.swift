//
//  CommentViewController.swift
//  Instagram-v2
//
//  Created by TECH_ACADEMY on 2021/01/05.
//  Copyright © 2021 tetsushi.miwa. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var commentData: PostData!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func commentAddButton(_ sender: Any) {
        if let displaycomment = commentTextField.text{
            // コメント未入力の場合
            if displaycomment.isEmpty{
                SVProgressHUD.showError(withStatus: "コメントを入力してください")
                return
            }
            
            // ユーザー情報
            let commentUser = Auth.auth().currentUser?.displayName
            
            // 更新データを作成
            var updateValue: FieldValue
            
            // 投稿データの保存場所を定義する
            let postRef = Firestore.firestore().collection(Const.PostPath).document(commentData.id)
            updateValue = FieldValue.arrayUnion([commentUser! + " : " + displaycomment])
            postRef.updateData(["comments": updateValue])
            
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func commentCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
