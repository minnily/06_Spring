/*회원 정보 수정 페이지 */
const updateInfo = document.querySelector("#updateInfo"); //form 태그

//#updateInfo 요소가 존재 할 떄만 수행
if(updateInfo != null){

    //form 제출 시
    updateInfo.addEventListener("submit" , e => {

        const memberNickname = document.querySelector("#memberNickname");
        const memberTel = document.querySelector("#memberTel");
        const memberAddress = document.querySelectorAll("[name= 'memberAddress']");

        //닉네임 유효성 검사
        if(memberNickname.value.trim().length === 0 ){
            alert("닉네임을 입력해 주세요");
            e.preventDefault(); //제출막기
            return;
        }

        //닉네임 정규식
        let regExp = /^[가-힣\w\d]{2,10}$/;
        if( !regExp.test(memberNickname.value)){
            alert("닉네임이 유효하지 않습니다");
            e.preventDefault(); //제출막기
            return;
        }

         //********************* */
        //닉네임 중복검사는 개별적으로
        //테스트 시 닉네임 중복 안되게 조심하기!
        //********************* */


        //전화번호 유효성 검사
        if(memberTel.value.trim().length === 0 ){
            alert("전화번호를 입력해 주세요");
            e.preventDefault();
            return;
        }

        //전화번호 정규식에 맞지 않으면
        regExp =  /^01[0-9]{1}[0-9]{3,4}[0-9]{4}$/;
        if(!regExp.test(memberTel.value)){
            alert("전화번호가 유효하지 않습니다");
            e.preventDefault();
            return;
        }

        //주소 유효성 검사
        // 입력을 안하면 전부 안해야되고
        //입력을 하면 3군데 input 전부 해야한다.

        const addr0 = memberAddress[0].value.trim().length == 0;
        const addr1 = memberAddress[1].value.trim().length == 0;
        const addr2 = memberAddress[2].value.trim().length == 0;

        //모두 true 인 경우만 true 저장
        const result1 = addr0 && addr1 && addr2; //아무것도 입력안한 경우

        //모두 false 인 경우만 true 저장
        const result2 = !(addr0 || addr1 || addr2); //모두 다 입력한 경우

        //모두 입력 또는 모두 미입력이 아니면
        if( !(result1 || result2) ){
            alert("주소를 모두 작성 또는 미작성 해주세요");
            e.preventDefault();
        }


    });
}

// -----------------------------------------------------------------------------

/* 비밀번호 수정 */

//비밀번호 변경 form 태그
const changePw = document.querySelector("#changePw");

