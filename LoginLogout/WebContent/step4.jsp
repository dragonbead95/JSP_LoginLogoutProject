<%@page import="java.util.Enumeration"%>
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

//�α׾ƿ��� �α��� ���ο� �����ϰ� ����ȴ�.
//���ǰ�ü�� ������.
session.removeAttribute("membershipUsername");
session.removeAttribute("membershipPassword");
%>
<%
/**********************************************************************************************************/
//�������� ���� ����
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>4�ܰ� : �α׾ƿ�</title>
<style>a{color:#0000FF;}</style>
</head>
<body>
	<header>
		<h1>4�ܰ� : �α׾ƿ�</h1>
	</header>
	<hr>
	<section>
	<% 
		if(authorizeStatus)
		{
	%>
			<p>�α׾ƿ��Ǿ����ϴ�.</p>
			<p><a href="./step1.jsp">�α���</a></p>			
	<% }else {	%>
			<p>�α��εǾ� ���� �ʽ��ϴ�.</p>
			<p><a href="./step1.jsp">�α���</a></p>
		<%} %>			
			
			
	</section>
	<hr>
	<footer>
			<p>
			<span><a href="./step1.jsp">1�ܰ� (�α���)</a>| </span>
			<span><a href="./step2.jsp">2�ܰ� (���������)</a> | </span>
			<span><a href="./step3.jsp">3�ܰ� (ȸ��������)</a> | </span>
			<span><strong>4�ܰ� (�α׾ƿ�)</strong></span>
			</p>
	</footer>
</body>
</html>