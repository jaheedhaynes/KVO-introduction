import UIKit

// KVO - KEY Value Observing
// KVO is part of the observer pattern


@objc class Dog: NSObject {
    var name: String
    @objc dynamic var age: Int // age is an observable property with the added '@objc dynamic'
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// Observer Class One
class DogWalker {
    let dog: Dog
    var birthdayObservation: NSKeyValueObservation? // a handle for the property being observed (ex Age of the dog)
    
    init(dog: Dog) {
        self.dog = dog
        configureBirthdayObservation()
    }
    
    func walk() {
        print("Now walking \(dog.name)")
    }
    
    private func configureBirthdayObservation() {
        // \.age is a KEYPATH syntax for KVO observing
        birthdayObservation = dog.observe(\.age, options: [.old, .new], changeHandler: { (dog, change) in
            // update UI accordingly  if in a ViewController class
            guard let age = change.newValue else {return}
            print("Hey \(dog.name), happy \(age) birthday from the dog walker!")
            print("walker oldValue: \(change.oldValue ?? 0)")
            print("walker newValue: \(change.newValue ?? 0)")
            
        })
    }
}

// Observer Class Two
class DogGroomer {
    let dog: Dog
    var birthdayObservation: NSKeyValueObservation?
    
    init(dog: Dog) {
        self.dog = dog
        configureBirthdayObservation()
    }
    
    func groom() {
        print("Now grooming \(dog.name)")
    }
    
    private func configureBirthdayObservation() {
        birthdayObservation = dog.observe(\.age, options: [.old, .new], changeHandler: { (dog, change) in
            guard let age = change.newValue else {return}
            print("Hey \(dog.name), happy \(age) birthday from the dog groomer!")
            print("groomer oldValue: \(change.oldValue ?? 0)")
            print("groomer newValue: \(change.newValue ?? 0)")
        })
    }
}

// TEST out KVO observing the age property of Dog
let snoopy = Dog(name: "Snoopy", age: 5)
let walker = DogWalker(dog: snoopy)
let groomer = DogGroomer(dog: snoopy)

snoopy.age += 1
