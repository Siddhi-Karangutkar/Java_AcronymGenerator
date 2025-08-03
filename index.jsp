<%@ page import = "java.sql.*" %>
<html>
    <head>
        <title>Acronym Explorer</title>
        <link rel ="stylesheet" href = "style.css"></link>
    </head>
    <body>
        <h3>Acronym Explorer</h3>
        <%
            String msg = "";
            String acronym = "";
            String fullform = "";

            if(request.getParameter("btnGetAcronym")!=null){
                try{
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/acronymdb_aug25";
                    Connection con = DriverManager.getConnection(url,"root","{your_password}");

                    String sql = "select acronym from acronym_info order by RAND() LIMIT 1";
                    PreparedStatement pst = con.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery();
                    

                    while(rs.next()){
                        acronym = rs.getString(1);
                    }

                }catch(Exception e){
                    msg = "issue: "+e;
                }
            }


            if(request.getParameter("btnGetFullForm")!=null){
                acronym = request.getParameter("acronym");
                try{
                    DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
                    String url = "jdbc:mysql://localhost:3306/acronymdb_aug25";
                    Connection con = DriverManager.getConnection(url,"root","{your_password}");

                    String sql = "select fullform from acronym_info where acronym = ?";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1,acronym);
                    ResultSet rs = pst.executeQuery();
                    

                    if(rs.next()){
                        fullform = rs.getString(1);
                    }

                }catch(Exception e){
                    msg = "issue: "+e;
                }
            }


        %>

            <div class = "card-container">
            <div class = "card">
        <form method="POST">
            <input type = "submit" name = "btnGetAcronym" value = "Get Acronym"/></br>
            <input type = "text" name = "acronym" placeholder = "Get Acronym" value = "<%=acronym%>" readOnly/></br>
            <input type = "submit" name = "btnGetFullForm" value = "Get Full Form"/></br>
            <input type = "text" name = "fullFrom" placeholder = "Get Full form" value = "<%=fullform%>" readOnly/></br>
        </form>
        </div>
        </div>
    </body>

</html>
