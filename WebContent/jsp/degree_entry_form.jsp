<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/courseCategoryForm.js"></script>
    <script type="text/javascript" src="../js/courseConcentrationForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Degree Entry Form</h1>
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
                            "INSERT INTO Degree(degree_name, degree_type, required_units) VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("degree_name"));
                        pstmt.setString(2, request.getParameter("degree_type"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("required_units")));
           
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
                            "UPDATE Degree SET degree_name = ?, degree_type = ?, " +
                            "required_units = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("degree_name"));
                        pstmt.setString(2, request.getParameter("degree_type"));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("required_units")));
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
                            "DELETE FROM Degree WHERE id = ?");

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

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Degree_Type</th>
                        <th>Degree_Name</th>
                        <th>Required_Units</th>             
                        <th colspan="2">Action</th>
                        <th>Course_Category</th>
                        <th>Course_Concentration</th>
                    </tr>
                    <tr>
                        <form action="degree_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td><input value="" name="degree_type" size="15" required></td>
                            <td><input value="" name="degree_name" size="15" required></td>
                            <td><input value="" name="required_units" size="10" required></td>                                       
                            <td colspan="2"><input type="submit" value="Insert"></td>
                            <td colspan="2"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    ResultSet rs = statement.executeQuery(
                            "SELECT * FROM Degree ORDER BY degree_type, degree_name ASC");
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="degree_entry_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <td>
                                <input value="<%= rs.getString("degree_type") %>" 
                                    name="degree_type" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getString("degree_name") %>" 
                                    name="degree_name" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getInt("required_units") %>"
                                    name="required_units" size="15" required>
                            </td>
        
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="degree_entry_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <%-- Button --%>
                            <td>
                                <input type="submit" value="Delete">
                            </td>
                        </form>
                        
                        <td>
                            <input type="button" value="Course_Category"
                                onclick="editCourseCategory(<%=rs.getInt("id")%>, '<%=rs.getString("degree_type")%>',
                                                           '<%=rs.getString("degree_name")%>');">
                        </td>                   
                        <td>
                            <input type="button" value="Course_Concentration"
                                onclick="editCourseConcentration(<%=rs.getInt("id")%>, '<%=rs.getString("degree_type")%>',
                                                                '<%=rs.getString("degree_name")%>');">
                        </td>
                      
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
    <iframe style="display:none;" width="800" height="300" frameBorder="0"
            id="edit_course_category_iframe" name="edit_course_category_iframe"></iframe>
    <iframe style="display:none;" width="800" height="300" frameBorder="0"
            id="edit_course_concentration_iframe" name="edit_course_concentration_iframe"></iframe>
    
</body>

</html>
