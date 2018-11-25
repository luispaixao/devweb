<%-- 
    Document   : index
    Created on : 21/11/2018, 22:37:49
    Author     : luis
--%>

<%@page import="java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link  rel="stylesheet" href="style.css">
    </head>
    <body>
        <div class="mainbox">
            <h1>Login in EDbank</h1>

            <form method="post" action="index.jsp">
                <p>CPF:</p>
                <input type="text" name="cpf" placeholder="CPF">
                <p>Senha:</p>
                <input type="password"  name="pass" placeholder="senha">
                <input type="submit"  name="btlogin" value="Login">
                <a href="cadastro.jsp">Criar uma conta</a>                
            </form>            
        </div>
        <%
            Connection con = null;
            try {
                con = DriverManager.getConnection("jdbc:derby://localhost:1527/bd_edbank", "edbank", "edbank");
                out.print("<p>conectado</p>");
            } catch (Exception ex) {
                out.print("deu errado" + ex);

            }
            String userCPF = request.getParameter("cpf");
            String userPass = request.getParameter("pass");
            PreparedStatement sql = con.prepareStatement("select * from cliente");
            ResultSet r = sql.executeQuery();

            while (r.next()) {
                //out.print(r.getString("cpf") + r.getString("senha"));

                if (r.getString("cpf").equals(userCPF) && r.getString("senha").equals(userPass)) {
                    HttpSession s = request.getSession();
                    s.setMaxInactiveInterval(20);
                    s.setAttribute("user", userCPF);
                    s.setAttribute("name", r.getString("nome"));
                    s.setAttribute("cpf", r.getString("cpf"));
                    response.sendRedirect("user.jsp");
                    
                }}  

        %>

    </body>
</html>
