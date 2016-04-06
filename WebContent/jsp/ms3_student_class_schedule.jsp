<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <%
    String student_num = request.getParameter("student_num");
    final String CURRENT_QUARTER = "WINTER";  // default per project requirements
    final String CURRENT_YEAR = "2016";       // default per project requirements
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Student Class Schedule</h1>
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
                            "JOIN Section s ON se.section_id = s.id " +
                            "JOIN Class c ON s.class_id = c.id " +
                            "WHERE c.quarter = '" + CURRENT_QUARTER + "' " +
                            "AND c.class_year = '" + CURRENT_YEAR + "' " +
                            "ORDER BY st.student_num ASC");
            %>
            <p>Select a student who is enrolled in the current quarter (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>).
            <br><b>Note</b>: Students who are not enrolled in the current quarter
            (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>) are not shown.
            <br><b>Note</b>: Student_Num's are used instead of SSN.</p>
            <form action="ms3_student_class_schedule.jsp" method="POST">
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
                <p>Conflicting classes for student_num '<b><%=student_num%></b>' for the current quarter:
                <b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>.</p>
                <%
                
                Statement tmpStmt = conn.createStatement();
                
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS unenrolled_meetings");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS enrolled_meetings");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS conflicting_meetings");
                
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE unenrolled_meetings AS " +
                        "SELECT DISTINCT start_datetime AS unenrolled_start, end_datetime AS unenrolled_end " +
                        "FROM Class cl " +
                        "JOIN Section s ON cl.id = s.class_id " +
                        "JOIN WeeklyMeeting wm ON s.id = wm.section_id " +
                        "WHERE cl.id NOT IN ( " +
                        "    SELECT cl.id " +
                        "    FROM Class cl " +
                        "    JOIN Section s ON cl.id = s.class_id " +
                        "    JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "    WHERE se.student_num = '" + student_num + "' " +
                        ") " +
                        "AND cl.quarter = '" + CURRENT_QUARTER + "' " +
                        "AND cl.class_year = '" + CURRENT_YEAR + "'");
                
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE enrolled_meetings AS " +
                        "SELECT co.department||' '||co.course_num AS enrolled_course, " +
                        "cl.class_title AS enrolled_class, s.section_num AS enrolled_section, " +
                        "wm.start_datetime AS enrolled_start, wm.end_datetime AS enrolled_end " +
                        "FROM Course co " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " +
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "JOIN Section s ON cl.id = s.class_id " +
                        "JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "JOIN WeeklyMeeting wm ON s.id = wm.section_id " +
                        "WHERE se.student_num = '" + student_num + "' " +
                        "AND cl.quarter = '" + CURRENT_QUARTER + "' " +
                        "AND cl.class_year = '" + CURRENT_YEAR + "'");
                
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE conflicting_meetings AS " +
                        "select * from unenrolled_meetings, enrolled_meetings " +
                        "WHERE (unenrolled_start, unenrolled_end) OVERLAPS (enrolled_start, enrolled_end)");
                
                rs = statement.executeQuery(
                        "SELECT enrolled_course, enrolled_class, enrolled_section, " +
                        "co.department||' '||co.course_num AS conflicting_course, " +
                        "cl.class_title AS conflicting_class, s.section_num AS conflicting_section " +
                        "FROM Course co " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " +
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "JOIN Section s ON cl.id = s.class_id " +
                        "JOIN WeeklyMeeting wm ON s.id = wm.section_id " +
                        "JOIN conflicting_meetings cm ON wm.start_datetime = cm.unenrolled_start " +
                        "AND wm.end_datetime = cm.unenrolled_end " +
                        "WHERE cl.id NOT IN ( " +
                        "    SELECT cl.id " +
                        "    FROM Class cl " +
                        "    JOIN Section s ON cl.id = s.class_id " +
                        "    JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "    WHERE se.student_num = '" + student_num + "' " +
                        ") " +
                        "AND cl.quarter = '" + CURRENT_QUARTER + "' " +
                        "AND cl.class_year = '" + CURRENT_YEAR + "' " +
                        "GROUP BY enrolled_course, enrolled_class, enrolled_section, " +
                        "conflicting_course, conflicting_class, conflicting_section " +
                        "ORDER BY enrolled_course, enrolled_class, enrolled_section, " +
                        "conflicting_course, conflicting_class, conflicting_section");
                
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS unenrolled_meetings");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS enrolled_meetings");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS conflicting_meetings");
                tmpStmt.close();
                %>
                <table border="1">
                    <tr>
                      <th>Enrolled_Course</th>
                      <th>Enrolled_Class</th>
                      <th>Enrolled_SectionNum</th>
                      <th>Conflicting_Course</th>
                      <th>Conflicting_Class</th>
                      <th>Conflicting_Section</th>
                    </tr>
                    <%
                    while(rs.next()) {
                    %>
                      <tr>
                        <td><input type="text" name="enrolled_course" value="<%=rs.getString("enrolled_course")%>" readonly></td>
                        <td><input type="text" name="enrolled_class" value="<%=rs.getString("enrolled_class")%>" readonly></td>
                        <td><input type="text" name="enrolled_section" value="<%=rs.getString("enrolled_section")%>" readonly></td>
                        <td><input type="text" name="conflicting_course" value="<%=rs.getString("conflicting_course")%>" readonly></td>
                        <td><input type="text" name="conflicting_class" value="<%=rs.getString("conflicting_class")%>" readonly></td>
                        <td><input type="text" name="conflicting_section" value="<%=rs.getString("conflicting_section")%>" readonly></td>
                      </tr>
                    <%
                    }
                    %>
                </table>
                <%
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
