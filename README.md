1. 프로젝트 만들기 연습
    1. 프로젝트 이름: spring_05
    2. 기본패키지: com.icia.demo
    3. 클래스
        1. HomeController
            1. index.jsp를 출력함
        2. DemoController
            1. req1, req2 주소 요청을 각각 처리함
        3. DemoService
        4. DemoDTO
            1. name(String)
            2. age(int)
    4. 시작화면: index.jsp
        1. demo1.jsp 화면으로 이동하는 링크 있음.
        2. demo2.jsp 화면으로 이동하는 링크 있음.
    5. demo1.jsp
        1. query string 방식으로 name=’손흥민’, age=31 값을 req1 주소로 요청함
        2. 컨트롤러에서는 이 값을 받아서 서비스의 req1 메서드로 전달함
        3. 서비스에서는 전달받은 name, age를 DTO 객체에 담아서 리턴함
        4. 컨트롤러에서 리턴받은 DTO객체를 model에 담아서 req1.jsp로 가져가고 req1.jsp에서 값을 출력함.
    6. demo2.jsp
        1. form 태그에 name, age값을 입력받아서 req2 주소로 post 요청함
        2. 컨트롤러에서는 DTO로 바로 받고 서비스의 req2 메서드로 전달함
        3. 서비스에서는 전달받은 DTO 객체를 리스트 객체에 추가하고 리스트를 리턴함
        4. 컨트롤러에서 리턴받은 리스트 객체를 model에 담아서 req2.jsp로 가져가고 req2.jsp에서 값을 출력함. (출력되는 값은 하나임)