<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
    <h2>댓글기능 테스트</h2>
    <button id="snedBtn" type="button">SEND</button>
    <div id ="commentList"></div>
    comment : <input type="text" name="comment"><br>
    <script>
        let bno = 1085;
        // 1085 게시물에 달려있는 댓글을 다 가져옴
        let showList = function(bno){
            $.ajax({
                type:'GET',
                url: '/ch4/comments?bno='+bno,
                success : function(result){
                    $("#commentList").html(toHtml(result));
                    alert("received="+result);
                },
                error : function(){alert("error")}
            });
        }


        $(document).ready(function(){
            $("#sendBtn").click(function(){
                showList(bno);
            });
            // $(".delBtn").click(function(){
            $("#commentList").on("click","delBtn", function(){ // commentList안에 있는 del버튼을 눌렀을때 작동
                let cno = $(this).parent().attr("data-cno");
                let bno = $(this).parent().attr("data-bno");

                $.ajax({
                    type:'DELETE',
                    url: '/ch4/comments/'+cno+'?bno='+bno,
                    success : function(result){
                        alert(result)
                        showList(bno);
                    },
                    error : function(){alert("error")}
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
                tmp += '</li>'
            })
            return tmp + "</ul>";
        }
    </script>
</body>
</html>
