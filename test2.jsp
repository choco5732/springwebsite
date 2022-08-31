<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
    <h2>댓글기능 테스트</h2>
     comment : <input type="text" name="comment"><br>
    <button id="sendBtn" type="button">등록하기(SEND)</button>
    <button id="modBtn" type="button">수정하기</button>

    <div id="commentList"></div> <!-- ajax로 댓글을 가져와서 commentList에 넣어줄 예정 -->
    <script>
    // 게시판 번호 하드코딩.
    let bno = 1085;
    
    // 특정 게시물의 댓글목록을 보여주는 함수
    let showList = function(bno){
    	$.ajax({
    		type: 'GET',
    		url: '/fusionsoft/comments?bno='+bno,
    		success : function(result){
    			$("#commentList").html(toHtml(result));
    			alert("received="+result);
    		},
    		error : function(){alert("error")}
    	}); // $.ajax()
    }
    
    $(document).ready(function() {
        showList(bno);

        $("#modBtn").click(function () {
            let cno = $(this).attr("data-cno");
            let comment = $("input[name=comment]").val();

            if (comment.trim() == '') {
                alert("댓글을 입력해주세요.");
                $("input[name=comment]").focus()
                return;
            }

            $.ajax({
                type = 'PATCH',
                url: '/fusionsoft/comments/' + cno,
                headers: {"content-type": "application/json"},
                data: JSON.stringify({cno: cno, comment: comment}),
                success: function (result) {
                    alert(result);
                    showList(bno);
                },
                error: function () { alert("error") } // 에러가 발생했을 때, 호출할 함수
            }); // $.ajax()
        });


        $("#sendBtn").click(function () {
            let comment = $("input[name=comment]").val();

            if (comment.trim() == '') {
                alert("댓글을 입력해주세요.");
                $("input[name=comment]").focus()
                return;
            }

            $.ajax({
                type = 'POST',
                url: '/fusionsoft/comments?bno=' + bno,
                headers: {"content-type": "application/json"},
                data: JSON.stringify({bno: bno, comment: comment}),
                success: function (result) {
                    alert(result);
                    showList(bno);
                },
                error: function () { alert("error") } // 에러가 발생했을 때, 호출할 함수
            }); // $.ajax()
        });

        // 수정버튼 눌렀을 시
        $("#commentList").on("click", ".modBtn", function () { // commentList안에 있는 del버튼을 눌렀을때 작동
            let cno = $(this).parent().attr("data-cno");
            let comment = $("span.comment", $(this).parent()).text();

            // 1. comment의 내용을 input에 뿌려주기
            $("input[name=comment]").val(comment);
            // 2. cno전달하기
            $("#modBtn").attr("data-cno", cno);
        });

        // $(".delBtn").click(function(){
        $("#commentList").on("click", ".delBtn", function () { // commentList안에 있는 del버튼을 눌렀을때 작동
            let cno = $(this).parent().attr("data-cno");
            let bno = $(this).parent().attr("data-bno");

            $.ajax({
                type: 'DELETE',
                url: '/fusionsoft/comments/' + cno + '?bno=' + bno,
                success: function (result) {
                    alert(result)
                    showList(bno);
                },
                error: function () {
                    alert("error")
                } // 에러가 발생했을 때, 호출할 함수
            }); // $.ajax()
        });
    });

    let toHtml = function(comments){
        let tmp = "<ul>";

        comments.forEach(function(comment){
            tmp += '<li data-cno=' + comment.cno
            tmp += 'data-pcno' + comment.pcno
            tmp += 'data-bno' + comment.bno + '>'
            tmp += 'commenter=<span class="commenter">' + comment.commenter + '</span>'
            tmp += 'comment=<span class="comment">' + comment.comment + '</span>'
            tmp += 'up_date='+comment.up_date
            tmp += '<button class="delBtn">삭제</button>'
            tmp += '<button class="modBtn">수정</button>'
            tmp += '</li>'
        })
        return tmp + "</ul>";
    }
    </script>
</body>
</html>
