---
date: 2023-02-07 16:22
description: Book review: Asynchronous Programming with SwiftUI and Combine
tags: Book review
---

# Asynchronous Programming with SwiftUI and Combine

Here's a link to the book on the publisher's website:
[Asynchronous Programming with SwiftUI and Combine](https://link.springer.com/book/10.1007/978-1-4842-8572-5)

You can also find the author's blog and subscribe to his newsletter at: [https://peterfriese.dev](https://peterfriese.dev)

## The TL;DR

The topic of Reactive Programming is incredibly exciting, offering the potential to enhance app development. The book, "Asynchronous Programming with SwiftUI and Combine," has appeals to both experienced developers and beginners alike. The author provides a thorough context for SwiftUI, Reactive Programming, and Swift Concurrency, making it an accessible and informative read. The accompanying Github repository provides code samples for every chapter, allowing you to dive into the practical application of the concepts covered in the book.

## Reactive Programming

I am a big fan of Reactive Programming and I have been a happy user of RxSwift for the past 7 years. RxSwift is an Open Source project that predates Combine and shares many of the same properties. I think that it's also fair to say that RxSwift and the Reactive Extensions programming pattern invented by Eric Meijer must both have influenced and inspired the design of Combine.

One of the bigger issues of Reactive Programming is that it requires a different mindset from imperative programming. This might cause some people to reject the concept, since at first glance it might look unfamiliar and a bit daunting. The ease of onboarding new colleagues to a 'reactive' code base was one of the biggest considerations when making the decision of using RxSwift throughout our code base at Ka-ching.

That's why I was thrilled to learn about Peter Friese's book that explains Reactive Programming (in the context of Combine) and its connection to SwiftUI and Swift Concurrency.

**Peter Friese** is a Senior Developer Advocate at the Google Firebase team and an experienced and enthusiastic software engineer.

## About the book

Part 1 of the book provides a thorough explanation of SwiftUI, from its introduction and theory to practical examples of views, state management, and complex interactions. It's a great resource for those new to SwiftUI and a useful refresher for those already familiar with it.

Part 2 introduces Reactive Programming through Combine and its powerful built-in functionality such as debouncing, automatic cancellation of asynchronous tasks, retrying, deduplication, and more. It's a great introduction for those new to Reactive Programming and a helpful reminder for those who already know about it.

Part 3 takes a look at Swift Concurrency and how this ties into the story of Combine and SwiftUI. It contains examples of code where an `async`/`await` approach is the simpler choice, but also use cases where the powerful operators of Combine provide functionality that would be hard to reproduce in a pure `async`/`await` world.

## Why should you learn about Reactive Programming?

Reactive Programming transforms the way you model your domain by treating it as signals of values that change over time. Adopting this mindset leads to apps that are more responsive and capable of real-time updates in all aspects, from model entities to configuration and theming.

At my job at Ka-ching, we have developed a Point-of-Sale app for iPad, iPhone, and macOS. The back-end is built on real-time updating databases (Firebase Realtime Database and Firestore), which align perfectly with the concept of Reactive Programming.

All model entities in the app, such as products, discount campaigns, currency definitions, exchange rates, and more, are updated in real-time. The same is true for configuration and theming. Customer-facing displays immediately reflect real-time updates of the contents of the "basket" that is being assembled in the POS app.

When you adopt a mindset of modeling your domain as signals of values that change over time, you start to carefully consider the few places where data needs to be locally "constant." For example, in Ka-ching POS, only the shop's id is constant when selecting a shop to log into, but all properties of the shop, such as the market it belongs to, the default currency it uses, and the entire definition of products available in a given market, can change. The same is true when viewing product details, where only the product id is constant, but all other properties of the product can change.

In my opinion, this leads to a great user experience, and it is satisfying to see user reactions to the immediate feedback they receive in the app, whether they are changing properties of a product in the back end, configuration, or theming.

Learning the concepts of Reactive Programming enables you to build this type of app experience, and "Asynchronous Programming with SwiftUI and Combine" is an excellent starting point for learning.