<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

<%
String faculty_name = request.getParameter("faculty_name");
%>
<h2>Sections currently taught by "<%=faculty_name%>"</h2>
<p><b>Note:</b> Only class sections that are linked to courses can be currently taught by faculty members.
<br></p>
<div style="height:300px;overflow:auto;">
    <table>
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
                            "INSERT INTO CurrentlyTeaching(section_id, faculty_name) VALUES (?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("sid")));
                        pstmt.setString(2, request.getParameter("faculty_name"));
           
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
                            "DELETE FROM CurrentlyTeaching WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ctid")));
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
                        "SELECT s.id AS sid, section_num, class_title, quarter, class_year " +
                        "FROM Course co, Class cl, ClassInstance ci, Section s " +
                        "WHERE s.id NOT IN (SELECT section_id FROM CurrentlyTeaching) " +
                        "AND co.id = ci.course_id AND cl.id = ci.class_id AND s.class_id = cl.id " +
                        "ORDER BY class_year, quarter ASC");
;
            %>
        <tr>  
            <td>
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th colspan="5">Section_Info</th>
                    </tr>
                    <tr>
                        <th>Quarter</th>
                        <th>Year</th>
                        <th>Class_Title</th>
                        <th>Section_Num</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="edit_currently_teaching_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="faculty_name" value="<%=faculty_name%>">
                            <td colspan="4"><select name="sid" required>
                            <%
                            if(!rs.isBeforeFirst()) {
                                %>
                                <option selected disabled>No sections available</option>
                                <%
                            } else {
                                while (rs.next()) {
                                    String quarter = rs.getString("quarter");
                                    String year = rs.getString("class_year");
                                    String title = rs.getString("class_title");
                                    String section_num = rs.getString("section_num");
                                    String class_info = quarter + " " + year + ": " + title + " --- Section: " + section_num;
                                    %>
                                    <option value="<%=rs.getInt("sid")%>"><%=class_info%></option>
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
                        "SELECT ct.id AS ctid, class_title, quarter, class_year, section_num " +
                        "FROM Class c, Section s, CurrentlyTeaching ct " +
                        "WHERE c.id = s.class_id AND s.id = ct.section_id " +
                        "AND ct.faculty_name = '" + faculty_name + "' " +
                        "ORDER BY class_year, quarter ASC");
            
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_currently_teaching_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="faculty_name" value="<%=faculty_name%>">
                            <input type="hidden" name="ctid" value="<%=rs.getInt("ctid")%>">
                            <td><input name="quarter" value="<%=rs.getString("quarter")%>" readonly></td>
                            <td><input name="class_year" value="<%=rs.getString("class_year")%>" readonly></td>
                            <td><input name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                            <td><input name="section_num" value="<%=rs.getString("section_num")%>" readonly></td>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
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
  </div>
</body>

</html>