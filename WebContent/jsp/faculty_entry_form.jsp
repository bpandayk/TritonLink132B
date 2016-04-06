<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/facultyEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Past Classes Taken Form</h1>
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
                            "INSERT INTO Faculty (faculty_name, title, department) " +
                            "VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("faculty_name"));
                        pstmt.setString(2, request.getParameter("title"));
                        pstmt.setString(3, request.getParameter("department"));
           
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
                            "UPDATE Faculty SET faculty_name = ?, title = ?, " +
                            "department = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("faculty_name"));
                        pstmt.setString(2, request.getParameter("title"));
                        pstmt.setString(3, request.getParameter("department"));
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
                            "DELETE FROM Faculty WHERE id = ?");

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
                        "SELECT * FROM Faculty ORDER BY faculty_name ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Faculty_Name</th>
                        <th>Title</th>
                        <th>Department</th>
                        <th>Currently Teaching</th>
                        <th>Teaching History</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="faculty_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td><input value="" name="faculty_name" size="20" required></td>
                            <td><input value="" name="title" size="20" required></td>
                            <td><input value="" name="department" size="15" required></td>
                            <td></td>
                            <td></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    while ( rs.next() ) {
            %>
            
                    <tr>
                        <form action="faculty_entry_form.jsp" method="post">
                          <input type="hidden" value="update" name="action">
                          <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                          <td><input name="faculty_name" value="<%= rs.getString("faculty_name")%>" size="20" required></td>
                          <td><input name="title" value="<%= rs.getString("title")%>" size="20" required></td>
                          <td><input name="department" value="<%= rs.getString("department")%>" size="15" required></td>
                          <td>
                            <input type="button" value="View/Edit" onclick="viewCurrentlyTeaching('<%=rs.getString("faculty_name")%>');">
                          </td>
                          <td>
                            <input type="button" value="View/Edit" onclick="viewTeachingHistory('<%=rs.getString("faculty_name")%>');">
                          </td>
                          <td>
                            <input type="submit" value="Update">
                          </td>
                        </form>

                        <form action="faculty_entry_form.jsp" method="post">
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
    </div>
    <hr>
    <iframe style="display:none;" width="900" height="300" frameBorder="0"
            id="currently_teaching_iframe" name="currently_teaching_iframe"></iframe>
    <iframe style="display:none;" width="900" height="300" frameBorder="0"
            id="teaching_history_iframe" name="teaching_history_iframe"></iframe>
</body>

</html>
