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

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>3�ܰ� : ȸ�� ������</title>
<style>a{color:#0000FF;}</style>
</head>
<body>
	<header>
		<h1>3�ܰ� : ȸ�� ������</h1>
	</header>
	<hr>
	<section>
	<% 
		if(authorizeStatus)
		{
	%>
			<p>ȸ�� ���� ������</p>
			<p>ȯ���մϴ�. <%= membershipUsername %>��</p>
			<p>��� ���ڿ� : </p>
			<% for(java.util.Enumeration<String> e = request.getHeaders("Cookie"); e.hasMoreElements();){ %>
			<pre><code><%= e.nextElement() %></code></pre>
			<% } %>
			<p><a href="./step4.jsp">�α׾ƿ�</a></p>
	<% } else { %>
			<p>�� �������� ������ �α����� �ʿ��մϴ�.</p>
			<p><a href="./step1.jsp">�α���</a></p>
	<% } %>
			
	</section>
	<hr>
	<footer>
			<p>
			<span><a href="./step1.jsp">1�ܰ� (�α���)</a>| </span>
			<span><a href="./step2.jsp">2�ܰ� (���������)</a> | </span>
			<span><strong>3�ܰ� (ȸ��������)</strong> | </span>
			<span><a href="./step4.jsp">4�ܰ� (�α׾ƿ�)</a> | </span>
			</p>
	</footer>
</body>
</html>