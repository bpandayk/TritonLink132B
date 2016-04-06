<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <h1>Nonweekly Meeting Entry Form</h1>
    <div style="height:900px;overflow:auto;">
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
                            "INSERT INTO NonweeklyMeeting(section_id, meeting_type, start_datetime, " +
                            "end_datetime, location, required) " +
                            "VALUES (?, ?, ?, ?, ?, ?)");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setString(2, request.getParameter("meeting_type"));
                        pstmt.setTimestamp(3, java.sql.Timestamp.valueOf(request.getParameter("start_datetime")));
                        pstmt.setTimestamp(4, java.sql.Timestamp.valueOf(request.getParameter("end_datetime")));
                        pstmt.setString(5, request.getParameter("location"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("required")));
           
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
                            "UPDATE NonweeklyMeeting SET section_id = ?, meeting_type = ?, start_datetime = ?, " +
                            "end_datetime = ?, location = ?, required = ? WHERE id = ?");
                        
                        pstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setString(2, request.getParameter("meeting_type"));
                        pstmt.setTimestamp(3, java.sql.Timestamp.valueOf(request.getParameter("start_datetime")));
                        pstmt.setTimestamp(4, java.sql.Timestamp.valueOf(request.getParameter("end_datetime")));
                        pstmt.setString(5, request.getParameter("location"));
                        pstmt.setBoolean(6, Boolean.parseBoolean(request.getParameter("required")));
                        pstmt.setInt(7, Integer.parseInt(request.getParameter("id")));

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
                            "DELETE FROM NonweeklyMeeting WHERE id = ?");

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
                            "SELECT * FROM Section ORDER BY section_num ASC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Section_Num</th>
                        <th>Meeting_Type</th>
                        <th>Start_DateTime</th>
                        <th>End_DateTime</th>
                        <th>Location</th>
                        <th>Required</th>             
                        <th colspan="2">Action</th>
                    </tr>
                    <tr>
                        <form action="nonweekly_meeting_entry_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <td>
                              <select name="section_id" required>
                              <option disabled selected>Select section</option>
                              <%
                              while(rs.next()) {
                                  %>
                                  <option value="<%=rs.getInt("id")%>"><%=rs.getString("section_num")%></option>
                                  <%
                              }
                              %>
                              </select>
                            </td>
                            <td><select name="meeting_type" required>
                              <option disabled selected>Meeting Type</option>
                              <option value="REVIEW">REVIEW</option>
                              <option value="FINAL">FINAL</option>
                            </select></td> 
                            <td><input value="" name="start_datetime" placeholder="yyyy-mm-dd hh-mm-ss" size="15" required></td>
                            <td><input value="" name="end_datetime" placeholder="yyyy-mm-dd hh-mm-ss" size="15" required></td>
                            <td><input value="" name="location" size="15" required></td> 
                            <td><select name="required" required>
                              <option disabled selected>Required</option>
                              <option value="TRUE">TRUE</option>
                              <option value="FALSE">FALSE</option>
                            </select></td>                             
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                            "SELECT * FROM NonweeklyMeeting " +
                            "ORDER BY section_id, meeting_type, start_datetime, end_datetime ASC");
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="nonweekly_meeting_entry_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" value="<%= rs.getInt("id") %>" name="id">
                            <td>
                                <input value="<%= rs.getString("section_id") %>" 
                                    name="section_id" size="15" required>
                            </td>
                            <td>
                            <%
                            String meeting_type = rs.getString("meeting_type");
                            %>
                              <select name="meeting_type" required>
                                <option value="REVIEW" <%=meeting_type.equals("REVIEW") ? "selected" : "" %>>REVIEW</option>
                                <option value="FINAL" <%=meeting_type.equals("FINAL") ? "selected" : "" %>>FINAL</option>
                              </select>
                            </td>
                            <td>
                                <input value="<%= rs.getString("start_datetime") %>" 
                                    name="start_datetime" placeholder="yyyy-mm-dd hh-mm-ss" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getString("end_datetime") %>" 
                                    name="end_datetime" placeholder="yyyy-mm-dd hh-mm-ss" size="15" required>
                            </td>
                            <td>
                                <input value="<%= rs.getString("location") %>"
                                    name="location" size="15" required>
                            </td>
                            <td><select name="required" required>
                              <% 
                              boolean required = rs.getBoolean("required");
                              %>
                              <option value="TRUE" <%=(required == true) ? "selected" : "" %>>TRUE</option>
                              <option value="FALSE" <%=(required == false) ? "selected" : "" %>>FALSE</option>
                            </select></td>  
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>

                        <form action="nonweekly_meeting_entry_form.jsp" method="post">
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
    
</body>

</html>
