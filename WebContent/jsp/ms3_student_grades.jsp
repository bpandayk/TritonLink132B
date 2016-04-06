<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <%
    String student_num = request.getParameter("student_num");
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Student Grade Report</h1>
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

            <%-- -------- SELECT Statement Code -------- --%>
            <%
                    // Create the statement
                    Statement statement = conn.createStatement();
                    ResultSet rs = null;
            
            if(student_num == null) {
                    rs = statement.executeQuery(
                            "SELECT DISTINCT st.student_num AS st_num, first_name, middle_name, last_name " +
                            "FROM Student st " +
                            "JOIN SectionEnrollment se ON st.student_num = se.student_num " +
                            "ORDER BY st.student_num ASC");
            %>
            <p>Select a student who is or has been enrolled in any quarter.
            <br><b>Note</b>: Students who have never been enrolled are not shown.
            <br><b>Note</b>: Student_Num's are used instead of SSN.</p>
            <form action="ms3_student_grades.jsp" method="POST">
            <select name="student_num" required>
            <%
                if(!rs.isBeforeFirst()) {
                %>
                    <option selected disabled>No students available</option>
                <%
                } else {
                    %>
                    <option selected disabled>Select Student</option>
                    <%
                    while (rs.next()) {
                        String info = rs.getString("st_num") + " | " + rs.getString("first_name") + " " +
                                rs.getString("middle_name") + " " + rs.getString("last_name");
                        %>
                        <option value="<%=rs.getString("st_num")%>"><%=info%></option>
                        <%
                    }
                }
            %>
            </select>
            <input type="submit" value="Submit">
            </form>
            
            <%
            }  // end if request student_num == null
            else {
                %>
                <p>Grade report for student_num <b>'<%=student_num%>'</b>.
                <br><b>Note:</b> P/NP, S/U, and INCOMPLETE grades are ignored in GPA calculations.</p>
                <hr>
                <%
                rs = statement.executeQuery(
                    "SELECT department, course_num, class_title, quarter, class_year, " +
                    "units_taking, section_num, grade_received, number_grade " +
                    "FROM SectionEnrollment se " +
                    "JOIN Section s ON se.section_id = s.id " +
                    "JOIN Class cl ON s.class_id = cl.id " +
                    "JOIN ClassInstance ci ON cl.id = ci.class_id " +
                    "JOIN Course co ON ci.course_id = co.id " +
                    "LEFT OUTER JOIN ClassesTaken ct ON se.id = ct.sectionenrollment_id " +
                    "LEFT OUTER JOIN grade_conversion gc ON ct.grade_received = gc.LETTER_GRADE " +
                    "WHERE se.student_num = '" + student_num + "' " +
                    "ORDER BY class_year, quarter, class_title DESC");
                
                if (!rs.isBeforeFirst()) {
                    %>
                    <p>This student is not enrolled in any classes.</p>
                    <%
                } else {
                    rs.next();
                    String curr_quarter = rs.getString("quarter");
                    String curr_year = rs.getString("class_year");
                    String grade_received = (rs.getString("grade_received") == null) ? "WIP" : rs.getString("grade_received");    
                                        
                    // Grab gpa/units info from first class
                    boolean calculable_gpa = true;
                    double quarter_gpa = rs.getDouble("number_grade");
                    int quarter_units = rs.getInt("units_taking");
                    int num_finished_classes = (rs.getString("number_grade") == null) ? 0 : 1;
                    
                    // cumulative gpa/units
                    double cumulative_gpa = 0.0;
                    int cumulative_finished_classes = 0;
                    int cumulative_units = 0;
                %>
                    <p><b>Quarter</b>: <%=curr_quarter%> <%=curr_year%></p>
                    <table border="1">
                      <tr>
                        <th>Department</th>
                        <th>Course_Num</th>
                        <th>Class_Title</th>
                        <th>Section_Num</th>
                        <th>Units_Taking</th>
                        <th>Grade_Received</th>
                      </tr>
                      <tr>
                        <td><input type="text" name="department" value="<%=rs.getString("department")%>" readonly></td>
                        <td><input type="text" name="course_num" value="<%=rs.getString("course_num")%>" readonly></td>
                        <td><input type="text" name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                        <td><input type="text" name="section_num" value="<%=rs.getString("section_num")%>" readonly></td>
                        <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                        <td><input type="text" name="grade_received" value="<%=grade_received%>" readonly></td>
                      </tr>
                    <%
                    while (rs.next()) {
                    	if (rs.getString("quarter").equals(curr_quarter) && rs.getString("class_year").equals(curr_year)) {
                    	    grade_received = (rs.getString("grade_received") == null) ? "WIP" : rs.getString("grade_received");
                    	    
                    	    // Update gpa/units info for next class
                    	    quarter_gpa += rs.getDouble("number_grade");
                    	    quarter_units += rs.getInt("units_taking");
                    	    num_finished_classes += (rs.getString("number_grade") == null) ? 0 : 1;                            
                            %>
                            <tr>
                              <td><input type="text" name="department" value="<%=rs.getString("department")%>" readonly></td>
                              <td><input type="text" name="course_num" value="<%=rs.getString("course_num")%>" readonly></td>
                              <td><input type="text" name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                              <td><input type="text" name="section_num" value="<%=rs.getString("section_num")%>" readonly></td>
                              <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                              <td><input type="text" name="grade_received" value="<%=grade_received%>" readonly></td>
                            </tr>
                            <%
                          } else {
                              curr_quarter = rs.getString("quarter");
                              curr_year = rs.getString("class_year");
                              grade_received = (rs.getString("grade_received") == null) ? "WIP" : rs.getString("grade_received");
                              
                              // Calculate quarter GPA before printing
                              calculable_gpa = (num_finished_classes != 0);
                              
                              // Update cumulative gpa/units
                              cumulative_gpa += quarter_gpa;
                              cumulative_finished_classes += num_finished_classes;
                              cumulative_units += quarter_units;
                              %>
                              </table>
                              <p><b>Quarter GPA</b>: <%=(calculable_gpa) ? quarter_gpa/num_finished_classes : "N/A"%><br>
                              <b>Quarter Units Attempted</b>: <%=quarter_units%></p>
                              <hr><br>
                              <p><b>Quarter</b>: <%=curr_quarter%> <%=curr_year%></p>
                              <%
                              // Grab gpa/units info from first class of the next quarter
                              quarter_gpa = rs.getDouble("number_grade");  // reset gpa for new quarter
                              quarter_units = rs.getInt("units_taking");   // reset units for new quarter
                              num_finished_classes = (rs.getString("number_grade") == null) ? 0 : 1;  // reset finished classes
                              %>
                              <table border="1">
                                <tr>
                                  <th>Department</th>
                                  <th>Course_Num</th>
                                  <th>Class_Title</th>
                                  <th>Section_Num</th>
                                  <th>Units_Taking</th>
                                  <th>Grade_Received</th>
                                </tr>
                                <tr>
                                  <td><input type="text" name="department" value="<%=rs.getString("department")%>" readonly></td>
                                  <td><input type="text" name="course_num" value="<%=rs.getString("course_num")%>" readonly></td>
                                  <td><input type="text" name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                                  <td><input type="text" name="section_num" value="<%=rs.getString("section_num")%>" readonly></td>
                                  <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                                  <td><input type="text" name="grade_received" value="<%=grade_received%>" readonly></td>
                                </tr>
                              <%
                            } // end inner else
                        }  // end ResultSet while
                        %>
                        </table>
                        <%
                        // Calculate quarter GPA before printing
                        calculable_gpa = (num_finished_classes != 0);
                        
                        // Update cumulative gpa/units
                        cumulative_gpa += quarter_gpa;
                        cumulative_finished_classes += num_finished_classes;
                        cumulative_units += quarter_units;
                        %>
                        <p><b>Quarter GPA</b>: <%=(calculable_gpa) ? quarter_gpa/num_finished_classes : "N/A"%><br>
                        <b>Quarter Units Attempted</b>: <%=quarter_units%></p>
                        <hr>
                        <p><b>Cumulative GPA</b>: <%=(cumulative_finished_classes != 0) ?
                        		cumulative_gpa/cumulative_finished_classes : "N/A"%><br>
                        <b>Cumulative Units Attempted</b>: <%=cumulative_units%></p>
                        <%
                } // end empty Result Set else
            }  // end else
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
</body>

</html>
