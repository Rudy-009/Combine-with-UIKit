# Combine-with-UIKit
UIKit에서 Combine과 MVVM 패턴을 적용하는 미니 프로젝트

## 1단계: Combine 기초와 MVVM 구조 이해하기
> 과제 목표: Combine의 기본 개념을 이해하고 간단한 MVVM 구조를 설계합니다.

도전 과제:
간단한 텍스트 필드가 있는 화면을 만들고, 사용자 입력을 실시간으로 검증하는 ViewModel을 구현하세요. 
텍스트 필드에 입력된 텍스트의 길이가 5자 이상일 때만 버튼이 활성화되도록 Combine의 Publisher와 Subscriber를 사용하세요.
ViewModel에서는 @Published 프로퍼티와 PassthroughSubject를 활용하여 상태를 관리하세요.
ViewController에서는 ViewModel의 상태를 구독하여 UI를 업데이트하는 구조를 만드세요.

이 단계에서는 Combine의 기본 개념인 Publisher, Subscriber, Subscription의 개념과 MVVM 패턴의 기본 구조를 이해하는 것이 중요합니다.

## 2단계: 네트워크 요청과 비동기 처리
> 과제 목표: Combine을 활용하여 네트워크 요청을 처리하고 결과를 MVVM 패턴에 맞게 표시합니다.

도전 과제:
간단한 API(예: 공개 날씨 API)를 호출하여 데이터를 가져오는 NetworkService를 구현하세요.
URLSession의 dataTaskPublisher를 사용하여 네트워크 요청을 Publisher로 변환하세요.
ViewModel에서 네트워크 요청 결과를 처리하고, 로딩 상태, 성공, 실패 상태를 관리하세요.
ViewController에서는 테이블 뷰나 컬렉션 뷰를 사용하여 결과를 표시하고, 로딩 중에는 인디케이터를 보여주세요.
에러 처리를 위한 적절한 Combine 연산자(catch, retry 등)를 활용하세요.

이 단계에서는 비동기 작업을 Combine으로 처리하는 방법과 MVVM 패턴에서의 에러 처리 방식을 익힙니다.

## 3단계: 사용자 입력 처리와 폼 검증
> 과제 목표: 복잡한 폼을 MVVM과 Combine을 사용하여 효율적으로 관리합니다.

도전 과제:
회원가입 또는 로그인 폼을 구현하세요(이메일, 비밀번호, 확인 등).
각 입력 필드마다 실시간 유효성 검사를 Combine으로 구현하세요(이메일 형식, 비밀번호 강도 등).
모든 필드가 유효할 때만 제출 버튼이 활성화되도록 여러 Publisher를 결합하세요(CombineLatest 활용).
폼 제출 시 비동기 작업(예: API 호출)을 시뮬레이션하고, 결과에 따라 다음 화면으로 이동하거나 에러를 표시하세요.
debounce나 throttle 같은 연산자를 사용하여 사용자 입력에 대한 반응을 최적화하세요.

이 단계에서는 여러 Publisher를 조합하고 사용자 입력을 효율적으로 처리하는 방법을 학습합니다.

## 4단계: 상태 관리와 바인딩 최적화
> 과제 목표: 복잡한 UI 상태를 MVVM과 Combine으로 효율적으로 관리합니다.

도전 과제:
탭 기반 인터페이스나 여러 섹션이 있는 복잡한 화면을 구현하세요.
ViewModel에서 화면의 여러 부분에 대한 상태를 관리하고, 상태 변경에 따라 UI가 업데이트되도록 구현하세요.
메모리 관리를 위해 적절한 Cancellable 관리 방법을 구현하세요(AnyCancellable 컬렉션 사용).
화면 전환 시 구독을 적절히 취소하고 재구독하는 로직을 구현하세요.
성능 최적화를 위해 removeDuplicates, receive(on:) 등의 연산자를 적절히 활용하세요.

이 단계에서는 복잡한 UI 상태 관리와 메모리 누수 방지를 위한 구독 관리 방법을 익힙니다.

## 5단계: 고급 패턴 적용과 테스트 가능한 설계
> 과제 목표: MVVM과 Combine을 활용한 고급 패턴을 적용하고 테스트 가능한 코드를 작성합니다.

도전 과제:

Coordinator 패턴을 도입하여 화면 전환 로직을 ViewModel에서 분리하세요.
의존성 주입을 활용하여 서비스 레이어를 추상화하고 ViewModel에 주입하세요.
모의 객체(Mock)를 사용하여 ViewModel의 단위 테스트를 작성하세요.
Combine의 Scheduler를 활용하여 테스트 환경에서 비동기 코드를 동기적으로 테스트하는 방법을 구현하세요.
실제 앱에서 자주 사용되는 패턴(예: 페이지네이션, 무한 스크롤, 실시간 업데이트 등)을 Combine과 MVVM으로 구현해보세요.
