<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
<%
String student_num = request.getParameter("student_num");
%>
    <h3>Past Classes Taken by Student_Num "<%=student_num%>"</h3>
    <div style="height:300px;overflow:auto;">
    <table>
        <tr>
            <%-- Set the scripting language to Java and --%>
            <%-- Import the java.sql package --%>
            <%@ page language="java" import="java.sql.*" %>
    
            <td>
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

            <%-- -------- DELETE Code -------- --%>
            <%
                    String action = request.getParameter("action");
                    // Check if a delete is requested
                    if (action != null && action.equals("update")) {

                        // Begin transaction
                        conn.setAutoCommit(false);
                        
                        PreparedStatement pstmt = conn.prepareStatement(
                            "UPDATE ClassesTaken SET grade_received = ? WHERE id = ?");

                        pstmt.setString(1, request.getParameter("grade_received"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("ct_id")));
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
                            "DELETE FROM ClassesTaken WHERE id = ?");

                        pstmt.setInt(1, Integer.parseInt(request.getParameter("ct_id")));
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
                        "SELECT ct.id AS ct_id, department, course_num, class_title, quarter, class_year, " +
                        "se.grade_option AS grade_opt, section_num, grade_received FROM ClassesTaken ct " +
                        "JOIN SectionEnrollment se ON ct.sectionenrollment_id = se.id " +
                        "JOIN Section s ON se.section_id = s.id " +
                        "JOIN Class cl ON s.class_id = cl.id " +
                        "JOIN ClassInstance ci ON cl.id = ci.class_id " +
                        "JOIN Course co ON ci.course_id = co.id " +
                        "WHERE se.student_num = '" + student_num + "' " +
                        "ORDER BY class_year, quarter, department, course_num DESC");
            %>

            <!-- Add an HTML table header row to format the results -->
                <table border="1">
                    <tr>
                        <th>Course_Department</th>
                        <th>Course_Num</th>
                        <th>Class_Title</th>
                        <th>Quarter</th>
                        <th>Class_Year</th>
                        <th>Section_Num</th>
                        <th>Grade_Received</th>
                        <th colspan="2">Action</th>
                    </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                    while ( rs.next() ) {
            %>
                    <tr>
                        <form action="edit_past_classes_taken_form.jsp" method="post">
                          <input type="hidden" value="update" name="action">
                          <input type="hidden" value="<%=student_num%>" name="student_num">
                          <input type="hidden" value="<%=rs.getInt("ct_id")%>" name="ct_id">
                          <td><input type="text" value="<%= rs.getString("department")%>" size="15" readonly></td>
                          <td><input type="text" value="<%= rs.getString("course_num")%>" size="15" readonly></td>
                          <td><input type="text" value="<%= rs.getString("class_title")%>" size="20" readonly></td>
                          <td><input type="text" value="<%= rs.getString("quarter")%>" size="10" readonly></td>
                          <td><input type="text" value="<%= rs.getString("class_year")%>" size="10" readonly></td>
                          <td><input type="text" value="<%= rs.getString("section_num")%>" size="15" readonly></td>
                            <td><select name="grade_received" required>
                              <option selected disabled>Grade received</option>
                              <%
                              String grade_option = rs.getString("grade_opt");
                              String grade_received = rs.getString("grade_received");
                              if(grade_option.equals("LETTER")) {
                                  %>
                                  <option value="A+" <%=(grade_received.equals("A+") ? "selected" : "") %>>A+</option>
                                  <option value="A" <%=(grade_received.equals("A") ? "selected" : "") %>>A</option>
                                  <option value="A-" <%=(grade_received.equals("A-") ? "selected" : "") %>>A-</option>
                                  <option value="B+" <%=(grade_received.equals("B+") ? "selected" : "") %>>B+</option>
                                  <option value="B" <%=(grade_received.equals("B") ? "selected" : "") %>>B</option>
                                  <option value="B-" <%=(grade_received.equals("B-") ? "selected" : "") %>>B-</option>
                                  <option value="C+" <%=(grade_received.equals("C+") ? "selected" : "") %>>C+</option>
                                  <option value="C" <%=(grade_received.equals("C") ? "selected" : "") %>>C</option>
                                  <option value="C-" <%=(grade_received.equals("C-") ? "selected" : "") %>>C-</option>
                                  <option value="D" <%=(grade_received.equals("D") ? "selected" : "") %>>D</option>
                                  <option value="F" <%=(grade_received.equals("F") ? "selected" : "") %>>F</option>
                                  <%
                              }
                              else if(grade_option.equals("S/U")) {
                                  %>
                                  <option value="S" <%=(grade_received.equals("S") ? "selected" : "") %>>S</option>
                                  <option value="U" <%=(grade_received.equals("U") ? "selected" : "") %>>U</option>
                                  <%
                              }
                              %>
                              <option value="IN" <%=(grade_received.equals("IN") ? "selected" : "")%>>INCOMPLETE</option>
                            </select></td>
                          <td><input type="submit" value="Update"></td>
                        </form>
                        <form action="edit_past_classes_taken_form.jsp" method="post">
                            <input type="hidden" value="delete" name="action">
                            <input type="hidden" value="<%=student_num%>" name="student_num">
                            <input type="hidden" value="<%=rs.getInt("ct_id")%>" name="ct_id">
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
        </tr>
    </table>
    </div>
</body>

</html>