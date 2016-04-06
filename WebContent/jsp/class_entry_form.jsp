<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/classEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Class Entry Form</h1>
    <p><b>Note:</b> A class may have <i>only one</i> corresponding course,
    but a course may have <i>many</i> corresponding classes.</p>
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
                            "INSERT INTO Class(class_title, quarter, class_year) VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("class_title"));
                        pstmt.setString(2, request.getParameter("quarter"));
                        pstmt.setString(3, request.getParameter("class_year"));
           
                        int rowCount = pstmt.executeUpdate();
                        conn.commit();

                        
                        // Enter course/class pair into ClassInstance table
                        pstmt = conn.prepareStatement(
                            "INSERT INTO ClassInstance (course_id, class_id) VALUES " +
                            "(?, (SELECT id FROM Class WHERE class_title = ? AND quarter = ? AND class_year = ?))");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("corresponding_course_id")));
                        pstmt.setString(2, request.getParameter("class_title"));
                        pstmt.setString(3, request.getParameter("quarter"));
                        pstmt.setString(4, request.getParameter("class_year"));

                        rowCount = pstmt.executeUpdate();
                        
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
                            "UPDATE Class SET class_title = ?, quarter = ?, class_year = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("class_title"));
                        pstmt.setString(2, request.getParameter("quarter"));
                        pstmt.setString(3, request.getParameter("class_year"));
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
                            "DELETE FROM Class WHERE id = ?");

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
                    		"SELECT id AS course_id, department, course_num FROM Course " +
                            //"WHERE id NOT IN (SELECT course_id FROM ClassInstance) " +
                    		"ORDER BY department, course_num ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Class_Title</th>
                        <th>Quarter</th>
                        <th>Class_Year</th>
                        <th>Corresponding_Course</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="class_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td><input value="" name="class_title" size="20" required></td>
                            <td><select name="quarter" required>
                                  <option disabled selected>Quarter</option>
                                  <option value="FALL">FALL</option>
                                  <option value="WINTER">WINTER</option>
                                  <option value="SPRING">SPRING</option>
                                  <option value="SUMMER">SUMMER</option>
                            </select></td>
                            <td><select name="class_year" required>
                                    <option disabled selected>Year</option>
                                <%
                                for (int year = 2020; year >= 1960; year--) {%>
                                    <option value=<%=year%>><%=year%></option>
                                <%
                                }
                                %>
                            </select></td>
                            <td><select name="corresponding_course_id" required>
                                <option disabled selected>Select a course</option>
                            <%
                            while (rs.next()) {
                                String dpmt = rs.getString("department");
                                String c_num = rs.getString("course_num");
                                %>
                                <option value="<%=rs.getInt("course_id")%>"><%=dpmt + " " + c_num%></option>
                                <%
                            } %>
                            </select></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                            "SELECT cl.id AS cl_id, class_title, quarter, class_year, department, course_num " +
                            "FROM Class cl LEFT OUTER JOIN ClassInstance ci ON cl.id = ci.class_id " +
                            "LEFT OUTER JOIN Course co ON ci.course_id = co.id " +
                            "ORDER BY class_year, quarter ASC");
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="class_entry_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("cl_id") %>" name="id">
                            <td>
                                <input value="<%= rs.getString("class_title") %>" 
                                    name="class_title" size="20" required>
                            </td>
                            <td><select name="quarter" required>
                            <% String quarter = rs.getString("quarter"); %>
                                  <option disabled selected>Quarter</option>
                                  <option value="FALL" <%= quarter.equals("FALL") ? "selected":"" %>>Fall</option>
                                  <option value="WINTER" <%= quarter.equals("WINTER") ? "selected":"" %>>Winter</option>
                                  <option value="SPRING" <%= quarter.equals("SPRING") ? "selected":"" %>>Spring</option>
                                  <option value="SUMMER" <%= quarter.equals("SUMMER") ? "selected":"" %>>Summer</option>
                            </select></td>
                            <td><select name="class_year" required>
                                <%
                                int class_year = Integer.parseInt(rs.getString("class_year"));
                                for (int year = 2020; year >= 1960; year--) {%>
                                    <option value=<%=year%> <%= (year == class_year) ? "selected":"" %>><%=year%></option>
                                <%
                                }
                                %>
                            </select></td>
                            <td>
                            <%
                            String value = "";
                            if (rs.getString("department") != null && rs.getString("course_num") != null) {
                                value = rs.getString("department") + " " + rs.getString("course_num");    	
                            }
                            %>
                              <input type="text" value="<%=value%>" readonly>
                              <input style="float:right" type="button" value="Edit" onclick="editCorrespondingCourse
                              (<%=rs.getInt("cl_id")%>, '<%=rs.getString("class_title")%>')">
                            </td>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="class_entry_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("cl_id") %>" name="id">
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
    <iframe style="display:none" width="600" height="300" frameBorder="0"
    id="corresponding_course_iframe" name="corresponding_course_iframe"></iframe>
</body>

</html>
