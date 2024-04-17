/* input에 입력한 값을 제출하기 버튼 눌렀을 때 todo 추가되기 */

// 할일 추가에 있는 값 얻어오기

const todoTitle = document.querySelector("#todoTitle");
const todoContent = document.querySelector("#todoContent");
const addBtn = document.querySelector("addBtn");

addBtn.addEventListener("click", ()=>{

    const param = {
        "todoTitle" : todoTitle.value, 
        "todoContent" : todoContent.value
    }


    fetch("/ajax/add",{
        method : "POST",
        headers : {"Content-Type" : "application/json"},
        body : JSON.parse(param)
    })
})


