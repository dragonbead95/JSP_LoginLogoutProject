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
/***********************************************************************/
//�������� ��� ����
//���ǿ� ��ΰ�� ����� �̸� �� ��ȣ�� �о�ͼ� �α��� ��ȿ���� �����Ѵ�.
String trialUsername = null;
String trialPassword = null;
authorizeStatus = false;

//POST ������� �Ѿ�� ������ �� trialUsername�̶�� �����Ͱ� �ִ��� Ȯ��
if(request.getParameter("trialUsername")!=null)
{
	trialUsername = request.getParameter("trialUsername");
	
	//trialUsername�� �����ϸ�, trialPassword��� �����͵� �ִ��� Ȯ��
	if(request.getParameter("trialPassword")!=null)
	{
		trialPassword = request.getParameter("trialPassword");
		
		//trialUsername�� trialPassword�� ��� ���ŵǸ�,
		//������ ������ authorizeMembership �����ƾ�� ȣ���Ͽ� �α��� ��û�Ѵ�.
		authorizeStatus = authorizeMembership(trialUsername, trialPassword);
	}
}

if(authorizeStatus)
{
	//membershipUsername�̶� �̸����� ���Ǻ����� ����� �̸��� ����Ѵ�.
	session.setAttribute("membershipUsername", trialUsername);
	//membershipPassword�̶� �̸����� ���Ǻ����� ����� ��ȣ�� ����Ѵ�.
	session.setAttribute("membershipPassword", trialPassword);
	
	//������ ��ȿ�Ⱓ�� ���� �������κ��� 12�ð��̴�. 60��*60*12 ->12�ð�
	session.setMaxInactiveInterval(12*60*60);
}
%>
<%
/*************************************************************************/
//�� ������ ���� ����
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<title>2�ܰ� : ����� ����</title>
<style>a{color:#0000FF;}</style>
</head>
<body>
	<header>
		<h1>2�ܰ� : ����� ����</h1>
	</header>
	<hr>
	<section>
	<% 
		if(authorizeStatus)
		{
	%>
			<p>�α��ο� �����߽��ϴ�.</p>
			<p><a href="./step3.jsp">ȸ�� ������</a></p>
	<% 
		}else{
	%>
			<p>�α��ο� �����߽��ϴ�.</p>
			<p><a href="./step1.jsp">�α��� ȭ��</a></p>
	<% 
		}
	%>
	</section>
	<hr>
	<footer>
			<p>
			<span><a href="./step1.jsp">1�ܰ� (�α���)</a>| </span>
			<span><strong>2�ܰ� (���������)</strong> | </span>
			<span><a href="./step3.jsp">3�ܰ� (ȸ��������)</a> | </span>
			<span><a href="./step4.jsp">4�ܰ� (�α׾ƿ�)</a> | </span>
			</p>
	</footer>
</body>
</html>