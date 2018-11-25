<%-- 
    Document   : cadastro
    Created on : 16/11/2018, 22:21:27
    Author     : luis
--%>

<%@page import="EDConta.Conta"%>
<%@page import="java.sql.*"%>
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
            <h3>Criar conta EDBank</h3>

            <form method="post" action="cadastro.jsp">
                <p>Nome:</p>
                <input type="text" name="nome" placeholder="Digite seu nome">
                <p>CPF:</p>
                <input type="text" name="cpf" placeholder="Digite seu cpf(só numeros)">                
                <p>Senha:</p>
                <input type="password"  name="senha" placeholder="senha">
                <input type="submit"  name="btlogin" value="Login">
            </form>            
        </div>
        
        <%
            String nome = request.getParameter("nome");
            String cpf = request.getParameter("cpf");
            String senha = request.getParameter("senha");  
                      
            Connection con = null;
        try {
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/bd_edbank",
                    "edbank", "edbank");
        } catch (Exception ex){
            out.print(ex);                  
        }
        PreparedStatement sql = con.prepareStatement("SELECT CPF FROM CLIENTE");
        ResultSet r = sql.executeQuery() ;
        while(r.next()){
            if (cpf == r.getString("cpf")){
                response.sendRedirect("cadastro.html");
                sql.close();
            }        
        }
        Conta c = new Conta();
        out.print("<p> conta "+ c.getNumero() + "</p>");
        
       PreparedStatement gravar = con.prepareStatement("insert into cliente (nome,cpf,senha) values (?,?,?)");
       gravar.setString(1, nome);
       gravar.setString(2, cpf);
       gravar.setString(3, senha);
       
        
        
        
        
        
        %>
    </body>
</html>
