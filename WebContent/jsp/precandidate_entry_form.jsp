<!DOCTYPE html>

<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
<h4>Precandidate Entry Form</h4>
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
                        
                        // Create the prepared statement and use it to
                        // INSERT the student attributes INTO the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "INSERT INTO Student(student_num, ssn, first_name, middle_name, " +
                            "last_name, residency, student_type) VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("ssn"));
                        pstmt.setString(3, request.getParameter("first_name"));
                        pstmt.setString(4, request.getParameter("middle_name"));
                        pstmt.setString(5, request.getParameter("last_name"));
                        pstmt.setString(6, request.getParameter("residency"));
                        pstmt.setString(7, request.getParameter("student_type"));
                        int rowCount = pstmt.executeUpdate();

                        
                        pstmt = conn.prepareStatement(
                            "INSERT INTO Graduate(graduate_num, graduate_type, major, department) " +
                            "VALUES (?, ?, ?, ?)");
                        
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("graduate_type"));
                        pstmt.setString(3, request.getParameter("major"));
                        pstmt.setString(4, request.getParameter("department"));
                        rowCount = pstmt.executeUpdate();
                        
                        
                        pstmt = conn.prepareStatement(
                            "INSERT INTO PhDStudent(phdstudent_num, candidate_type) VALUES (?, ?)");
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("candidate_type"));
                        rowCount = pstmt.executeUpdate();
                        
                        
                        pstmt = conn.prepareStatement(
                            "INSERT INTO Precandidate(precandidate_num, advisor) VALUES (?, ?)");
                        String advisor = request.getParameter("advisor");
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, advisor.equals("") ? null : advisor);
                        rowCount = pstmt.executeUpdate();
                            
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
                        
                        // Create the prepared statement and use it to
                        // UPDATE the student attributes in the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Student SET student_num = ?, ssn = ?, first_name = ?, " +
                            "middle_name = ?, last_name = ?, residency = ?, " +
                            "student_type = ? WHERE id = ?");
        
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("ssn"));
                        pstmt.setString(3, request.getParameter("first_name"));
                        pstmt.setString(4, request.getParameter("middle_name"));
                        pstmt.setString(5, request.getParameter("last_name"));
                        pstmt.setString(6, request.getParameter("residency"));
                        pstmt.setString(7, request.getParameter("student_type"));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("sid")));

                        int rowCount = pstmt.executeUpdate();

                        pstmt = conn.prepareStatement(
                            "UPDATE Graduate SET graduate_num = ?, " +
                            "graduate_type = ?, major = ?, department = ? WHERE id = ?");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, request.getParameter("graduate_type"));
                        pstmt.setString(3, request.getParameter("major"));
                        pstmt.setString(4, request.getParameter("department"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("gid")));
                        rowCount = pstmt.executeUpdate();
                        
                        
                        pstmt = conn.prepareStatement(
                            "UPDATE Precandidate SET precandidate_num = ?, advisor = ? WHERE id = ?");
                        String advisor = request.getParameter("advisor");
                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setString(2, advisor.equals("") ? null : advisor);
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("preid")));
                        rowCount = pstmt.executeUpdate();
                        
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
                        
                        // Create the prepared statement and use it to
                        // DELETE the student FROM the Student table.
                        PreparedStatement pstmt = conn.prepareStatement(
                            "DELETE FROM Student WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("sid")));
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

                   // Use the created statement to SELECT
                   // the student attributes FROM the Student/Undergraduate tables.
                   ResultSet rs = statement.executeQuery(
                           "SELECT s.id AS sid, student_num, ssn, first_name, middle_name, last_name, " +
                           "residency, student_type, g.id AS gid, graduate_type, major, department, " +
                           "pre.id AS preid, advisor FROM Student s, Graduate g, PhDStudent phd, Precandidate pre " +
                           "WHERE student_num = graduate_num AND graduate_num = phdstudent_num " +
                           "AND phdstudent_num = precandidate_num ORDER BY student_num ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student_Num</th>
                        <th>SSN</th>
                        <th>First_Name</th>
                        <th>Middle_Name</th>
                        <th>Last_Name</th>
                        <th>Residency</th>
                        <th>Major</th>
                        <th>Department</th>
                        <th>Advisor</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="precandidate_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" value="graduate" name="student_type">
                            <input type="hidden" value="phd" name="graduate_type">
                            <input type="hidden" value="precandidate" name="candidate_type">
                            <td><input value="" name="student_num" size="15" required></td>
                            <td><input value="" name="ssn" size="10" required></td>
                            <td><input value="" name="first_name" size="15" required></td>
                            <td><input value="" name="middle_name" size="15"></td>
                            <td><input value="" name="last_name" size="15" required></td>
                            <td><select name="residency" required>
                              <option disabled selected>Residency</option>
                              <option value="ca_resident">CA Resident</option>
                              <option value="non_ca_resident">Non-CA US Resident</option>
                              <option value="foreign">Foreign</option>
                            </select></td>
                            <td><input value="" name="major" size="10" required></td>
                            <td><input value="" name="department" size="10" required></td>
                            <td><input value="" name="advisor" size="10"></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    // Iterate over the ResultSet
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="precandidate_entry_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("sid") %>" name="sid">
                            <input type="hidden" value="<%= rs.getInt("gid") %>" name="gid">
                            <input type="hidden" value="<%= rs.getInt("preid")%>" name="preid">
                            <input type="hidden" value="graduate" name="student_type">
                            <input type="hidden" value="phd" name="graduate_type">
                            <input type="hidden" value="precandidate" name="candidate_type">
                            <td>
                              <input value="<%=rs.getString("student_num")%>" name="student_num" size="15" required>
                            </td>
                            <td>
                              <input value="<%=rs.getString("ssn") %>" name="ssn" size="10" required>
                            </td>
                            <td>
                              <input value="<%=rs.getString("first_name")%>" name="first_name" size="15" required>
                            </td>
                            <td>
                              <input value="<%=rs.getString("middle_name")%>" name="middle_name" size="15">
                            </td>
                            <td>
                              <input value="<%=rs.getString("last_name")%>" name="last_name" size="15" required>
                            </td>
                            <td>
                              <select name="residency" required>
                              <%String residency = rs.getString("residency"); %>
                                <option value="ca_resident" <%=residency.equals("ca_resident") ? "selected" : ""%>>CA Resident</option>
                                <option value="non_ca_resident" <%=residency.equals("non_ca_resident") ? "selected" : ""%>>Non-CA US Resident</option>
                                <option value="foreign" <%=residency.equals("foreign") ? "selected" : ""%>>Foreign</option>
                              </select>
                            </td>
                            <td>
                              <input value="<%= rs.getString("major") %>" name="major" size="10" required>
                            </td>
                            <td>
                              <input value="<%= rs.getString("department") %>" name="department" size="10" required>
                            </td>
                            <td>
                            <% String advisor = rs.getString("advisor"); %>
                              <input value="<%= (advisor == null) ? "" : advisor %>" name="advisor" size="10">
                            </td>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="precandidate_entry_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("sid") %>" name="sid">
                            <input type="hidden" value="<%= rs.getInt("gid") %>" name="gid">
                            <input type="hidden" value="<%= rs.getInt("preid")%>" name="preid">
                            <input type="hidden" value="graduate" name="student_type">
                            <input type="hidden" value="phd" name="graduate_type">
                            <input type="hidden" value="precandidate" name="candidate_type">
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