<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/pastClassesTakenForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Past Classes Taken Form</h1>
    <div style="height:300px;overflow:auto;">
    <table>
        <tr>
            <td valign="top">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="/html/menu.html" />
            </td>
            <td>

            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <%-- -------- Open Connection Code -------- --%>
            <%
                try {
                    DriverManager.registerDriver(new org.postgresql.Driver());
                    
                    // Make a connection to the Oracle datasource "cse132b"
                    Connection conn = DriverManager.getConnection
                    ("jdbc:postgresql:CSE132B?user=jack&password=jack");
                        /*("jdbc:postgresql://om.ucsd.edu:1433;databaseName=cse132b", 
                            "username", "password");*/
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    ResultSet rs = statement.executeQuery(
                        "SELECT student_num FROM Student");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student_Num</th>
                        <th>Add_Taken</th>
                        <th>View_Taken</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    while ( rs.next() ) {
            %>
                    <tr>
                        <td><input type="text" value="<%= rs.getString("student_num")%>" size="20" readonly></td>
                        <td>
                          <input type="button" value="Add Classes" onclick="addPastClasses('<%=rs.getString("student_num")%>');">
                        </td>
                        <td>
                          <input type="button" value="View Classes" onclick="viewPastClasses('<%=rs.getString("student_num")%>');">
                        </td>
                    </tr>
            <%
                    }
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    rs.close();
    
                    // Close the Statement
                    statement.close();
    
                    // Close the Connection
                    conn.close();
                } catch (SQLException sqle) {
                    out.println(sqle.getMessage());
                } catch (Exception e) {
                    out.println(e.getMessage());
                }
            %>
                </table>
            </td>
        </tr>
    </table>
    </div>
    <hr>
    <iframe style="display:none;" width="1100" height="300" frameBorder="0"
            id="add_past_classes_iframe" name="add_past_classes_iframe"></iframe>
    <iframe style="display:none;" width="1100" height="300" frameBorder="0"
            id="edit_past_classes_iframe" name="edit_past_classes_iframe"></iframe>
</body>

</html>
