//
//  MockData.swift
//  CoreFlow
//
//  Created by Maksim on 5/14/26.
//

import Foundation

enum MockData {

    static let clubs: [Club] = [
        Club(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "House of Gravel",
            city: "Санкт-Петербург",
            sportTypes: [.gravel],
            description: "Гравийный велоклуб.",
            telegramURL: "https://t.me/houseofgravel",
            telegramUsername: "houseofgravel"
        ),
        Club(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "VTR",
            city: "Санкт-Петербург",
            sportTypes: [.road, .gravel],
            description: "Экипировка для велоспорта, триатлона и бега",
            telegramURL: "https://t.me/vetercc",
            telegramUsername: "vetercc"
        ),
        Club(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "SputnikRun",
            city: "Санкт-Петербург",
            sportTypes: [.run],
            description: "Беговой городской клуб «Спутник».\nTrips & parties, coffee runs every saturday.",
            telegramURL: "https://t.me/sputnikrun",
            telegramUsername: "sputnikrun"
        ),
        Club(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            name: "SputnikRide",
            city: "Санкт-Петербург",
            sportTypes: [.road],
            description: "CoffeeRide по вторникам\nLongRide по воскресеньям\nВелокемпы по России",
            telegramURL: "https://t.me/sputnikride",
            telegramUsername: "sputnikride"
        ),
        Club(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            name: "easy.cc",
            city: "Москва",
            sportTypes: [.road, .gravel],
            description: "social rides, cycling camps and trips\nmoscow and worldwide. only road/gravel  ",
            telegramURL: "https://t.me/easycyclingclub",
            telegramUsername: "easycyclingclub"
        )
    ]

