/* 요소 얻어와서 변수에 저장 */
const totalCount = document.querySelector("#totalCount");
const completeCount = document.querySelector("#completeCount");
const reloadBtn =document.querySelector("#reloadBtn");

// 할 일 추가 관련 요소 
const todoTitle = document.querySelector("#todoTitle");
const todoContent = document.querySelector("#todoContent");
const addBtn = document.querySelector("#addBtn");

// 할 일 목록 조회 관련 요소
const tbody = document.querySelector("#tbody");

// 할 일 상세 조회 관련 요소
const popupLayer = document.querySelector("#popupLayer");
const popupTodoNo = document.querySelector("#popupTodoNo");
const popupTodoTitle = document.querySelector("#popupTodoTitle");
const popupClose = document.querySelector("#popupClose");
const popupComplete = document.querySelector("#popupComplete");
const popupRegDate = document.querySelector("#popupRegDate");
const popupTodoContent = document.querySelector("#popupTodoContent");

// 상세 조회 버튼
const deleteBtn = document.querySelector("#deleteBtn");
const updateView = document.querySelector("#updateView");
const changeComplete = document.querySelector("#changeComplete");

// 수정 레이어 버튼
const updateLayer = document.querySelector("#updateLayer");
const updateTitle = document.querySelector("#updateTitle");
const updateContent =document.querySelector("#updateContent");
const updateBtn = document.querySelector("#updateBtn");
const updateCancel =document.querySelector("#updateCancel")

//---------------------------------------------------------------------------

// 전체 Todo 개수 조회 및 출력하는 함수 정의 
function getTotalCount(){

    // 비동기로 서버에서 전체 Todo 개수를 조회하는 
    // fetch() API 코드 작성
    // (fetch : 가지고 오다)

    fetch("/ajax/totalCount") //비동기 요청 수행 ->Promise 객체 반환 
    .then( response => {
        // response : 비동기 요청에 대한 응답이 담긴 객체
        
        console.log("response : ",response);
        // response.test() : 응답 데이터를 문자열/ 숫자 형태로 변환한 결과를 가지고 Promise 객체 변환
        return response.text();
    })
    // 두 번째 then의 매개변수 (result)
    // == 첫 번 째 then에서 반환된 Promise 객체의 PromiseResult 값
    .then(result => {
        // result 매개변수  == Controller 메서드에서 반환된 값 
        console.log("result : ",result);

        //#totalCount 요소의 내용을 result로 변경
        totalCount.innerText = result;

    });
}

// completeCount값 비동기 통신으로 얻어와서 화면 출력
function getCompleteCount(){

    // fetch() : 비동기로 요청해서 결과 데이터 가져오기

    // 첫 번째 then의 response : 
    // - 응답 결과, 요청 주소, 응답 데이터 등이 담겨있음

    // response.text() : 응답 데이터를 text 형태로 변환 (단일값들만 가능 !)

    // 두 번째 then의 result 
    // - 첫 번째 then에서 text로 변환된 응답 데이터


    fetch("/ajax/completeCount")
    .then( response => {
        return response.text()
    })
    .then(result => {
        //#completeCount 요소에 내용으로 result 값 출력
        completeCount.innerText = result;
    })
}

// 새로고침 버튼이 클릭 되었을 떄
reloadBtn.addEventListener("click", () => {
    getCompleteCount();//비동기로 전체 할 일 개수 조회
getTotalCount(); // 비동기로 완료된 할 일 개수 조회
})

// -----------------------------------------------------------------------------------------

// 할 일 추가 버튼 클릭 시 동작
addBtn.addEventListener("click", () => {

    // 비동기로 할 일 추가하는 fetch() 코드 작성
    // - 요청 주소 : "/ajax/add"
    // - 데이터 전달 방식 (method) : "POST" 방식
    
    // 파라미터를 저장한 JS 객체
    const param = {
        //Key  : Value
        "todoTitle" : todoTitle.value, 
        "todoContent" : todoContent.value
    };

    fetch("/ajax/add", {
        // key : value 
        method : "POST", // POST 방식 요청
        headers : {"Content-Type" : "application/json"}, //요청 데이터의 형식을 JSON으로 지정해서 보내겠다
        body : JSON.stringify(param) // 위에서 만든 param이라는 js객체를 JSON (전부 String 값)으로 변환해주는 코드

    })
    .then(resp => resp.text()) // 반환된 값을 text로 변환
    .then( temp => { // 첫번째 then에서 반환된 값 중 변환된 text를 temp에 저장

        if(temp > 0 ){ // 성공
            alert("추가 성공 !!! ");
            
            // 추가 성공한 제목, 내용 지우기
            todoTitle.value = "";
            todoContent.value= "";

            // 할 일이 추가 되었기 때문에 전체 Todo 개수 다시 조회
            getTotalCount();

            // 할 일 목록 다시 조회
            selectTodoList();


        } else { //실패
            alert("추가 실패...");
        }
    })
});

