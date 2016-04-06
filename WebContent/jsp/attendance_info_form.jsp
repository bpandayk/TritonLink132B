<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>


<body>
    <h1>Attendance Period Info Form</h1>
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

            <%-- -------- INSERT Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if an insertion is requested
                    if (action != null && action.equals("insert")) {

                        // Begin transaction
                        conn.setAutoCommit(false);

                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO AttendancePeriod(student_num, start_date, " +
                            "end_date) VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setDate(2, java.sql.Date.valueOf(request.getParameter("start_date")));
                        pstmt.setDate(3, java.sql.Date.valueOf(request.getParameter("end_date")));
           
                        int rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if an update is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE AttendancePeriod SET student_num = ?, " +
                            "start_date = ?, end_date = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setDate(2, java.sql.Date.valueOf(request.getParameter("start_date")));
                        pstmt.setDate(3, java.sql.Date.valueOf(request.getParameter("end_date")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));

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
                            "DELETE FROM AttendancePeriod WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
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
                            "SELECT * FROM Student ORDER BY student_num ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student_Num</th>
                        <th>Start_Date</th>
                        <th>End_Date</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="attendance_info_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td><select name="student_num" required>
                              <%
                              if(!rs.isBeforeFirst()) {
                                  %>
                                  <option selected disabled>No students available</option>
                                  <%
                              } else {
                                  %>
                                  <option selected disabled>Select student</option>
                                  <%
                                  while ( rs.next() ) {
                                      %>
                                      <option value="<%=rs.getString("student_num")%>"><%=rs.getString("student_num")%></option>
                                      <%
                                  }
                              }
                            %>
                            </select></td>
                            <td><input type="date" value="" name="start_date" size="10" placeholder="yyyy-mm-dd" required></td>
                            <td><input type="date" value="" name="end_date" size="10" placeholder="yyyy-mm-dd" required></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery("SELECT * FROM AttendancePeriod ORDER BY student_num ASC");
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="attendance_info_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <input type="hidden" name="student_num" value="<%= rs.getString("student_num") %>">
                            <td style="text-align:center"><%= rs.getString("student_num") %></td>
                            <td>
                                <input type="date" value="<%= rs.getDate("start_date") %>" 
                                    name="start_date" size="10" placeholder="yyyy-mm-dd" required>
                            </td>
                            <td>
                                <input type="date" value="<%= rs.getDate("end_date") %>"
                                    name="end_date" size="10" placeholder="yyyy-mm-dd" required>
                            </td>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="attendance_info_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
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