if(changePw != null){
    // 제출 되었을 떄 
    changePw.addEventListener("submit", e => {

        const currentPw = document.querySelector("#currentPw");
        const newPw = document.querySelector("#newPw");
        const newPwConfirm = document.querySelector("#newPwConfirm");

        // - 값을 모두 입력했는가
        let str; // undefined 상태
        if(currentPw.value.trim().length == 0) str = "현재 비밀번호를 입력해주세요";
        else if(newPw.value.trim().length == 0) str = "새 비밀번호 입력해주세요";
        else if(newPwConfirm.value.trim().length == 0 ) str = "새 비밀번호 확인을 입력해주세요";

        if(str != undefined){ // str에 값이 대입됨 == if 중 하나 실행됨
            alert(str);
            e.preventDefault();
            return;
        }

        //새 비밀번호 정규식
        const regExp = /^[a-zA-Z0-9!@#_-]{6,20}$/;

        if(!regExp.test(newPw.value)){
            alert("새 비밀번호가 유효하지 않습니다");
            e.preventDefault();
            return;
        }

        //새 비밀번호 == 새 비밀번호 확인
        if(newPw.value != newPwConfirm.value){
            alert("새 비밀번호가 일치하지 않습니다");
            e.preventDefault();
            return;
        }

    });
};




























//---------------------------------------------------------------------------

/* 탈퇴 유효성 검사 */

// 탈퇴 form 태그 
const secession = document.querySelector("#secession");

if(secession != null){
    secession.addEventListener("submit", e => {
        const memberPw = document.querySelector("#memberPw");
        const agree = document.querySelector("#agree");

        // - 비밀번호 입력 되었는지 확인
        if(memberPw.value.trim().length == 0){
            alert("비밀번호를 입력해주세요");
            e.preventDefault(); // 제출막기
            return;
        }

        // 약관 동의 체크 확인 
        // checkbox 또는 radio checked 속성
        // - checked -> 체크 시 true, 미 체크시 false를 반환

        if(!agree.checked){ //체크가 안되었을 때
            alert("약관에 동의해주세요");
            e.preventDefault(); // 제출 막기
            return;
        }

        // 정말 탈퇴 할 것인지에 대해서 물어보기
        if(!confirm("정말 탈퇴 하시겠습니까?")){
            alert("취소 되었습니다.");
            e.preventDefault(); //제출 막기
            return;
        }
    });
}

// -------------------------------------------------------
/* 프로필 이미지 추가/변경/삭제 */
// 프로필 이미지 페이지 form 태그
const profile = document.querySelector("#profile");
// 프로필 이미지가 새로 업로드 되거나 삭제 되었음을 기록하는
// 상태 변수
// -1 : 초기 상태(변화 없음)
//  0 : 프로필 이미지 삭제
//  1 : 새 이미지 선택
let statusCheck = -1;
// input type="file" 태그의 값이 변경 되었을 때
// 변경된 상태를 백업해서 저장할 변수
// -> 파일이 선택/취소된 input을 복제해서 저장
// 요소. cloneNode(true|false) : 요소 복제(true 작성 시 하위 요소도 복제)
let backupInput;
// profile form태그가 화면에 있다면
if(profile != null){
// 1) 프로필 이미지 수정에 사용할 요소 모두 얻어오기
 // img 태그 (프로필 이미지가 보여지는 요소)
 const profileImg = document.querySelector("#profileImg");
 // input type="file" 태그 (실제 업로드할 프로필 이미지를 선택하는 요소)
 let imageInput = document.querySelector("#imageInput");
 // x버튼 (프로필 이미지를 제거하고 기본 이미지로 변경하는 요소)
 const deleteImage = document.querySelector("#deleteImage");
	// 3) changeImageFn 함수 정의하기
 /* input type="file"의 값이 변했을 때 동작할 함수(이벤트 핸들러) */
 const changeImageFn = e => {
   // 업로드 가능한 파일 최대 크기 지정하여 필터링
   const maxSize =  1024 * 1024 * 5;
   // 5MB == 1024KB * 5 == 1024B * 1024 * 5
   console.log("e.target", e.target); // input 태그
   console.log("e.target.value", e.target.value); // 변경된 값(파일명)
   // 선택된 파일에 대한 정보가 담긴 배열 반환
   // -> 왜 배열?? multiple 옵션에 대한 대비(파일 여러개 받을 때)
   console.log("e.target.files", e.target.files);
   // 업로드된 파일이 1개 있으면 files[0]에 저장됨
   // 업로드된 파일이 없으면 files[0] == undefined
   console.log("e.target.files[0]", e.target.files[0]);
   const file = e.target.files[0];
   // ------------ 업로드된 파일이 없다면(취소한 경우)------------
  if(file == undefined){
     console.log("파일 선택 후 취소됨");
    
     // 파일 선택 후 취소 -> value == ''
     // -> 선택한 파일 없음으로 기록됨
     // -> backupInput으로 교체 시켜서
     //    이전 이미지가 남아 있는 것 처럼 보이게 함
     // 백업의 백업본
     const temp = backupInput.cloneNode(true);
    
     console.log("temp", temp); // 백업용 input태그
     // input 요소 다음에 백업 요소 추가
     imageInput.after(backupInput);
    
     // 화면에 존재하는 기존 input 제거
     imageInput.remove();
     // imageInput 변수에 백업을 대입해서 대신하도록 함
     imageInput = backupInput;
     // 화면에 추가된  백업본에는
     // 이벤트 리스너가 존재하지 않기 때문에 추가
     imageInput.addEventListener("change", changeImageFn);
     // 한번 화면에 추가된 요소(backupInput)는 재사용 불가능
     //  backupInput의 백업본이 temp를 backupInput 으로 변경
     backupInput = temp;
     return;  // 다른 코드 수행할필요없이 바로 return
   }
  
  
   // ----------- 선택된 파일이 최대 크기를 초과한 경우 ------------
   if(file.size > maxSize){
     alert("5MB 이하의 이미지 파일을 선택해 주세요.");
		//파일을 선택할 때 5MB보다 큰 파일을 선택하면
		//일단 무조건 선택은 됨.
		//근데 우리는 5MB보다 큰 파일은 취급 안하고 싶음
		//그래서 대입된 5MB 초과한 파일을 없애버리겠다
		
     // 아직 변경된적없는 초기상태에서 5MB 초과하는 이미지를 선택한 경우
     if(statusCheck == -1){
       imageInput.value = '';
   
     } else{ // 기존에 변경하려고 선택한 이미지가 있는데
             // 다음에 선택한 이미지가 최대 크기를 초과한 경우
             // -> 비워버리면 안되고, 그 전에 선택한 이미지로 계속 보이게끔 처리해야함.
       // 백업의 백업본
       const temp = backupInput.cloneNode(true);
       // input 요소 다음에 백업 요소 추가
       imageInput.after(backupInput);
       // 화면에 존재하는 기존 input 제거
       imageInput.remove();
       // imageInput 변수에 백업을 대입해서 대신하도록 함
       imageInput = backupInput;
       // 화면에 추가된  백업본에는
       // 이벤트 리스너가 존재하지 않기 때문에 추가
       imageInput.addEventListener("change", changeImageFn);
       // 한번 화면에 추가된 요소(backupInput)는 재사용 불가능
       //  backupInput의 백업본이 temp를 backupInput 으로 변경
       backupInput = temp;
     }
     return; // 다른 코드 수행할필요없이 바로 return
   }
 
   // ------------- 선택된 이미지 미리보기 ----------------
   // JS에서 파일을 읽을 때 사용하는 객체
   // - 파일을 읽고 클라이언트 컴퓨터에 저장할 수 있음
   /*FileReader 객체는 웹 애플리케이션에서 비동기적으로 파일의 내용을 읽을 수 있게 해줍니다. */
   const reader = new FileReader();
   // 선택한 파일(file) 을 읽어와
   // BASE64 인코딩 형태로 읽어와 result 변수에 저장
   reader.readAsDataURL(file); // -> 읽어오기 이벤트(load)
   // readAsDataURL() : 파일을 BASE64 형식의 데이터 URL로 읽어들입니다.
  
   // console.log("reader:",reader);
   // result에 "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAW" 이런식으로 들어감
   // 읽어오기 끝났을 때 (파일 읽기 작업이 완료되면 이벤트 핸들러 함수를 실행)
   reader.addEventListener("load", e => {
     // e.target == reader
     // 읽어온 이미지 파일이 BASE64 형태로 반환됨
     const url = e.target.result; // reader.result
     // 프로필 이미지(img)에 src속성으로 url값 세팅
     profileImg.setAttribute("src", url);
    
     // 새 이미지 선택 상태를 기록
     statusCheck = 1;
     // 파일이 선택된 input을 복제해서 백업
     backupInput = imageInput.cloneNode(true);
   });
 };
	
	// 2) imageInput에 change 이벤트로 changeImageFn 등록
 // change 이벤트 : 새로운 값이 기존 값과 다를 경우 발생
 imageInput.addEventListener("change", changeImageFn);
 // ------------ 4) x버튼 클릭 시 기본 이미지로 변경 ----------------
 deleteImage.addEventListener("click", () => {
   // 프로필 이미지(img)를 기본 이미지로 변경
   profileImg.src = "/images/user.png";
   // input에 저장된 값(value)를 ''(빈칸)으로 변경
   //   -> input에 저장된 파일 정보가 모두 사라짐 == 데이터 삭제
   imageInput.value = '';
   backupInput = undefined; // 백업본도 삭제
   // 삭제 상태임을 기록
   statusCheck = 0;
 });
 // ------------ 5) #profile (form) 제출 시 -----------------
 profile.addEventListener("submit", e => {
  
   let flag = true;
	// loginMemberProfileImg : myPage-profile.html 하단에 script를 이용하여 타임리프로 선언해둔 변수
	
	// submit 해도 되는 경우 :
   // 1. 기존 프로필 이미지가 없다가 새 이미지가 선택된 경우
   if(loginMemberProfileImg == null && statusCheck == 1) flag = false;
   // 2. 기존 프로필 이미지가 있다가 삭제한 경우
   if(loginMemberProfileImg != null && statusCheck == 0) flag = false;
  
   // 3. 기존 프로필 이미지가 있다가 새 이미지가 선택된 경우
   if(loginMemberProfileImg != null && statusCheck == 1) flag = false;
	// 나머지의 경우는 기존 상태에서 변경사항이 없는 경우임.-> 제출막기
   if(flag){ // flag 값이 true인 경우
     e.preventDefault();
     alert("이미지 변경 후 클릭하세요")
   }
 });
}
/*  [input type="file" 사용 시 유의 사항]
 1. 파일 선택 후 취소를 누르면
   선택한 파일이 사라진다  (value == '')
 2. value로 대입할 수 있는 값은  '' (빈칸)만 가능하다
 3. 선택된 파일 정보를 저장하는 속성은
   value가 아니라 files이다
*/


const checkSignout ={
  "agreeSignout" : false,
  "currentPwConfirm" :false
};

const currentPwConfirm = document.querySelector("#currentPwConfirm");
const agreeSignout = document.querySelector("#agreeSignout");
const currentPwConfirmMessage = document.querySelector("#currentPwConfirmMessage");  
const signoutBtn = document.querySelector("#signoutBtn");

const signoutForm= document.querySelector("#signoutForm");


// 비밀번호 입력 시 이벤트
currentPwConfirm.addEventListener("input",()=>{
  if(currentPwConfirm.value.trim().length == 0){
     currentPwConfirmMessage.innerText="비밀번호를 입력해주세요"
      checkSignout.currentPwConfirm = false;
      return;
    }
    
  const inputPw = currentPwConfirm.value;
  fetch("/user/checkPw", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: inputPw
  })
  .then(resp => resp.text())
  .then(result => {
    if(result == 0){
      
      currentPwConfirmMessage.innerText= '비밀번호 불일치';
      checkSignout.currentPwConfirm = false;
      return; 
    } 
    currentPwConfirmMessage.innerText="비밀번호 일치"
    checkSignout.currentPwConfirm = true;
    
  }) 
});

// 동의체크박스
agreeSignout.addEventListener("change", (e) => {
  console.log(e.target.checked);
  if(e.target.checked) checkSignout.agreeSignout = true;
  else      checkSignout.agreeSignout = false;
})

// 최종 서브밋 될 떄 이벤트
signoutForm.addEventListener("submit", (e) => {

  if(!checkSignout.agreeSignout){
    e.preventDefault();
    alert('탈퇴 약관에 동의해주세요');
    return;

  }

  if(!checkSignout.currentPwConfirm) {
    e.preventDefault();
    alert('비밀번호가 일치하지 않습니다');
    return;
  }

  alert("탈퇴 되었습니다!");
  return true;
  
})