// ---------------------------------------------------------------------------------------

// 비동기(ajax)로 할 일 상세 조회하는 함수
const selectTodo = (url) => {
    // 매개변수 url == "/ajax/detail?todoNo=10" 형태의 문자열

    fetch(url)
    //response.json() : 
    // - 응답 데이터가 JSON인 경우
    //   이를 자동으로 Object 형태로 변환하는 메서드
    //  == JSON.parse(JSON 데이터)
    .then(resp => resp.json())
    .then(todo => {
        // 매개변수 todo :
        // - 서버 응답(JSON)이 Object로 변환된 값

        //const todo = JSON.parse(result);

        console.log(todo);

        // popup Layer에 조회된 값을 출력
        popupTodoNo.innerText = todo.todoNo;
        popupTodoTitle.innerText = todo.todoTitle;
        popupComplete.innerText = todo.complete;
        popupRegDate.innerText = todo.regDate;
        popupTodoContent.innerText = todo.todoContent;

        // popup layer 보이게 하기
        popupLayer.classList.remove("popup-hidden");
   
        // update Layer가 혹시라도 열려있으면 숨기기
        updateLayer.classList.add("popup-hidden");
    });

    // popup layer의 x 버튼() 눌렀을 때 닫기
    popupClose.addEventListener("click", () => {
            //숨기는 class를 추가
            popupLayer.classList.add("popup-hidden");
        });
};




// 비동기로 할 일 목록을 조회하는 함수 
const selectTodoList = () => {

    fetch("/ajax/selectList")
    .then(resp => resp.text()) // 응답 결과를 text로 변환
    .then(result => {
        console.log(result);
        console.log(typeof result); // 객체가 아닌 문자열 형태 

        // JSON은 문자열 형태로 넘어오는데 가공은 할 수있으나 사용하기 너무 힘들다. 그래서 JSON을 객체 형태로 변환해줘야한다.
        //JSON 형태를 객체 형태로 변환해주는 것 -> JSON.parse(JSON데이터) 이용하면 된다!
        // String 타입인 JSON 데이터를 JS Object 타입으로 변환해줌.

        //JSON.strungify(JS object) : object -> String
        //: JS Object 타입을 String 형태의 JSON 데이터로 변환해줌.
        const todoList = JSON.parse(result);
        console.log(todoList);

        //--------------------------------------------------------------------------------------------------------------

        // 기존에 출력되어있던 할 일 목록을 모두 삭제
        tbody.innerHTML = "";
        // #tbody에 tr/td 요소를 생성해서 내용 추가 
        for(let todo of todoList){//향상된 for문
        
            // tr 태그 생성
            const tr = document.createElement("tr");

            const arr = ['todoNo', 'todoTitle','complete','regDate'];

            for(let key of arr){
                const td = document .createElement("td");

                // 제목인 경우
                if(key == 'todoTitle'){
                    const a = document.createElement("a");// a태그 생성
                    a.innerText = todo[key]; //제목을 a태그 내용으로 대입
                    a.href = "/ajax/detail?todoNo=" + todo.todoNo;
                    td.append(a);
                    tr.append(td);
                
                // a태그 클릭 시 기본 이ㅣ벤트 (페이지 이동) 막기
                a.addEventListener("click", (e) => {
                    e.preventDefault();

                    // 할 일 살세 조회 비동기 요청 
                    // 클릭된 a태그의 href 속성 값 
                    selectTodo(e.target.href);
                });

                continue;
            
                }
                td.innerText = todo[key];
                tr.append(td);
            }

            // tbody의 자식으로 tr(한 행) 추가하기
            tbody.append(tr)
        }
    })
};

//------------------------------------------------------------------------

// 삭제 버튼 클릭시 해당 todo삭제하기

deleteBtn.addEventListener("click", () => {

    // 취소 클릭 시 아무것도 안함
    if(!confirm("정말 삭제하시겠습니까?")){return;} //취소 시 해당 클래스 수행안하고 반복해서 나타나게 하기
    // 삭제 할 할 일의 번호 얻어오기
    const todoNo = popupTodoNo.innerText; // #popupTodoNo 내용 얻어오기
    
    // 비동기 DELETE 방식 요청 
    fetch("/ajax/delete", {
        method : "DELETE", // DELETE방식 요청 -> @DeleteMapping 처리
        // 데이터 하나를 전달해도 application/json 작성
        headers : {"Content-type" : "application/json"},
        body :  todoNo // 값이 하나라서 따로 JS객체 형태로 작성하지 않았음!
                        // todoNo 값을 body에 담아서 전달 -> @RequestBody로 꺼냄

    })
    .then(resp => resp.text())
    .then(result => {
        if(result>0){//삭제 성공}
            alert("삭제되었습니다")

            // 상세 조회 창 닫기
            popupLayer.classList.add("popup-hidden");

            // 전체 완료된 할일 개수 다시 조회
            // 할 일 목록 다시 조회
        getTotalCount();
        getCompleteCount();
        selectTodoList();
        }else { 
            //실패
            alert("삭제 실패");
        }
    })
});

