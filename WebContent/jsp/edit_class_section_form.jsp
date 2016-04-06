<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>

<%
int class_id = Integer.parseInt(request.getParameter("class_id"));
String class_title = request.getParameter("class_title");
String quarter = request.getParameter("quarter");
String class_year = request.getParameter("class_year");
%>
<h2>Sections for class "<%=class_title%>", <%=quarter%> <%=class_year%></h2>

<p><b>Note</b>: Make sure to reload the section entry form to reflect any changes to the section totals.</p>
<div style="height:300px;overflow:auto;">
    <table border="1">
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
                            "INSERT INTO Section(section_num, class_id, section_limit) VALUES (?, ?, ?)");
                        pstmt.setString(1, request.getParameter("section_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("class_id")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("section_limit")));
           
                        int rowCount = pstmt.executeUpdate();
                        // Commit transaction
                        conn.commit();
                        conn.setAutoCommit(true);
                    }
            %>

            <%-- -------- UPDATE Code -------- --%>
            <%
                    // Check if a delete is requested
                    if (action != null && action.equals("update")) {
                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE Section SET section_num = ?, section_limit = ? WHERE id = ?");
                        pstmt.setString(1, request.getParameter("section_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("section_limit")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("section_id")));
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
                            "DELETE FROM Section WHERE id = ?");
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
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
                    ResultSet rs;
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Section_Num</th>
                        <th>Section_Limit</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="edit_class_section_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="class_id" value="<%=class_id%>">
                            <input type="hidden" name="class_title" value="<%=class_title%>">
                            <input type="hidden" name="quarter" value="<%=quarter%>">
                            <input type="hidden" name="class_year" value="<%=class_year%>">
                            <td><input value="" name="section_num" size="20" required></td>
                            <td><input value="" name="section_limit" size="15" required></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs = statement.executeQuery(
                        "SELECT id AS section_id, section_num, section_limit " +
                        "FROM Section WHERE class_id = " + class_id + " ORDER BY section_num ASC");
            
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_class_section_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" name="class_id" value="<%=class_id%>">
                            <input type="hidden" name="class_title" value="<%=class_title%>">
                            <input type="hidden" name="quarter" value="<%=quarter%>">
                            <input type="hidden" name="class_year" value="<%=class_year%>">
                            <input type="hidden" name="section_id" value="<%=rs.getInt("section_id")%>">
                            <td><input type="text" name="section_num" value="<%= rs.getString("section_num")%>" size="20"></td>
                            <td><input type="text" name="section_limit" value="<%= rs.getString("section_limit")%>" size="15"></td>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="edit_class_section_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="class_id" value="<%=class_id%>">
                            <input type="hidden" name="class_title" value="<%=class_title%>">
                            <input type="hidden" name="quarter" value="<%=quarter%>">
                            <input type="hidden" name="class_year" value="<%=class_year%>">
                            <input type="hidden" name="section_id" value="<%=rs.getInt("section_id")%>">
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