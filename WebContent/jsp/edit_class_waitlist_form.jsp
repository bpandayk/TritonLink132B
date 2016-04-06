<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>


<body>

<%
int section_id = Integer.parseInt(request.getParameter("section_id"));
String section_num = request.getParameter("section_num");
%>
<h2>Waitlist for section_num "<%=section_num%>"</h2>

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
                            "INSERT INTO SectionWaitlist(student_num, section_id, " +
                            "position) VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("position")));
           
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
                            "DELETE FROM SectionWaitlist WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("swid")));
                        int rowCount = pstmt.executeUpdate();

                        PreparedStatement updatePstmt = conn.prepareStatement(
                                "UPDATE SectionWaitlist SET position = position - 1 " +
                                "WHERE section_id = ? AND position > ?");
                            
                        updatePstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
                        updatePstmt.setInt(2, Integer.parseInt(request.getParameter("delete_position")));
                        rowCount = updatePstmt.executeUpdate();

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
                        "SELECT COUNT(id) AS current_waitlist_size " +
                        "FROM SectionWaitlist WHERE section_id = " + section_id);
                    rs.next();
                    int current_waitlist_size = rs.getInt("current_waitlist_size");

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Position</th>
                        <th>Student_Num</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="edit_class_waitlist_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="section_id" value="<%=section_id%>">
                            <input type="hidden" name="section_num" value="<%=section_num%>">
                            <input type="hidden" name="position" value="<%=current_waitlist_size + 1%>">
                            <td><b><%=current_waitlist_size + 1%></b></td>
                            <td><input value="" name="student_num" size="20" required></td>
                            <td><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                        "SELECT * FROM SectionWaitlist WHERE section_id = " + section_id + " " +
                        "ORDER BY position ASC");
            
                    while ( rs.next() ) {
            %>
                    <tr>
                            <td style="text-align:center"><%=rs.getInt("position")%></td>
                            <td style="text-align:center"><%=rs.getString("student_num")%></td>
                        <form action="edit_class_waitlist_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="swid" value="<%=rs.getInt("id")%>">
                            <input type="hidden" name="section_id" value="<%=section_id%>">
                            <input type="hidden" name="section_num" value="<%=section_num%>">
                            <input type="hidden" name="delete_position" value="<%=rs.getInt("position")%>">
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