<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
  <%
  if(request.getParameter("view_degrees") == null) {
  %>
    <form action="prev_degree_entry_form.jsp" method="post">
        <input type="submit" value="View" name="view_degrees">
    </form>
    <%
    } else {
    %>
    <div style="height:300px;overflow:auto;">
    <p><b>Note</b>: Student_Num field is read-only after it has been inserted.</p>
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
                            "INSERT INTO PreviousDegree(student_num, type, major, school_name) VALUES (?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("type"));
                        pstmt.setString(3, request.getParameter("major"));
                        pstmt.setString(4, request.getParameter("school_name"));
           
                        int rowCount = pstmt.executeUpdate();

                        // Commit transaction
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
                            "UPDATE PreviousDegree SET student_num = ?, type = ?, "
                            + "major = ?, school_name = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("type"));
                        pstmt.setString(3, request.getParameter("major"));
                        pstmt.setString(4, request.getParameter("school_name"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));

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
                            "DELETE FROM PreviousDegree WHERE id = ?");

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
                        <th>Degree_Type</th>
                        <th>Degree_Major</th>
                        <th>School_Name</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="prev_degree_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" value="View" name="view_degrees">
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
                            <td><input value="" name="type" required></td>
                            <td><input value="" name="major" required></td>
                            <td><input value="" name="school_name" required></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs = statement.executeQuery("SELECT * FROM PreviousDegree ORDER BY student_num ASC");

                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="prev_degree_entry_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="View" name="view_degrees">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <td>
                              <input name="student_num" value="<%= rs.getString("student_num") %>" readonly>
                            </td>
                            <td>
                              <input name="type" value="<%= rs.getString("type") %>" required>
                            </td>
                            <td>
                              <input name="major" value="<%= rs.getString("major") %>" required>
                            </td>
                            <td>
                              <input name="school_name" value="<%= rs.getString("school_name") %>" required></td>
                            <td>
                              <input type="submit" value="Update">
                            </td>
                        </form>
 
                        <form action="course_entry_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="View" name="view_degrees">
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
    </div>
    <%
    }  // end else
    %>
</body>

</html>
