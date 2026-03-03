# detail_timer
**개요** : ios에서 기본 알람앱이 사용자 편의성 측면에서 아쉬운 부분이 있어서 몇가지 기능을 추가 할 것이다.

**앱 동작 구분**
- 일회용 알람을 동작하게 해주는 세션이 있고, 반복 알람을 동작하게 해주는 그룹 세션이 있다.
- 반복 알람 중 특정 요일에 알람을 스킵하고자 한다면 스킵 버튼을 눌러 특정 요일만 스킵을 할 수있다.
    - 스킵 버튼을 누를 시 그 날짜 하루 동안만 그 그룹의 모든 알람이 스킵된다.

## 시스템 아키텍처
**추천 도메인 모델** : AlarmGroup + AlarmItem  
**데이터 설계 초안**  
**AlarmGroup**  
- id
- name
- repeatDays
- enabled
- skipDates

**AlarmItem**  
- id
- groupId
- time
- enabled

**개발 과정 단계**  
1단계: 도메인 모델을 Swift코드로 확정  
2단계: 도메인 로직을 만든다.  
3단계: 저장 붙이기  
4단계: 인프라 스케줄러 붙이기  
5단계: UI(SwiftUI + MVVM)  


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
- 객체 지향 프로그래밍에서 객체의 상태나 특징(속성)을 나타내는 데이터 멤버
- Stored Property : 저장 프로퍼티
- Computed Property : 연산 프로퍼티
- Type Property : 타입 프로퍼티

**저장 프로퍼티(Stored Property)** : 클래스와 구조체에서만 사용할 수 있고, 값을 저장하기 위해 선언되는 상수/변수

**mutating 사용 이유**
- struct는 값 타입(value type)이라서 내부 프로퍼티를 변경하려면 필요함.

**$0** : 익명 함수 단축 문법

**guard문**
- 조건문
- 조건이 false일 때 else를 실행함.

**contains**
- 컬렉션에 특정 값이 포함되어 있는지 확인하는 메서드
- return == bool

**싱글톤 패턴**
- 클래스의 객체를 한 개만 생성해서 그 객체만을 사용하는 패턴이다.

**Comparable(type)** : 서로 크기 비교가 가능하다는 것을 나타내는 프로토콜

**Calendar.current** : 현재 사용자의 기기 설정을 따르는 달력 객체

**component** : Date에서 특정 달력 구성요소 꺼내기

**rawValue** : enum이 내부적으로 가지고 있는 기본 값

**let, var** : 상수, 변수

₩₩₩
    // Date? == return으로 반환할 수도 nil일 수도 있다.
    func nextTriggerDate(from now: Date) -> Date? {
        guard enabled else { return nil }
₩₩₩

**onAppear** : View가 화면에 나타날 대 실행되는 초기화/로드용 코드 블록

**padding** : View의 바깥 여백을 추가하는 modifier

**modifier** : 기존 View를 변형해서 새로운 View를 만드는 함수

**UNUserNotificationCenter** : 로컬 알림과 푸시 알림을 관리하는 객체

**async** : 비동기 작업이 일어난다는 표시

**await** : 비동기 작업이 끝날 때까지 기다리는 표시

**동기 AND 동기화**
- 동기 : 순차적으로 실행, 앞 작업이 끝나야 다음 실행
- 동기화 : 여러 스레드가 동시에 접근할 때 충돌을 막는 기술

**동기 실행 VS 비동기 실행**
- 동기 실행 : 순차 실행, 기다리는 동안 스레드도 멈춤
- 비동기 실행 : 스레드를 붙잡고 있지 않음, 시스템이 다른 작업을 처리 가능, 시스템이 스레드를 재활용할 수 있는 상태가 된다는 것.

**스레드** : 프로세스 안에서 실제로 코드가 실행되는 작업 흐름 단위

**flatMap**
- 각 요소를 변환한 뒤, 중첩된 구조를 한 단계 평평하게 만드는 함수
- ex> 배열 안의 배열을 하나로 만드는 경우

**byAdding** : 기존 날짜에 특정 시간 단위를 더해서 새로운 Date를 만드는 메서드

**DateFormatter** : Date를 사람이 읽을 수 있는 문자열로 바꾸거나, 문자열을 다시 Date로 변환하는 객체

---
**제작에 도움이 된 페이지**  
- [40시간만에 Swift로 IOS 앱 만들기](https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/)
