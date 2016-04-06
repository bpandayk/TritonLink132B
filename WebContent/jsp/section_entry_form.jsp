<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/sectionEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Section Entry Form</h1>
    <div style="height:300px;overflow:auto;">
    <p><b>Note:</b> Create sections by directly adding them to existing classes.
    To edit class information, go to the class entry form.</p>
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
                        "SELECT c.id AS cid, c.class_title AS class_title, c.quarter AS quarter, " +
                        "c.class_year AS class_year, COUNT(s.id) AS section_count " +
                        "FROM Class c LEFT OUTER JOIN Section s ON c.id = s.class_id " +
                        "GROUP BY cid, class_title, quarter, class_year ORDER BY class_year, quarter ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Class_Title</th>
                        <th>Quarter</th>
                        <th>Class_Year</th>
                        <th>Total_Sections</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    while ( rs.next() ) {
            %>
                    <tr>
                        <td><input type="text" value="<%= rs.getString("class_title")%>" size="20" readonly></td>
                        <td><input type="text" value="<%= rs.getString("quarter")%>" size="10" readonly></td>
                        <td><input type="text" value="<%= rs.getString("class_year")%>" size="10" readonly></td>
                        <td>
                          <input type="text" value="<%= rs.getInt("section_count")%>" size="10" readonly>
                          <input style="float:right" type="button" value="Edit" onclick="editSections
                              (<%=rs.getInt("cid")%>, '<%=rs.getString("class_title")%>',
                              '<%=rs.getString("quarter")%>', '<%=rs.getString("class_year")%>');">
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
    <iframe style="display:none;" width="700" height="300" frameBorder="0" id="section_iframe" name="section_iframe"></iframe>
</body>

</html>
