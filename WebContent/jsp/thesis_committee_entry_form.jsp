<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/thesisCommitteeEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h3>Thesis Committee Entry Form</h3>
    <p><b>Note:</b> Masters thesis committees require at least 3 faculty members from the same department,<br>
            and PhD thesis committees require at least 3 faculty members from the same department and 1 faculty
            member from a different department.<br><br>
          Click the Edit buttons to view whether each committee fulfills these requirements.</p>
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
                        "SELECT g.id AS gid, g.graduate_num AS grad_num, graduate_type, " +
                        "g.department AS grad_dpmt, COUNT(tc.id) AS committee_size " +
                        "FROM Graduate g LEFT OUTER JOIN ThesisCommittee tc ON g.graduate_num = tc.graduate_num " +
                        "GROUP BY g.id, g.graduate_num, graduate_type " +
                        "ORDER BY g.graduate_num ASC");
            %>
                <table border="1">
                    <tr>
                        <th>Graduate_Num</th>
                        <th>Graduate_Type</th>
                        <th>Department</th>
                        <th>Committee_Size</th>
                    </tr>
                    <%-- -------- Iteration Code -------- --%>
                    <%
                    while ( rs.next() ) {
                    %>
                    <tr>
                        <td><input type="text" value="<%= rs.getString("grad_num")%>" size="20" readonly></td>
                        <td><input type="text" value="<%= rs.getString("graduate_type")%>" size="15" readonly></td>
                        <td><input type="text" value="<%= rs.getString("grad_dpmt")%>" size="15" readonly></td>
                        <td>
                          <input type="text" name="<%=(rs.getInt("committee_size")) %>"
                              value="<%= rs.getInt("committee_size")%>" size="10" readonly>
                          <input style="float:right" type="button" value="Edit"
                              onclick="editCommittee('<%=rs.getString("grad_num")%>', '<%=rs.getString("graduate_type")%>');">
                        </td>
                    </tr>
                    <%
                    }
            %>
                </table>
            </td>
        </tr>
    </table>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    if(rs != null) {
                        rs.close();
                    }
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
    </div>
    <hr>
    <iframe style="display:none;" width="900" height="300" frameBorder="0"
       id="edit_committee_iframe" name="edit_committee_iframe"></iframe>
</body>

</html>