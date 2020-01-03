<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("UTF-8");

%>

<%!
/*****************************************************************************************/
//����� ���� ����
//�̸��� ��ȣ�� ���ϸ� ���εǸ� true, ������ �ȵǸ� false�� ��ȯ�Ѵ�.

//�Ʒ� �̸��� ����ڸ� �α��� ���� ��.
private static final String authorizedUsername="codingCat";
//�Ʒ��� ��ȣ�� �Է��ϸ� �α��� ���� ��
private static final String authorizedPassword="qwerty123456!";
//�α��� ���ν� true, �ƴϸ� false
private boolean authorizeStatus = false;

//authorizeMembership(String trialUsername, String trialPassword)
//����� �̸��� ��ȣ�� ���Ͽ� �α��� ���� ���θ� �����ϴ� �����ƾ
//trialUsername : �α����� �õ��ϴ� ����� �̸�
//trialPassword : �α����� �õ��ϴ� ����ڰ� �Է��� ��ȣ
//�α��� �����ϸ� true�� ��ȯ�ϰ�, ���� �ź� �� false�� ��ȯ�Ѵ�.

private static boolean authorizeMembership(String trialUsername, String trialPassword)
{
	//�α��� ��û�ϴ� ����� �̸��� �̸� ������ �̸��� ������ �˻�
	if(authorizedUsername.equals(trialUsername))
	{
		//�̸��� ��ġ�ϸ�, ��ȣ�� ������ �˻�
		if(authorizedPassword.equals(trialPassword))
		{
			//�̸��� ��ȣ�� ��� ��ġ�ϸ� �α��� ����
			return true;
		}
	}
	//�׷��� ���� ��� �α��� �ź�
	return false;
}
%>

<%
/***********************************************************************************************/
//�� ������ ��� ����
//���ǿ� ��ϵ� ����� �̸� �� �Ϸθ� �о�ͼ� �α��� ��ȿ���� �����Ѵ�.
String membershipUsername = null;
String membershipPassword = null;
Cookie objectUsername = null;
Cookie objectPassword = null;
authorizeStatus = false;

//�α��� ��ȿ�� �˻� : ���ǿ� ����� �α��� ������ �����Ѵ�.
//���� ���� �� membershipUsername�̶�� �����Ͱ� �ִ��� Ȯ��
if(session.getAttribute("membershipUsername")!=null)
{
	//membershipUsername�� �����ϸ�, membershipPassword��� �����͵� �ִ��� Ȯ��
	if(session.getAttribute("membershipPassword")!=null)
	{
		//���� �������� ���� ����� �̸��� ��ȣ�� �α��� ���°� ��ȿ���� ����
		membershipUsername = (String)session.getAttribute("membershipUsername");
		membershipPassword = (String)session.getAttribute("membershipPassword");
		
		//membershipUsername�� membershipPassword�� ��� ���ŵǸ�,
		//�ռ� ���ǵ� authorizeMembership �޼���� ���� ��û�Ѵ�.
		authorizeStatus = authorizeMembership(membershipUsername, membershipPassword);
	}
}

//�α��� ��û�� ���εǾ��ٸ�.
if(authorizeStatus)
{
	//membershipUsername�̶� �̸����� ���Ǻ����� ����� �̸��� ����Ѵ�.
	session.setAttribute("membershipUsername", membershipUsername);
	//membershipPassword�̶� �̸����� ���Ǻ����� ����� ��ȣ�� ����Ѵ�.
	session.setAttribute("membershipPassword", membershipPassword);
	
	//������ ��ȿ�Ⱓ�� ���� �������κ��� 12�ð��̴�. 60��*60*12 ->12�ð�
	session.setMaxInactiveInterval(12*60*60);
}
%>

<%/****************************************************************************************/
	//�������� ���� ����
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>1�ܰ� �α���</title>
<style>a{color:#0000FF;}</style>
</head>
<body>
	<header>
		<h1>1�ܰ� �α���</h1>
	</header>
		<hr/>
	<section>
		<% if(authorizeStatus) {%>
			<p> �̹� �α��εǾ� �ֽ��ϴ�.</p>
			<p><a href="./step3.jsp">ȸ�� ������</a></p>
		<%} else { %>
			<p>����� �̸��� ����� ��ȣ�� �Է��ϼ���. </p>
			<form action="./step2.jsp" method="post">
				<label for="trialUsername">����� �̸� : </label>
				<input type="text" id="trialUsername" name="trialUsername">
				<label for="trialPassword">����� ��ȣ : </label>
				<input type="password" id="trialPassword" name="trialPassword">
				<input type="submit">
				
			</form>
		<% } %>
	
	
	
		
	</section>
	<hr>
	<footer>
		<p>
			<span><strong>1�ܰ� (�α���)</strong> | </span>
			<span><a href="./step2.jsp">2�ܰ� (���������)</a> | </span>
			<span><a href="./step3.jsp">3�ܰ� (ȸ��������)</a> | </span>
			<span><a href="./step4.jsp">4�ܰ� (�α׾ƿ�)</a> | </span>
		</p>
	</footer>
		
</body>
</html>