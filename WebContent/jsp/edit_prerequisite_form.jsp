<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

<%
int target_id = Integer.parseInt(request.getParameter("target_id"));
String target_department = request.getParameter("target_department");
String target_course_num = request.getParameter("target_course_num");
%>
<h2>Prerequisites for course "<%=target_department%> <%=target_course_num%>"</h2>
<p><b>Note:</b> A course cannot be its own prerequisite.</p>
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
                            "INSERT INTO Prerequisite(target_id, prerequisite_id) VALUES (?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("target_id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("insert_prereq")));
           
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
                            "DELETE FROM Prerequisite WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("pid")));
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

                    ResultSet rs = statement.executeQuery("SELECT id, department, course_num " +
                        "FROM Course WHERE id NOT IN (SELECT prerequisite_id FROM Prerequisite " +
                        "WHERE target_id = '" + target_id + "') AND id <> '" + target_id + "'");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Department</th>
                        <th>Course_Num</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="edit_prerequisite_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="target_id" value="<%=target_id%>">
                            <input type="hidden" name="target_department" value="<%=target_department%>">
                            <input type="hidden" name="target_course_num" value="<%=target_course_num%>">
                            <td colspan="2"><select name="insert_prereq" required>
                            <%
                            if( !rs.isBeforeFirst() ) {
                                %>
                                <option disabled>No courses available</option>
                                <% 
                            } else {
                                while ( rs.next() ) {
                                	String dpmt = rs.getString("department");
                                    String c_num = rs.getString("course_num");
                                    %>
                                    <option value="<%=rs.getInt("id")%>"><%=dpmt + " " + c_num%></option>
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
                    rs = statement.executeQuery("SELECT p.id AS pid, c2.department AS prereq_department, " +
                         "c2.course_num AS prereq_course_num FROM prerequisite p, course c1, course c2 " +
                         "WHERE p.target_id = '" + target_id + "' AND p.target_id = c1.id " +
                         "AND p.prerequisite_id = c2.id");

                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_prerequisite_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="target_id" value="<%=target_id%>">
                            <input type="hidden" name="target_department" value="<%=target_department%>">
                            <input type="hidden" name="target_course_num" value="<%=target_course_num%>">
                            <input type="hidden" name="pid" value="<%= rs.getInt("pid")%>">
                            <td><%= rs.getString("prereq_department") %></td>
                            <td><%= rs.getString("prereq_course_num") %></td>
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
