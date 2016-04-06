<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
<%
int section_id = Integer.parseInt(request.getParameter("section_id"));
String section_num = request.getParameter("section_num");
int min_units = Integer.parseInt(request.getParameter("min_units"));
int max_units = Integer.parseInt(request.getParameter("max_units"));
int section_limit = Integer.parseInt(request.getParameter("section_limit"));
String grade_option = request.getParameter("grade_option");
%>
<h2>Enrollment for section_num "<%=section_num%>"</h2>

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
                            "INSERT INTO SectionEnrollment(student_num, section_id, " +
                            "units_taking, grade_option) VALUES (?, ?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("units_taking")));
                        pstmt.setString(4, request.getParameter("grade_option_selected"));
           
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
                            "UPDATE SectionEnrollment SET student_num = ?, section_id = ?, " +
                            "units_taking = ?, grade_option = ? WHERE id = ?");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("units_taking")));
                        pstmt.setString(4, request.getParameter("grade_option_selected"));
                        pstmt.setInt(5, Integer.parseInt(request.getParameter("seid")));
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
                            "DELETE FROM SectionEnrollment WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("seid")));
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
                        "SELECT COUNT(id) AS current_section_size " +
                        "FROM SectionEnrollment WHERE section_id = " + section_id);

            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Student_Num</th>
                        <th>Grade_Option</th>
                        <th>Units_Attempting</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <%
                    rs.next();
                    //if (rs.getInt("current_section_size") < section_limit) {
                    	//-- removed for ms4, use triggers instead
                        rs.close();
                        rs = statement.executeQuery("SELECT * FROM Student WHERE student_num NOT IN " +
                            "(SELECT student_num FROM SectionEnrollment WHERE section_id = " + section_id + ")");
                    %>
                    <tr>
                        <form action="edit_class_enrollment_form.jsp" method="post">
                            <input type="hidden" value="insert" name="action">
                            <input type="hidden" name="section_id" value="<%=section_id%>">
                            <input type="hidden" name="section_num" value="<%=section_num%>">
                            <input type="hidden" name="grade_option" value="<%=grade_option%>">
                            <input type="hidden" name="min_units" value="<%=min_units%>">
                            <input type="hidden" name="max_units" value="<%=max_units%>">
                            <input type="hidden" name="section_limit" value="<%=section_limit%>">
                            <td><select name="student_num" required>
                            <%
                            if (!rs.isBeforeFirst()) { %>
                              <option disabled selected>No students available</option>
                            <%
                            } else {
                            	%>
                            	<option disabled selected>Select student</option>
                            	<%
                            	while( rs.next() ) {
                                  %>
                                  <option value="<%=rs.getString("student_num")%>"><%=rs.getString("student_num")%></option>
                                  <%
                                }
                            }
                            %>
                            </select></td>
                            <td><select name="grade_option_selected" required>
                              <option selected disabled>Grade option</option>
                              <%
                              if(grade_option.equals("LETTER") || grade_option.equals("BOTH")) {
                            	  %>
                            	  <option value="LETTER">LETTER</option>
                            	  <%
                              }
                              if(grade_option.equals("S/U") || grade_option.equals("BOTH")) {
                            	  %>
                                  <option value="S/U">S/U</option>
                                  <%
                              }
                              %>
                            </select></td>
                            <td><select name="units_taking" required>
                              <option selected disabled>Units</option>
                              <%
                              for(int i = min_units; i <= max_units; i++) {
                            	  %>
                            	  <option value="<%=i%>"><%=i%></option>
                            	  <%
                              }
                              %>
                            </select></td>
                            <td colspan="2"><input type="submit" value="Insert"></td>
                        </form>
                    </tr>
                    <%
                    //}  // END IF section_limit check -- removed for ms4, use triggers instead
                    %>

            <%-- -------- Iteration Code -------- --%>
            <%
                    rs.close();
                    rs = statement.executeQuery(
                        "SELECT * FROM SectionEnrollment WHERE section_id = " + section_id + " " +
                        "ORDER BY student_num ASC");
            
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_class_enrollment_form.jsp" method="post">
                            <input type="hidden" value="update" name="action">
                            <input type="hidden" name="seid" value="<%=rs.getInt("id")%>">
                            <input type="hidden" name="section_id" value="<%=section_id%>">
                            <input type="hidden" name="section_num" value="<%=section_num%>">
                            <input type="hidden" name="grade_option" value="<%=grade_option%>">
                            <input type="hidden" name="min_units" value="<%=min_units%>">
                            <input type="hidden" name="max_units" value="<%=max_units%>">
                            <input type="hidden" name="section_limit" value="<%=section_limit%>">
                            <td><input name="student_num" value="<%=rs.getString("student_num")%>" size="20" readonly></td>
                            <td><select name="grade_option_selected" required>
                              <%
                              if(grade_option.equals("LETTER") || grade_option.equals("BOTH")) {
                                  %>
                                  <option value="LETTER"
                                    <%=(rs.getString("grade_option").equals("LETTER") ? "selected" : "")%>>LETTER</option>
                                  <%
                              }
                              if(grade_option.equals("S/U") || grade_option.equals("BOTH")) {
                                  %>
                                  <option value="S/U"
                                    <%=(rs.getString("grade_option").equals("S/U") ? "selected" : "")%>>S/U</option>
                                  <%
                              }
                              %>
                            </select></td>
                            <td><select name="units_taking" required>
                              <%
                              for(int i = min_units; i <= max_units; i++) {
                                  %>
                                  <option value="<%=i%>"
                                    <%=(rs.getInt("units_taking") == i ? "selected" : "")%>><%=i%></option>
                                  <%
                              }
                              %>
                            </select></td>
                            <td>
                                <input type="submit" value="Update">
                            </td>
                        </form>
                        <form action="edit_class_enrollment_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" name="seid" value="<%=rs.getInt("id")%>">
                            <input type="hidden" name="section_id" value="<%=section_id%>">
                            <input type="hidden" name="section_num" value="<%=section_num%>">
                            <input type="hidden" name="grade_option" value="<%=grade_option%>">
                            <input type="hidden" name="min_units" value="<%=min_units%>">
                            <input type="hidden" name="max_units" value="<%=max_units%>">
                            <input type="hidden" name="section_limit" value="<%=section_limit%>">
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