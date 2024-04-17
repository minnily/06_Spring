/* input에 입력한 값을 제출하기 버튼 눌렀을 때 todo 추가되기 */

// 할일 추가에 있는 값 얻어오기
const todoTitle = document.querySelector("#todoTitle");
const todoContent = document.querySelector("#todoContent");
const addBtn = document.querySelector("#addBtn");

addBtn.addEventListener("click", () => {

    const input= {
        "todoTitle" : todoTitle.value,
        "todoContent" : todoContent.value
    };


    fetch("/ajax/add2", {
        
        method : "POST",
        headers : {"Content-type" : "application/json"},
        body : JSON.stringify(input)
    })
    .then(resp => resp.text())
    .then( result => {

        if(result >0){
            alert("TodoList를 추가하였습니다.");
            todoTitle.value ="";
            todoContent.value ="";

        }else{
            alert("TodoList 생성에 실패했습니다.")

        }
    })    
        
});

// 할일 목록 tbody에 띄우기 ( 할일 목록을 조회하기)

// 할일 목록에 있는 값 얻어오기
const tbody = document.querySelector("#tbody");

const selectTodoList = () => {

    fetch("/ajax/selectTodoList")
    .then(resp => resp.json())
    .then(result => {

        for(let todo2 of todoList2){
            const tr =document.createAttribute("tr");
            const arr= ['todoNo', 'todoTitle','complete','regDate'];

            for(let key of arr){
                const td = document.createAttribute("td");
            
                td.innerText = todo[key];
                tr.append(td);
            }
            tbody.append(tr)
        }
    })
};

selectTodoList();









































// const todoTitle = document.querySelector("#todoTitle");
// const todoContent = document.querySelector("#todoContent");
// const addBtn = document.querySelector("addBtn");

// addBtn.addEventListener("click", ()=>{

//     const param = {
//         "todoTitle" : todoTitle.value, 
//         "todoContent" : todoContent.value
//     }


//     fetch("/ajax/add2",{
//         method : "POST",
//         headers : {"Content-Type" : "application/json"},
//         body : JSON.parse(param)
//     })
// })




