<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

<%
int class_id = Integer.parseInt(request.getParameter("class_id"));
String class_title = request.getParameter("class_title");
%>
<h2>Corresponding course for class "<%=class_title%>"</h2>

<p><b>Note</b>: Make sure to reload the class entry form to reflect any changes in the class list.</p>
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
                            "INSERT INTO ClassInstance(course_id, class_id) VALUES (?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("insert_corresponding_course")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("class_id")));
           
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
                            "DELETE FROM ClassInstance WHERE course_id = ? AND class_id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("courseid")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("class_id")));
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
                    		"SELECT * FROM ClassInstance WHERE class_id = " + class_id);
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Department</th>
                        <th>Course_Num</th>
                        <th>Action</th>
                    </tr>
                    <%
                    // The class has no corresponding course so show row data to allow insertion
                    if (!rs.isBeforeFirst()) {
                    	rs.close();  // Close previous query to execute new one
                    	
                    	rs = statement.executeQuery(
                    			"SELECT * FROM Course " +
                    	        //"WHERE id NOT IN (SELECT course_id FROM ClassInstance) " +
                    	        "ORDER BY department, course_num ASC");
                    %>
                        <tr>
                            <form action="edit_corresponding_course_form.jsp" method="post">
                                <input type="hidden" value="insert" name="action">
                                <input type="hidden" name="class_id" value="<%=class_id%>">
                                <input type="hidden" name="class_title" value="<%=class_title%>">
                                <td colspan="2"><select name="insert_corresponding_course" required>
                                <%
                                while ( rs.next() ) {
                                    String dpmt = rs.getString("department");
                                    String c_num = rs.getString("course_num");
                                    %>
                                    <option value="<%=rs.getInt("id")%>"><%=dpmt + " " + c_num%></option>
                                    <%
                                }
                            %>
                                </select></td>
                                <td><input type="submit" value="Insert"></td>
                            </form>
                        </tr>
                    <%
                    }
                    %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                            "SELECT id AS courseid, department, course_num FROM Course " +
                            "WHERE id = (SELECT course_id FROM ClassInstance " +
                                        "WHERE class_id = " + class_id + ")");

                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_corresponding_course_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="class_id" value="<%=class_id%>">
                            <input type="hidden" name="class_title" value="<%=class_title%>">
                            <input type="hidden" name="courseid" value="<%=rs.getInt("courseid")%>">
                            <td><%= rs.getString("department") %></td>
                            <td><%= rs.getString("course_num") %></td>
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
</body>

</html>
