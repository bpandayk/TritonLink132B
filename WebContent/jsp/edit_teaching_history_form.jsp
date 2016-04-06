<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

<%
String faculty_name = request.getParameter("faculty_name");
%>
<h2>Teaching history for "<%=faculty_name%>"</h2>
<div style="height:300px;overflow:auto;">
    <table>
        <tr>
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

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO TeachingHistory(faculty_name, class_id) VALUES (?, ?)");

                        pstmt.setString(1, request.getParameter("faculty_name"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("cid")));
           
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- DELETE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("delete")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM TeachingHistory WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("tid")));
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();

                    ResultSet rs = statement.executeQuery(
                        "SELECT * FROM Class WHERE id NOT IN " +
                        "(SELECT c.id FROM Class c, TeachingHistory t " +
                        "WHERE c.id = t.class_id AND t.faculty_name = '" + faculty_name + "') " +
                        "ORDER BY class_year, quarter ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th colspan="4">Class_Info</th>
                    </tr>
                    <tr>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Class_Title</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="edit_teaching_history_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="faculty_name" value="<%=faculty_name%>">
                            <td colspan="3"><select name="cid" required>
                            <%
                            if(!rs.isBeforeFirst()) {
                                %>
                            	<option selected disabled>No classes available</option>
                            	<%
                            } else {
                                while (rs.next()) {
                                	String quarter = rs.getString("quarter");
                                	String year = rs.getString("class_year");
                                	String title = rs.getString("class_title");
                                	String class_info = quarter + " " + year + ": " + title;
                                    %>
                                    <option value="<%=rs.getInt("id")%>"><%=class_info%></option>
                                    <%
                                }
                            }
                            %>
                            </select></td>
                            <td><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                        "SELECT t.id AS tid, class_title, quarter, class_year FROM Class c, TeachingHistory t " +
                        "WHERE c.id = t.class_id AND t.faculty_name = '" + faculty_name + "' " +
                        "ORDER BY class_year, quarter ASC");
            
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_teaching_history_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="faculty_name" value="<%=faculty_name%>">
                            <input type="hidden" name="tid" value="<%=rs.getInt("tid")%>">
                            <td><input name="quarter" value="<%=rs.getString("quarter")%>" readonly></td>
                            <td><input name="class_year" value="<%=rs.getString("class_year")%>" readonly></td>
                            <td><input name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
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
</body>

</html>