//------------------------------------------------------------------------------------------------

//완료 여부 변경 버튼 클릭시
changeComplete.addEventListener("click",() => {

    // 변경할 할 일 번호, 완료 여부( Y <-> N )
    const todoNo = popupTodoNo.innerText;
    const complete = popupComplete.innerText === 'Y' ? 'N' : 'Y';

    // SQL 수행에 필요한 값을 JS 객체로 묶음
    const obj = {"todoNo" : todoNo, "complete" : complete};

    // 비동기로 완료 여부를 변경
    fetch("/ajax/changeComplete", {
        method : "PUT", 
        headers : {"Content-Type" : "application/json"},
        body : JSON.stringify(obj) // obj를 JSON으로 변경
    })
    .then(resp => resp.text())
    .then( result => {

        console.log(result);

        if(result > 0){

            // update된 DB 데이터를 다시 조회해서 화면에 출력
            // -> 서버 부하가 큼

            // selectTodo();
            // 서버 부하를 줄이기 위해 상세 조회에서 Y/N만 바꾸기
            popupComplete.innerText = complete;

            //getCompleteCount();
            // 서버 부하를 줄이기 위해 완료된 Todo 개수 +-1
            
            const count = Number(completeCount.innerText);

            if(complete === 'Y') completeCount.innerText = count +1;
            else                 completeCount.innerText = count -1;

            // 서버 부하 줄이기 가능 ! -> 코드가 조금 복잡하기에 밑 메서드 조회로 변경
            selectTodoList();
        }else {
            alert("완료 여부 변경 실패!!");
        }
    })
});

//-----------------------------------------------------------------------------------

// 상세 조회에서 수정 버튼 (#updateView) 클릭 시
updateView.addEventListener("click", () => {

    // 기존 팝업 레이어는 숨기고
    popupLayer.classList.add("popup-hidden");

    // 수정 레이어 보이게
    updateLayer.classList.remove("popup-hidden");
    
    // 수정 레이어 보일 떄 
    // 기존에 있던 팝업 레이어에 작성된 제목, 내용을 얻어와 세팅
    updateTitle.value = popupTodoTitle.innerText;

    updateContent.value =popupTodoContent.innerHTML.replaceAll("<br>","\n");
    // HTML 화면에서 줄 바꿈이 <br>로 인식되고 있는데, 
    // textatea에서는 \n으로 바꿔줘야 줄바꿈으로 인식된다.

    // 수정 레이어 -> 수정 버튼에 data-todo-no 속성 추가                                          
    updateBtn.setAttribute("data-todo-no", popupTodoNo.innerText);
});


// ---------------------------------------------------------------------------------

// 수정 레이어에서 취소 버튼 (#updateCancle)이 클릭되었을 때 
updateCancel.addEventListener("click", () => {

    // 수정 레이어 숨기기
    updateLayer.classList.add("popup-hidden");

    // 팝업 레이어 보이기
    popupLayer.classList.remove("popup-hidden");
});

// -----------------------------------------------------------------------------

updateBtn.addEventListener("click", e => {

    // 서버로 전달해야되는 값을 객체로 묶어둠
    const obj = {
        "todoNo" : e.target.dataset.todoNo,
        "todoTitle" : updateTitle.value,
        "todoContent" : updateContent.value
    };

    // 비동기 요청
    fetch("/ajax/update", {
        method : "PUT",
        headers : {"Content-Type" : "application/json"},
        body : JSON.stringify(obj)
    })
    .then(resp => resp.text())
    .then(result => {
        if(result > 0){
            alert("수정 성공!");
            
            // 수정 레이어 숨기기
            updateLayer.classList.add("popup-hidden");

            // 목록 다시 조회
            selectTodoList();

            popupTodoTitle.innerText = updateTitle.value;

            popupTodoContent.innerHTML = updateContent.value.replaceAll("\n","<br>");

            popupLayer.classList.remove("popup-hidden");

            //수정 레이어 있는 남은 흔적 제거
            updateTitle.value = "";
            updateContent.value = "";
            updateBtn.removeAttribute("data-todo-no"); // 속성제거 (속성제거는 remove~)

        }else{
            alert("수정 실패..");
        }
    })
});









selectTodoList();
getCompleteCount();//함수 호출
getTotalCount(); // 함수 호출