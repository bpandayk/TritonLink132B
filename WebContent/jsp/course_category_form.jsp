<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <% int deg_id = Integer.parseInt(request.getParameter("degree_id")); 
       String degree_type = request.getParameter("degree_type");
       String degree_name = request.getParameter("degree_name");
       %>

    <h1>Course Category Form</h1>
    <p>Course categories for <%=degree_type%>, <%=degree_name %></p>
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
                            "INSERT INTO CourseCategory (course_id, degree_id, category_name, required_units, min_gpa) " +
                            "VALUES (?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("course_id")));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("degree_id")));
                        pstmt.setString(3, (request.getParameter("category_name")));
                        pstmt.setInt(4, Integer.parseInt(request.getParameter("required_units")));
                        pstmt.setFloat(5, Float.parseFloat(request.getParameter("min_gpa")));
           
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
                            "UPDATE CourseCategory SET category_name = ?, " +
                            "required_units = ?, min_gpa = ? WHERE id = ?");
                        
                        pstmt.setString(1, request.getParameter("category_name"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("required_units")));
                        pstmt.setObject(3, Float.parseFloat(request.getParameter("min_gpa")), java.sql.Types.NUMERIC);
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
                            "DELETE FROM CourseCategory WHERE id = ?");

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
                            "SELECT * FROM COURSE");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course_Info</th>
                        <th>Category_Name</th>
                        <th>Required_Units</th>
                        <th>Min_GPA</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="course_category_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" value="<%=deg_id%>" name="degree_id">
                            <input type="hidden" value="<%= degree_type%>" name="degree_type">
                            <input type="hidden" value="<%= degree_name%>" name="degree_name">
                            <td><select name="course_id">
                            <%while (rs.next()) { 
                              String dpmt = rs.getString("department");
                              String cnum = rs.getString("course_num");
                              %>
                              <option value="<%=rs.getInt("id")%>"><%=dpmt + " " + cnum %></option>
                            <%
                            }%>
                            </select></td>
                            <td><input value="" name="category_name" size="15" required></td>
                            <td><input value="" name="required_units" size="10" required></td>
                            <td><input value="" name="min_gpa" size="10" required></td>                  
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                    		"SELECT c.id AS ccid, co.id AS coid, c.required_units AS req_units, min_gpa, " +
                            "category_name, co.department AS dpmt, co.course_num AS cnum " +
                    		"FROM CourseCategory c, Degree d, Course co " +
                            "WHERE c.degree_id=d.id AND c.course_id = co.id AND " +
                    		"c.degree_id = " + deg_id + " ORDER BY category_name, co.department, co.course_num ASC");
                    
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="course_category_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("ccid") %>" name="id">
                            <input type="hidden" value="<%=deg_id%>" name="degree_id">
                            <input type="hidden" value="<%= degree_type%>" name="degree_type">
                            <input type="hidden" value="<%= degree_name%>" name="degree_name">
                            <input type="hidden" value="<%=rs.getInt("coid")%>" name="course_id">
                            <td><%=rs.getString("dpmt") + " " + rs.getString("cnum")%></td>
                            <td>
                                <input value="<%= rs.getString("category_name") %>"
                                    name="category_name" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getInt("req_units") %>" 
                                    name="required_units" size="10" required>
                            </td>
                            <td>
                                <input value="<%= rs.getFloat("min_gpa") %>" 
                                    name="min_gpa" size="10" required>
                            </td>
                            <td>
                                <input type="submit" value="Update">
                            </td>                
                        </form>
                        <form action="course_category_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%= rs.getInt("ccid") %>" name="id">
                            <input type="hidden" value="<%= deg_id %>" name="degree_id">
                            <input type="hidden" value="<%= degree_type%>" name="degree_type">
                            <input type="hidden" value="<%= degree_name%>" name="degree_name">
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
