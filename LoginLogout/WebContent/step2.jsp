<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("UTF-8");

%>

<%! 
/*****************************************************************************************/
//사용자 인증 로직
//이름과 암호를 비교하며 승인되면 true, 승인이 안되면 false를 반환한다.

//아래 이름의 사용자면 로그인 승인 함.
private static final String authorizedUsername="codingCat";
//아래의 암호를 입력하면 로그인 승인 함
private static final String authorizedPassword="qwerty123456!";
//로그인 승인시 true, 아니면 false
private boolean authorizeStatus = false;

//authorizeMembership(String trialUsername, String trialPassword)
//사용자 이름과 암호를 비교하여 로그인 승인 여부를 결정하는 서브루틴
//trialUsername : 로그인을 시도하는 사용자 이름
//trialPassword : 로그인을 시도하는 사용자가 입력한 암호
//로그인 승인하면 true를 반환하고, 승인 거부 시 false를 반환한다.

private static boolean authorizeMembership(String trialUsername, String trialPassword)
{
	//로그인 요청하는 사용자 이름이 미리 지정된 이름과 같은지 검사
	if(authorizedUsername.equals(trialUsername))
	{
		//이름이 일치하면, 암호가 같은지 검사
		if(authorizedPassword.equals(trialPassword))
		{
			//이름과 암호가 모두 일치하면 로그인 승인
			return true;
		}
	}
	//그렇지 않을 경우 로그인 거부
	return false;
}
%>
<%
/***********************************************************************/
//웹페이지 헤더 영역
//세션에 기로고딘 사용자 이름 및 암호를 읽어와서 로그인 유효성을 검증한다.
String trialUsername = null;
String trialPassword = null;
authorizeStatus = false;

//POST 방식으로 넘어온 데이터 중 trialUsername이라는 데이터가 있는지 확인
if(request.getParameter("trialUsername")!=null)
{
	trialUsername = request.getParameter("trialUsername");
	
	//trialUsername이 존재하면, trialPassword라는 데이터도 있는지 확인
	if(request.getParameter("trialPassword")!=null)
	{
		trialPassword = request.getParameter("trialPassword");
		
		//trialUsername과 trialPassword가 모두 수신되면,
		//위에서 선언한 authorizeMembership 서브루틴을 호출하여 로그인 요청한다.
		authorizeStatus = authorizeMembership(trialUsername, trialPassword);
	}
}

if(authorizeStatus)
{
	//membershipUsername이라 이름붙인 세션변수에 사용자 이름을 기록한다.
	session.setAttribute("membershipUsername", trialUsername);
	//membershipPassword이라 이름붙인 세션변수에 사용자 암호를 기록한다.
	session.setAttribute("membershipPassword", trialPassword);
	
	//세션의 유효기간은 현재 시점으로부터 12시간이다. 60초*60*12 ->12시간
	session.setMaxInactiveInterval(12*60*60);
}
%>
<%
/*************************************************************************/
//웹 페이지 본문 영역
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>2단계 : 사용자 인증</title>
<style>a{color:#0000FF;}</style>
</head>
<body>
	<header>
		<h1>2단계 : 사용자 인증</h1>
	</header>
	<hr>
	<section>
	<% 
		if(authorizeStatus)
		{
	%>
			<p>로그인에 성공했습니다.</p>
			<p><a href="./step3.jsp">회원 페이지</a></p>
	<% 
		}else{
	%>
			<p>로그인에 실패했습니다.</p>
			<p><a href="./step1.jsp">로그인 화면</a></p>
	<% 
		}
	%>
	</section>
	<hr>
	<footer>
			<p>
			<span><a href="./step1.jsp">1단계 (로그인)</a>| </span>
			<span><strong>2단계 (사용자인증)</strong> | </span>
			<span><a href="./step3.jsp">3단계 (회원페이지)</a> | </span>
			<span><a href="./step4.jsp">4단계 (로그아웃)</a> | </span>
			</p>
	</footer>
</body>
</html>