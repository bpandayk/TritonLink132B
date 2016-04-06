<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

<%
String graduate_num = request.getParameter("graduate_num");
String graduate_type = request.getParameter("graduate_type");
%>
<h2>Thesis Committee for graduate "<%=graduate_num%>"</h2>

<div style="height:300px;overflow:auto;">
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
                            "INSERT INTO ThesisCommittee(graduate_num, faculty_name) VALUES (?, ?)");
                        pstmt.setString(1, request.getParameter("graduate_num"));
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
                            "DELETE FROM ThesisCommittee WHERE id = ?");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("tcid")));
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
                        "SELECT COUNT(id) AS committee_size FROM ThesisCommittee " +
                        "WHERE graduate_num = '" + graduate_num + "'");
                    rs.next();
                    int committee_size = rs.getInt("committee_size");
            %>
            <p>This student has a thesis committee size of <b><%=committee_size%></b>.</p>
            <%
            rs.close();
            
            rs = statement.executeQuery(
                "SELECT COUNT(tc.id) AS department_committee_size FROM ThesisCommittee tc " +
                "JOIN Graduate g ON g.graduate_num = tc.graduate_num " + 
                "JOIN Faculty f ON f.faculty_name = tc.faculty_name " +
                "WHERE g.graduate_num = '" + graduate_num + "' AND " +
                "g.department = f.department");
            rs.next();
            int department_committee_size = rs.getInt("department_committee_size");
            %>
            <p><b><%=department_committee_size%></b> of the committee members are in the same department.<br>
            <b><%=committee_size - department_committee_size%></b> of the
            committee members are not in the same department.</p>
            <%
            
            rs.close();
            rs = statement.executeQuery(
                "SELECT faculty_name, department FROM Faculty WHERE faculty_name NOT IN " +
                "(SELECT faculty_name FROM ThesisCommittee WHERE graduate_num = '" + graduate_num + "' ) " +
                "ORDER BY department ASC");
            
            %>
      <table border="1">
        <tr>
            <td>
            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Faculty_Name</th>
                        <th>Faculty_Department</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <form action="edit_thesis_committee_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="graduate_num" value="<%=graduate_num%>">
                            <td colspan="2"><select name="faculty_name" required>
                            <%
                            if(!rs.isBeforeFirst()) {
                            %>
                                <option selected disabled>No faculty available</option>
                            <%
                            } else {
                                while(rs.next()) {
                            	    %>
                            	    <option value="<%=rs.getString("faculty_name")%>">
                            	      <%=rs.getString("faculty_name") + " --- Department: " + rs.getString("department")%></option>
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
                            "SELECT tc.id AS tcid, f.faculty_name AS fac_name, department " +
                            "FROM ThesisCommittee tc JOIN Faculty f ON tc.faculty_name = f.faculty_name " +
                            "WHERE graduate_num = '" + graduate_num + "' " +
                            "ORDER BY department ASC");
            
                    while ( rs.next() ) {
            %>
                    <tr>
                        <td><input name="faculty_name" value="<%=rs.getString("fac_name")%>" readonly></td>
                        <td><input name="department" value="<%=rs.getString("department")%>" readonly></td>
                        <form action="edit_thesis_committee_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="graduate_num" value="<%=graduate_num%>">
                            <input type="hidden" name="tcid" value="<%=rs.getInt("tcid")%>">
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