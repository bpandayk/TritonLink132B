<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>
<body>
<%
String student_num = request.getParameter("student_num");
/* Joy of no AJAX
   Step 0 = select course + class quarter
   Step 1 = select section + add a grade
   Step 2 = Successfully added past class
*/
int step = 0;
if (request.getParameter("se_id") != null) {
	step = 1;
}

%>
    <h3>Add Past Classes for Student_Num "<%=student_num%>"</h3>
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
                            "INSERT INTO ClassesTaken (student_num, sectionenrollment_id, grade_received) " +
                            "VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("se_id")));
                        pstmt.setString(3, request.getParameter("grade_received"));
           
                        int rowCount = pstmt.executeUpdate();
                        conn.commit();
                        conn.setAutoCommit(true);
                    }

                // Create the statement
                Statement statement = conn.createStatement();
                ResultSet rs = null;
            
            %>

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                if (step == 0) {
                	%>
                	<p><b>Note:</b> Only classes in which the student is currently enrolled are shown.
                	Classes that have been added to the student's past classes are <b>not</b> shown.</p>
                	<%
                    rs = statement.executeQuery(
                            "SELECT se.id AS se_id, department, course_num, class_title, quarter, class_year, " +
                            "section_num, se.grade_option AS grade_opt FROM SectionEnrollment se " +
                            "JOIN Section s ON se.section_id = s.id " +
                            "JOIN Class cl ON s.class_id = cl.id " +
                            "JOIN ClassInstance ci ON cl.id = ci.class_id " +
                            "JOIN Course co ON ci.course_id = co.id " +
                            "WHERE se.student_num = '" + student_num + "' " +
                            "AND se.id NOT IN " +
                            "(SELECT sectionenrollment_id FROM ClassesTaken WHERE student_num = '" + student_num + "') " +
                            "ORDER BY class_year, quarter, department, course_num DESC");
                    
                    if(!rs.isBeforeFirst()) {
                        %>
                        <p>There are currently no classes to add.</p>
                        <%
                    } else {
                    	%>
                    	<table border="1">
                          <tr>
                            <th>Department</th>
                            <th>Course_Num</th>
                            <th>Class_Title</th>
                            <th>Quarter</th>
                            <th>Class_Year</th>
                            <th>Section_Num</th>
                            <th>Grade_Option</th>
                            <th>Grade_Received</th>
                            <th>Action</th>
                          </tr>
                    	<%
                        while (rs.next()) {
                        %>
                        <tr>
                          <form action="add_past_classes_taken_form.jsp" method="POST">
                            <input type="hidden" name="action" value="insert">
                            <input type="hidden" name="student_num" value="<%=student_num%>">
                            <input type="hidden" name="se_id" value="<%=rs.getInt("se_id")%>">
                            <td><input name="department" value="<%=rs.getString("department")%>" readonly></td>
                            <td><input name="course_num" value="<%=rs.getString("course_num")%>" readonly></td>
                            <td><input name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                            <td><input name="quarter" value="<%=rs.getString("quarter")%>" readonly></td>
                            <td><input name="class_year" value="<%=rs.getString("class_year")%>" readonly></td>
                            <td><input name="section_num" value="<%=rs.getString("section_num")%>" readonly></td>
                            <td><input name="grade_option" value="<%=rs.getString("grade_opt")%>" readonly></td>
                            <td><select name="grade_received" required>
                              <option selected disabled>Grade received</option>
                              <%
                              String grade_option = rs.getString("grade_opt");
                              if(grade_option.equals("LETTER")) {
                                  %>
                                  <option value="A+">A+</option>
                                  <option value="A">A</option>
                                  <option value="A-">A-</option>
                                  <option value="B+">B+</option>
                                  <option value="B">B</option>
                                  <option value="B-">B-</option>
                                  <option value="C+">C+</option>
                                  <option value="C">C</option>
                                  <option value="C-">C-</option>
                                  <option value="D">D</option>
                                  <option value="F">F</option>
                                  <%
                              }
                              else if(grade_option.equals("S/U")) {
                                  %>
                                  <option value="S">S</option>
                                  <option value="U">U</option>
                                  <%
                              }
                              %>
                              <option value="IN">INCOMPLETE</option>
                            </select></td>
                            <td><input type="submit" value="Add"></td>
                          </form>
                        </tr>
                        <%
                        }  // end result set loop
                        %>
                        </table>
                        <%
                    }  // end else empty RS set
                } // end if
                else {
                    %>
                    <p>Class successfully added.</p>
                    <%
                } // end else
            %>

            <%-- -------- Close Connection Code -------- --%>
            <%
                    // Close the ResultSet
                    if(rs != null) {
                        rs.close();
                    }
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
    </div>
</body>

</html>