    static let workouts: [Workout] = [
        Workout(
            id: UUID(),
            title: "SR25/16",
            date: makeDate(daysFromNow: 6, hour: 7),
            meetingTime: makeDate(daysFromNow: 6, hour: 7),
            startTime: makeDate(daysFromNow: 6, hour: 7, minute: 30),
            location: "Старт от Skuratov Coffee в ДК Кирова на Большом пр. ВО, 83\nФиниш в Старте на Газовой, 10",
            distanceKm: 25,
            elevationM: 126,
            surfaceMix: "асфальт 100%",
            paceDescription: "~28 км/ч",
            requirements: "Обязательные правила наших заездов:\n• велосипеды шоссейного типа с рулем-бараном\n• шлем",
            description: "Фильтр и шиповник на старте и фильтр или б/а пиво на выбор на финише",
            routeURL: "https://ridewithgps.com/routes/52685382",
            telegramPostURL: "https://t.me/sputnikride/325",
            sportType: .road,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            posterURL: "https://res.cloudinary.com/du6prhxao/image/upload/v1778881199/photo_2026-05-16_00.14.48_wlmvhg.jpg"
        ),
        Workout(
            id: UUID(),
            title: "VTR x HoG",
            date: makeDate(daysFromNow: 3, hour: 9),
            meetingTime: makeDate(daysFromNow: 3, hour: 9),
            startTime: makeDate(daysFromNow: 3, hour: 9, minute: 30),
            location: "Лиговский проспект, 232, парадная 17",
            distanceKm: 80,
            elevationM: 450,
            surfaceMix: "грунт/асфальт 40/60%",
            paceDescription: "асфальт ~30 км/ч, гравий ~26 км/ч",
            requirements: "Шоссе или гравел, шлем, руль баран",
            description: "С нашими друзьями, гравийным клубом HoG, отправляемся на юг Ленинградской области на 100-километровый круговой техничный и очень красивый маршрут. На старте и финише: Кофе и выпечка",
            routeURL: "https://strava.com/routes/123",
            telegramPostURL: "https://t.me/vetercc/3720",
            sportType: .gravel,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            posterURL: "https://res.cloudinary.com/du6prhxao/image/upload/v1779313632/photo_2026-05-21_00.45.17_gznzow.jpg"
        ),
        Workout(
            id: UUID(),
            title: "Завтра бежим от Noam!",
            date: makeDate(daysFromNow: 14, hour: 10, minute: 00),
            meetingTime: makeDate(daysFromNow: 14, hour: 10, minute: 00),
            startTime: makeDate(daysFromNow: 14, hour: 10, minute: 30),
            location: "Noam (Ждановская ул., 45)",
            distanceKm: 10,
            elevationM: nil,
            surfaceMix: nil,
            paceDescription: "6:30 – 10",
            requirements: "В кофейне можно переодеться, оставить вещи, попить воды.",
            description: "В программе как всегда: классный маршрут, вкусный завтрак с фильтром, новые знакомства и общение.",
            routeURL: nil,
            telegramPostURL: "https://t.me/sputnikrun/2319",
            sportType: .run,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!
        ),
        Workout(
            id: UUID(),
            title: "Длинный выезд 100 км",
            date: makeDate(daysFromNow: 5, hour: 10),
            meetingTime: makeDate(daysFromNow: 5, hour: 10),
            startTime: makeDate(daysFromNow: 5, hour: 10, minute: 30),
            location: "Центральный вокзал",
            distanceKm: 100,
            elevationM: 607,
            surfaceMix: "грунт/асфальт 40/60%",
            paceDescription: "грунт 25-27 км/ч, асфальт 32-37 км/ч",
            requirements: "Гравел, циклокросс или эндуранс, руль баран, шлем, фара и фонарь",
            description: "Едем прошлогодний маршрут. Карьеры, леса, красивые дороги. На старте угостят кофе.",
            routeURL: "https://ridewithgps.com/routes/51801807",
            telegramPostURL: "https://t.me/veloriga/124",
            sportType: .road,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            posterURL: nil
        ),
        Workout(
            id: UUID(),
            title: "Утренняя пробежка для начинающих",
            date: makeDate(daysFromNow: 4, hour: 8),
            meetingTime: makeDate(daysFromNow: 4, hour: 8),
            startTime: makeDate(daysFromNow: 4, hour: 8, minute: 15),
            location: "Парк победы",
            distanceKm: 5,
            elevationM: nil,
            surfaceMix: "грунт 100%",
            paceDescription: "6:00-7:00 мин/км",
            requirements: "Любые кроссовки",
            description: "Лёгкая пробежка для тех кто только начинает. Темп медленный, никого не бросаем.",
            routeURL: nil,
            telegramPostURL: "https://t.me/sputnikrun/2321",
            sportType: .run,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            posterURL: "https://res.cloudinary.com/du6prhxao/image/upload/v1778881272/photo_2026-05-16_00.15.52_cjfblx.jpg"
        ),
        Workout(
            id: UUID(),
            title: "Long ride",
            date: makeDate(daysFromNow: 2, hour: 10),
            meetingTime: makeDate(daysFromNow: 2, hour: 10),
            startTime: makeDate(daysFromNow: 2, hour: 10, minute: 30),
            location: "Surf Coffee",
            distanceKm: 96,
            elevationM: 607,
            surfaceMix: "грунт/асфальт 40% / 60%",
            paceDescription: "25-27 км/ч на грунтах, 32-37 км/ч на асфальте",
            requirements: "Шлем, мультиспид велосипед с рулем баран (гревел, ЦК и эндуранс), фара и фонарь, соблюдаем ПДД",
            description: "Поедем наш прошлогодний маршрут от @maskakult.",
            routeURL: "https://mapmagic.app/map?routes=VYBZXg0&pos=60.13221%2C30.44617%2C12",
            telegramPostURL: "https://t.me/houseofgravel/431",
            sportType: .gravel,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            posterURL: "https://res.cloudinary.com/du6prhxao/image/upload/2026-05-15_22.25.45_anehxx"
        ),
        Workout(
            id: UUID(),
            title: "Long ride",
            date: makeDate(daysFromNow: 3, hour: 9),
            meetingTime: makeDate(daysFromNow: 3, hour: 9),
            startTime: makeDate(daysFromNow: 3, hour: 9, minute: 40),
            location: "в 9:40 электричка с Финлядского вокзала до ст. Кирилловское.",
            distanceKm: 95,
            elevationM: 793,
            surfaceMix: "грунт/асфальт 34% / 66%",
            paceDescription: "25-27 км/ч на грунтах, 32-37 км/ч на асфальте",
            requirements: "Шлем, мультиспид велосипед с рулем баран (гревел, ЦК и эндуранс), фара и фонарь, соблюдаем ПДД",
            description: "Едем из п. Кирилловское в п. Горьковское. Проедем Каменку, два озера и дальше по грунтам и асфальту до конечной точки.Кроме асфальта и грунтов на маршруте будет грейдер и немного плотного песка.",
            routeURL: "https://mapmagic.app/map?routes=9Kborg6&pos=60.48992%2C29.29666%2C11&b=Y",
            telegramPostURL: "https://t.me/houseofgravel/346",
            sportType: .gravel,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            posterURL: "https://res.cloudinary.com/du6prhxao/image/upload/v1778881111/photo_2026-05-16_00.11.25_ab1lrv.jpg"
        ),
        Workout(
            id: UUID(),
            title: "#2 TEARS OF CYCLING",
            date: makeDate(daysFromNow: 2, hour: 0),
            meetingTime: makeDate(daysFromNow: 2, hour: 0),
            startTime: makeDate(daysFromNow: 2, hour: 0, minute: 15),
            location: "Сбор в Tears of, Большая Никитская, 49",
            distanceKm: 50,
            elevationM: nil,
            surfaceMix: nil,
            paceDescription: nil,
            requirements: "18+ Шлем обязателен. Велосипед — мультиспид, в исправном состоянии. Без фиксов, МТБ и разделок.",
            description: "В эту субботу 23 мая мы @easycyclingclub вместе с tears of и not in paris второй год подряд соберемся в самом уютном дворике на Большой Никитской. В программе заезд на 50 км по красивым природным местам Москвы, кофе, ваши улыбки и объятия.",
            routeURL: nil,
            telegramPostURL: "https://t.me/easycyclingclub/1358",
            sportType: .road,
            clubId: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            posterURL: "https://res.cloudinary.com/du6prhxao/image/upload/v1779402928/photo_2026-05-22_01.34.46_owuzwo.jpg"
        )
    ]

    private static func makeDate(daysFromNow days: Int, hour: Int, minute: Int = 0) -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.day! += days
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components) ?? Date()
    }
}
