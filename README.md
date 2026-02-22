# detail_timer
**개요** : ios에서 기본 알람앱이 사용자 편의성 측면에서 아쉬운 부분이 있어서 몇가지 기능을 추가 할 것이다.

## 시스템 아키텍처
**추천 도메인 모델** : AlarmGroup + AlarmItem
**데이터 설계 초안**
- id
- name
- repeatDays
- enabled
- skipDates
---
AlarmItem
- id
- groupId
- time
- enabled
---
**개발 과정 단계**
1단계: 도메인 모델을 Swift코드로 확정
2단계: 도메인 로직을 만든다.
3단계: 저장 붙이기
4단계: 인프라 스케줄러 붙이기
5단계: UI(SwiftUI + MVVM)
---

## 기초 개념
**타입 시스템**
- class
- struct
- enum
- protocol

**프로토콜(Protocol)** : 어떤 기능에 적합한 특정 메서드, 프로퍼티 및 기타 요구 사항의 청사진을 의미
- 인스턴스를 만들 수 없음
- 규칙만 정의

**프로퍼티** : 타입이 가져야 할 상태(state)를 저장하기 위해 존재함.
- Stored Property : 저장 프로퍼티
- Computed Property : 연산 프로퍼티
- Type Property : 타입 프로퍼티

**저장 프로퍼티(Stored Property)** : 클래스와 구조체에서만 사용할 수 있고, 값을 저장하기 위해 선언되는 상수/변수

---
**제작에 도움이 된 페이지**  
- [40시간만에 Swift로 IOS 앱 만들기](https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/)