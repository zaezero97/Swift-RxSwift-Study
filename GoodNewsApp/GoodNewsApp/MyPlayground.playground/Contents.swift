import UIKit
import RxSwift
import RxCocoa


let a = BehaviorSubject<String>(value: "")
let b = BehaviorSubject<String>(value: "b")

b.subscribe(a)

b.onNext("abc")
print(try a.value())
