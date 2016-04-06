<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/courseEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Course Entry Form</h1>
    <div style="height:300px;overflow:auto;">
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
                            "INSERT INTO Course(department, course_num, min_units, max_units, " +
                            "grade_option, requires_lab, requires_consent) VALUES (?, ?, ?, ?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("department"));
                        pstmt.setString(2, request.getParameter("course_num"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("min_units")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("max_units")));
                        pstmt.setString(5, request.getParameter("grade_option"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("requires_lab")));
                        pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("requires_consent")));
           
                        int rowCount = pstmt.executeUpdate();
                        conn.commit();

                        
                        // Enter course prerequisites into Prerequisite table
                        String[] prereqs = request.getParameterValues("prerequisites_id");
                        if(prereqs != null) {
                        	String department = request.getParameter("department");
                        	String course_num = request.getParameter("course_num");

	                        pstmt = conn.prepareStatement(
	                            "INSERT INTO Prerequisite (target_id, prerequisite_id) VALUES " +
	                            "((SELECT id FROM Course WHERE department=? AND course_num=?), ?)");
	                        for(String p : prereqs) {
		                        pstmt.setString(1, request.getParameter("department"));
		                        pstmt.setString(2, request.getParameter("course_num"));
		                        pstmt.setInt(3, Integer.parseInt(p));
		                        
		                        rowCount = pstmt.executeUpdate();
	                        }
	                        
	                        conn.commit();
                        }

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
                            "UPDATE Course SET course_num = ?, department = ?, " +
                            "min_units = ?, max_units = ?, grade_option = ?, " +
                            "requires_lab = ?, requires_consent = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("course_num"));
                        pstmt.setString(2, request.getParameter("department"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("min_units")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("max_units")));
                        pstmt.setString(5, request.getParameter("grade_option"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("requires_lab")));
                        pstmt.setBoolean(7, Boolean.parseBoolean(request.getParameter("requires_consent")));
                        pstmt.setInt(8, Integer.parseInt(request.getParameter("id")));

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
                            "DELETE FROM Course WHERE id = ?");

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
                            "SELECT * FROM Course ORDER BY department, course_num ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Department</th>
                        <th>Course_Num</th>
                        <th>Min_Units</th>
                        <th>Max_Units</th>
                        <th>Grade_Option</th>
                        <th>Lab</th>
                        <th>Consent</th>
                        <th>Prereqs</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="course_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td><input value="" name="department" size="15" required></td>
                            <td><input value="" name="course_num" size="15" required></td>
                            <td><input value="" name="min_units" size="10" required></td>
                            <td><input value="" name="max_units" size="10" required></td>
                            <td><select name="grade_option" required>
                              <option disabled selected>Grade Option</option>
                              <option value="LETTER">LETTER ONLY</option>
                              <option value="S/U">S/U ONLY</option>
                              <option value="BOTH">BOTH</option>
                            </select></td>
                            <td><select name="requires_lab">
                              <option value="false" selected>false</option>
                              <option value="true">true</option>
                            </select></td>
                            <td><select name="requires_consent">
                              <option value="false" selected>false</option>
                              <option value="true">true</option>
                            </select></td>
                            <td><select multiple name="prerequisites_id">
                                <option disabled>Select course(s)</option>
                            <%
                            while (rs.next()) {
                                String dpmt = rs.getString("department");
                                String c_num = rs.getString("course_num");
                                %>
                                <option value="<%=rs.getInt("id")%>"><%=dpmt + " " + c_num%></option>
                                <%
                            } %>
                            </select></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
		            rs = statement.executeQuery("SELECT * FROM Course ORDER BY department, course_num ASC");
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="course_entry_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <td>
                                <input value="<%= rs.getString("department") %>" 
                                    name="department" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getString("course_num") %>" 
                                    name="course_num" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getInt("min_units") %>"
                                    name="min_units" size="10" required>
                            </td>
                            <td>
                                <input value="<%= rs.getInt("max_units") %>" 
                                    name="max_units" size="10" required>
                            </td>
                            <td><select name="grade_option" required>
                            <% String grade_option = rs.getString("grade_option"); %>
                              <option value="LETTER" <%=(grade_option.equals("LETTER")) ? "selected":""%>>LETTER ONLY</option>
                              <option value="S/U" <%=(grade_option.equals("S/U")) ? "selected":""%>>S/U ONLY</option>
                              <option value="BOTH" <%=(grade_option.equals("BOTH")) ? "selected":""%>>BOTH</option>
                            </select></td>
                            <td><select name="requires_lab">
                            <% boolean lab = rs.getBoolean("requires_lab"); %>
                              <option value="false" <%=(lab == false) ? "selected":""%>>false</option>
                              <option value="true" <%=(lab == true) ? "selected":""%>>true</option>
                            </select></td>
                            <td><select name="requires_consent">
                            <% boolean consent = rs.getBoolean("requires_consent"); %>
                              <option value="false" <%=(consent == false) ? "selected":""%>>false</option>
                              <option value="true" <%=(consent == true) ? "selected":""%>>true</option>
                            </select></td>
                            <td>
                            <input type="button" value="View/Edit" onclick="editPrereqs
                            (<%=rs.getInt("id")%>, '<%=rs.getString("department")%>', '<%=rs.getString("course_num")%>');">
                            </td>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="course_entry_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <%-- Button --%>
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
    <hr>
    <iframe style="display:none;" width="400" height="300" frameBorder="0" id="prereq_iframe" name="prereq_iframe"></iframe>
</body>

</html>
