//
//  ChatFactory.swift
//  181215_Chat
//
//  Created by Рабочий on 15/12/2018.
//  Copyright © 2018 Рабочий. All rights reserved.
//

import Foundation
import Fakery

class ChatFactory {
    func fakeChats(number: Int) -> [Chat] {
        var outArray = [Chat]()
        let faker = Faker(locale: "ru")
        for _ in 0..<number {
            let user = User(id: faker.number.randomInt(),
                            name: faker.name.firstName() + " " + faker.name.lastName())
            let messages = fakeUserMessages(number: faker.number.randomInt(min: 10, max: 20),
                                            user: user)
            let chat = Chat(id: faker.number.randomInt(), user: user, messages: messages)
            outArray.append(chat)
        }
        outArray.sort { $0.messages.last?.date ?? Date() > $1.messages.last?.date ?? Date() }
        return outArray
    }
    
    private func fakeUserMessages(number: Int, user: User) -> [UserMessage] {
        var outArray = [UserMessage]()
        let faker = Faker(locale: "ru")
        for _ in 0..<number {
            var finalUser = user
            if(faker.number.randomBool()) {
                finalUser = SelfUser.user
            }
            let message = UserMessage(id: faker.number.randomInt(),
                                      text: faker.lorem.sentence(),
                                      date: Date(timeInterval: faker.number.randomDouble(),
                                                 since: Calendar.current.date(bySettingHour: 12,
                                                                              minute: 0,
                                                                              second: 0,
                                                                              of: Date())!),
                                      user: finalUser)
            outArray.append(message)
        }
        outArray.sort { $0.date > $1.date }
        return outArray
    }
}
