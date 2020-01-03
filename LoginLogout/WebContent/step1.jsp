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
/***********************************************************************************************/
//웹 페이지 헤더 영역
//세션에 기록된 사용자 이름 및 암로를 읽어와서 로그인 유효성을 검증한다.
String membershipUsername = null;
String membershipPassword = null;
Cookie objectUsername = null;
Cookie objectPassword = null;
authorizeStatus = false;

//로그인 유효성 검사 : 세션에 저장된 로그인 정보를 검증한다.
//세션 변수 중 membershipUsername이라는 데이터가 있는지 확인
if(session.getAttribute("membershipUsername")!=null)
{
	//membershipUsername이 존재하면, membershipPassword라는 데이터도 있는지 확인
	if(session.getAttribute("membershipPassword")!=null)
	{
		//세션 변수에서 얻은 사용자 이름과 암호로 로그인 상태가 유효한지 검증
		membershipUsername = (String)session.getAttribute("membershipUsername");
		membershipPassword = (String)session.getAttribute("membershipPassword");
		
		//membershipUsername과 membershipPassword가 모두 수신되면,
		//앞서 정의된 authorizeMembership 메서드로 고르인 요청한다.
		authorizeStatus = authorizeMembership(membershipUsername, membershipPassword);
	}
}

//로그인 요청이 승인되었다면.
if(authorizeStatus)
{
	//membershipUsername이라 이름붙인 세션변수에 사용자 이름을 기록한다.
	session.setAttribute("membershipUsername", membershipUsername);
	//membershipPassword이라 이름붙인 세션변수에 사용자 암호를 기록한다.
	session.setAttribute("membershipPassword", membershipPassword);
	
	//세션의 유효기간은 현재 시점으로부터 12시간이다. 60초*60*12 ->12시간
	session.setMaxInactiveInterval(12*60*60);
}
%>

<%/****************************************************************************************/
	//웹페이지 본문 영역
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>1단계 로그인</title>
<style>a{color:#0000FF;}</style>
</head>
<body>
	<header>
		<h1>1단계 로그인</h1>
	</header>
		<hr/>
	<section>
		<% if(authorizeStatus) {%>
			<p> 이미 로그인되어 있습니다.</p>
			<p><a href="./step3.jsp">회원 페이지</a></p>
		<%} else { %>
			<p>사용자 이름과 사용자 암호를 입력하세요. </p>
			<form action="./step2.jsp" method="post">
				<label for="trialUsername">사용자 이름 : </label>
				<input type="text" id="trialUsername" name="trialUsername">
				<label for="trialPassword">사용자 암호 : </label>
				<input type="password" id="trialPassword" name="trialPassword">
				<input type="submit">
				
			</form>
		<% } %>
	
	
	
		
	</section>
	<hr>
	<footer>
		<p>
			<span><strong>1단계 (로그인)</strong> | </span>
			<span><a href="./step2.jsp">2단계 (사용자인증)</a> | </span>
			<span><a href="./step3.jsp">3단계 (회원페이지)</a> | </span>
			<span><a href="./step4.jsp">4단계 (로그아웃)</a> | </span>
		</p>
	</footer>
		
</body>
</html>