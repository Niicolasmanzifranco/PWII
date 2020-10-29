<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <title>JSP Page</title>
        <%        
        Statement st = null;
        ResultSet rs = null;             
    %>
    </head>
    
    <body>
        <div class="container">
            <form action="index.jsp" method="Post">
                <label>Email:</label>
                <input type="text" name="email" class="form-control" required>
                <label>Senha:</label>
                <input type="text" name="senha" class="form-control" required>
                <center>
                    <br>
                    <input type="submit" class="btn btn-primary" value="Fazer login">
                </center>
            </form>
            <%
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                
                String nomeUsuario = "";
                
                String em = "";
                String se = "";
                
                int i = 0;
                
                try{                    
                    st = new Conexao().conectar().createStatement();
                    rs = st.executeQuery("select * from usuarios where email = '" + email + "' and senha = '" + senha + "'");
                    while(rs.next()){
                        nomeUsuario = rs.getString(2);
                        em = rs.getString(3);
                        se = rs.getString(4);                        
                        rs.last();
                        i = rs.getRow();
                    }
                    
                }catch(Exception e){
                    out.println(e);
                }
                
                if(email == null || senha == null){
                    out.println("Preencha os dados");
                } else{
                    if(i>0){
                        session.setAttribute("nomeUsuario", nomeUsuario);
                        response.sendRedirect("usuarios.jsp");
                    }
                }
            %>
        </div>
    </body>
</html>
