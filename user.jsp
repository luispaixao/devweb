<%-- 
    Document   : user
    Created on : 22/11/2018, 12:19:01
    Author     : luis
--%>

<%@page import="java.sql.*"%>
<%@page import="EDConta.Conta"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EdBank</title>
        <link  rel="stylesheet" href="style.css">
    </head>
    <body>


        <header>
            <img src="EDCOM.png" style="width: 50px ; height: 50px;">

        </header>
        <nav> 
            <ul> 
                <li> um </li>
                <li> dois</li>
                <li> tres</li>

            </ul>

        </nav>
       
        <section>   
            
            <%
                String user = (String) session.getAttribute("user");
                String name = (String) session.getAttribute("name");
                String cpf = (String) session.getAttribute("cpf");
                if (user == null) {
                    response.sendRedirect("index.jsp");
                } else {
                    out.print("<h1> Seja Bem-vindo " + name + "</h1>");

                    Connection con = null;
                    try {
                        con = DriverManager.getConnection("jdbc:derby://localhost:1527/bd_edbank", "edbank", "edbank");
                    } catch (Exception ex) {
                        out.print("deu errado" + ex);
                    }

                    PreparedStatement sql = con.prepareStatement("select number_conta, saldo from conta inner join "
                            + "cliente on conta.cpfcli = cliente.cpf where cpf = ?");
                    sql.setString(1, cpf);
                    ResultSet r = sql.executeQuery();
                   if (r.next()) {
                        out.print(" <div class='saldo'><header><h1> Conta EDBank </h1></header>"
                                + "<div class='conteudo'> <p> Conta Corrente: " + r.getString("number_conta")+ "</p>"                                                               
                                + "<p> seu saldo é: R$" + r.getDouble("saldo")+ "</p></div>"
                                + "</div>");                        
                        sql.close();
                       
                   }
                   
                   

                }

            %>
        </section>
    </body>
</html>
