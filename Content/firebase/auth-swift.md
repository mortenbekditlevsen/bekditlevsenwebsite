---
date: 2023-01-21 20:23
description: Firebase news: Auth is being converted to Swift 
tags: Firebase
---

# Firebase Auth in Swift

Work on porting Firebase Auth to Swift has been initiated by [Paul Beusterien](https://github.com/paulb777) who works for Google on the Firebase Apple SDKs!

This is great news for Swift, since this will eventually enable some use cases for Firebase in Swift that were previously unavailable - like potentially being able to use Firebase in Swift on non-Darwin platforms.

I have a personal goal of using Firebase with Swift server side - and eventually I hope to be able to write my Firebase Functions in Swift too.

A huge part in making this porting effort come true is a Swift Evolution pitch for a SwiftPM addition by [Nick Cooke](https://github.com/ncooke3) from Google: [[Pitch] Adding support for targets with mixed language sources](https://forums.swift.org/t/pitch-adding-support-for-targets-with-mixed-language-sources/61564)

This pitch includes an implementation, so you can already try out mixed-mode targets containing both Objective-C and Swift code. This makes the porting effort much, much easier since you are basically free to focus on any part of the code base that you want, instead of carefully having to convert only types without dependencies, then types that only have dependencies to already converted code, etc., etc.

## Contributing

Since I already started on a similar porting project some time in 2022, I have around 2.600 lines of Swift code (corresponding to roughly 5.500 lines of Objective-C code) already converted.

This was recently merged in to the main branch for this effort: `auth-swift`. So now there's "only" around 7.000 lines of Objective-C code left to port. :-) 

I am absolutely thrilled that this effort is being undertaken 'officially' by the Firebase team, and I hope to be able to contribute more to make this project succeed.

This porting effort made me think of the journey of porting the Real time Database to Swift:

## Porting Firebase components to Swift

In 2021 I started porting the Real Time Database to Swift. My goal is to enable Firebase development with Swift on Linux and potentially also on Android.

As a hobby project, I only worked on this occasionally and it took me almost a year to port more than 20.000 lines of Objective-C code to around 11.000 lines of Swift code. This effort, while not particularly exciting, was still quite rewarding, and in the process I did come across many potential bugs that just can't be made in Swift. It's also nice to see how the verbose Objective-C code with a lot of unnecessary repetition ports to much more readable Swift code.

The porting was made by creating a Swift framework: `FirebaseDatabaseSwiftCore`, which was then imported from `FirebaseDatabase`. This meant that I could only port 'leaf' types without any dependencies, and once these were ported, I then port types that only had dependencies on already ported code. A few places there were quite large chunks of code of several thousands of lines with interdependencies. Here everything needed to be ported in one go before everything was compiling and tests running again.

All the tests are of course also written in Objective-C, so I kept Objective-C compatibility for all types during the port - which of course meant that I couldn't make full use of generics, value types and many other parts of what makes Swift so awesome.

The Real Time Database includes a version of the `SocketRocket` websocket library, an Objective-C wrapper for `LevelDB` called `APLevelDB`, an implementation of a Sorted Dictionary called `FImmutbaleSortedDictionary`, it uses `CommonCrypto` (for sha1 hashing) from the Darwin platform and `NSLock` for atomic access a few places. All of this is conveniently included with the source code so the library does not have a lot of external dependencies. Furthermore it depends on internal Google utilities for logging.

But for the Swift rewrite I wanted all of this to work on Linux, so all dependencies must be cross platform too. I went with `swift-nio` for websocket communication, `SortedCollections` from `swift-collections` (on the `main` branch, but I assume that it will be included on a stable release soon), `swift-crypto`, `swift-atomics` and `swift-logging`. So quite a few dependencies, but all to solid and well tested and maintained packages.

If you're interested in trying out this first attempt, which maintains Objective-C compatibility (and thus supports running the unit tests), you can try it out at: [https://github.com/mortenbekditlevsen/firebase-ios-sdk/tree/swift_experiments](https://github.com/mortenbekditlevsen/firebase-ios-sdk/tree/swift_experiments)

## Making it Swifty
Next step of the porting effort is more fun: Refactoring Objective-C'ish Swift code to something that feels more native to Swift. This of course means using value types rather than reference types, using enumerations with associated values to eliminate class hierarchies and much more.

Since the `NSObject` is only supported on Darwin, this step also required removing all Objective-C support, and also all the existing unit tests. This means that in order to get good coverage again, all tests needs to be converted too, which is a huge effort.

## Current state
The branch at: [https://github.com/mortenbekditlevsen/firebase-ios-sdk/tree/swift_experiments_no_objc](https://github.com/mortenbekditlevsen/firebase-ios-sdk/tree/swift_experiments_no_objc) currently builds and runs on Linux (as well as macOS and iOS).

Since Auth is not yet ported, you may of course only access publicly accessible databases, so it's still very much just a Proof-of-concept.

## Future directions
I think that it would be fine to require support for Swift Concurrency for this project, since it's mainly targeted at the non-Darwin platforms, where backwards compatibility is not really an issue.

This means adding support for `async/await` throughout the entire communications stack, dropping support for assigning a dispatch queue to get callbacks on, implementing atomically incrementing numbers using an actor and much more.