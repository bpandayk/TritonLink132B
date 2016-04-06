<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <%
    String student_num = request.getParameter("student_num");
    String degree_name = request.getParameter("degree_name");
    final String CURRENT_QUARTER = "WINTER";  // default per project requirements
    final String CURRENT_YEAR = "2016";       // default per project requirements
    final String DEGREE_TYPE = "MS";          // default per project requirements
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Remaining Requirements for Masters</h1>
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
            
            if(student_num == null && degree_name == null) {
                    rs = statement.executeQuery(
                            "SELECT DISTINCT st.student_num AS st_num, first_name, middle_name, last_name " +
                            "FROM Student st " +
                            "JOIN MSStudent mss ON st.student_num = mss.msstudent_num " +
                            "JOIN SectionEnrollment se ON mss.msstudent_num = se.student_num " +
                            "JOIN Section s ON se.section_id = s.id " +
                            "JOIN Class c ON s.class_id = c.id " +
                            "WHERE c.quarter = '" + CURRENT_QUARTER + "' " +
                            "AND c.class_year = '" + CURRENT_YEAR + "' " +
                            "ORDER BY st.student_num ASC");
                %>
                <p>Select an <b><i>MS student</i></b> who is enrolled in the current quarter
                (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>) and a <b><i>degree</i></b>
                to check remaining requirements.
                <br><b>Note</b>: MS Students who are not enrolled in the current quarter
                (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>) are not shown.
                <br><b>Note</b>: Student_Num's are used instead of SSN.</p>
                <form action="ms3_ms_remaining_reqs.jsp" method="POST">
                <select name="student_num" required>
                <%
                if(!rs.isBeforeFirst()) {
                %>
                    <option selected disabled>No MS students available</option>
                <%
                } else {
                    %>
                    <option selected disabled>Select MS Student</option>
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
                <%
                rs.close();
                rs = statement.executeQuery(
                        "SELECT * FROM Degree WHERE degree_type = '" + DEGREE_TYPE + "' ORDER BY degree_name ASC");
                %>
                <select name="degree_name" required>
                <%
                if(!rs.isBeforeFirst()) {
                %>
                    <option selected disabled>No degrees available</option>
                <%
                } else {
                    %>
                    <option selected disabled>Select MS Degree</option>
                    <%
                    while (rs.next()) {
                        String info = rs.getString("degree_type") + " in " + rs.getString("degree_name");
                        %>
                        <option value="<%=rs.getString("degree_name")%>"><%=info%></option>
                        <%
                    }
                }
            %>
            </select>
            <input type="submit" value="Submit">
            </form>
            
            <%
            }  // end if request student_num == null AND degree_type == null
            else {
                %>
                <p>Concentration progress for a <%=DEGREE_TYPE%> in '<%=degree_name%>' for
                student_num <b>'<%=student_num%>'</b></p>
                <%
                Statement tmpStmt = conn.createStatement();
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS completed_ms_units");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS completed_ms_gpa");
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE completed_ms_units AS " +
                        "SELECT degree_name, concentration_name, cc.required_units AS concentration_units_req, min_gpa, " +
                        "SUM(CASE WHEN grade_received IS NULL THEN 0 ELSE units_taking END) AS concentration_units_sum " +
                        "FROM Degree d " +
                        "JOIN CourseConcentration cc ON d.id = cc.degree_id " +
                        "JOIN Course co ON cc.course_id = co.id " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " +
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "LEFT OUTER JOIN Section s ON cl.id = s.class_id " +
                        "LEFT OUTER JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "LEFT OUTER JOIN ClassesTaken ct ON se.id = ct.sectionenrollment_id " +
                        "WHERE degree_name = '" + degree_name + "' " +
                        "AND degree_type = '" + DEGREE_TYPE + "' " +
                        "AND (grade_received NOT IN ('D', 'F', 'IN', 'U') OR grade_received IS NULL) " +
                        "AND (se.student_num = '" + student_num + "' OR se.student_num IS NULL) " +
                        "GROUP BY degree_name, concentration_name, degree_type, cc.required_units, min_gpa " +
                        "ORDER BY concentration_name ASC");
                
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE completed_ms_gpa AS " +
                        "SELECT degree_name, concentration_name, degree_type, " +
                        "cc.required_units AS concentration_units_req, min_gpa,SUM(number_grade)/COUNT(ct.id) AS avg_gpa " +
                        "FROM Degree d " +
                        "JOIN CourseConcentration cc ON d.id = cc.degree_id " +
                        "JOIN Course co ON cc.course_id = co.id " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " +
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "LEFT OUTER JOIN Section s ON cl.id = s.class_id " +
                        "LEFT OUTER JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "LEFT OUTER JOIN ClassesTaken ct ON se.id = ct.sectionenrollment_id " +
                        "LEFT OUTER JOIN grade_conversion gc ON ct.grade_received = gc.letter_grade " +
                        "WHERE degree_name = '" + degree_name + "' " +
                        "AND degree_type = '" + DEGREE_TYPE + "' " +
                        "AND (grade_received NOT IN ('IN', 'S', 'U') OR grade_received IS NULL) " +
                        "AND (se.student_num = '" + student_num + "' OR se.student_num IS NULL) " +
                        "GROUP BY degree_name, concentration_name, degree_type, cc.required_units, cc.min_gpa " +
                        "ORDER BY concentration_name");
                
                rs = statement.executeQuery(
                        "SELECT c.degree_name AS deg_name, c.concentration_name AS conc_name, " +
                        "c.concentration_units_req AS units_req, c.min_gpa AS gpa_req, concentration_units_sum, avg_gpa " +
                        "FROM completed_ms_units c " +
                        "JOIN completed_ms_gpa g ON c.degree_name = g.degree_name " +
                        "AND c.concentration_name = g.concentration_name " +
                        "AND c.concentration_units_req = g.concentration_units_req " +
                        "AND c.min_gpa = g.min_gpa");
                
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS completed_ms_units");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS completed_ms_gpa");
                tmpStmt.close();
                %>
                <table border="1">
                    <tr>
                        <th>Concentration_Name</th>
                        <th>Units_Received</th>
                        <th>Units_Required</th>
                        <th>Average_GPA</th>
                        <th>GPA_Required</th>
                        <th>Completed</th>
                    </tr>
                    <%
                    while(rs.next()) {
                        String concentration_name = rs.getString("conc_name");
                        int units_received = rs.getInt("concentration_units_sum");
                        int units_required = rs.getInt("units_req");
                        double avg_gpa = rs.getDouble("avg_gpa");
                        String gpa_string = (units_received == 0 && avg_gpa == 0.0) ? "N/A" : String.valueOf(avg_gpa);
                        double gpa_required = rs.getDouble("gpa_req");
                        boolean completed = (units_received >= units_required && avg_gpa >= gpa_required);
                    %>
                    <tr>
                        <td><input type="text" name="concentration_name" value="<%=concentration_name%>" readonly></td>
                        <td><input type="text" name="units_received" value="<%=units_received%>" readonly></td>
                        <td><input type="text" name="units_required" value="<%=units_required%>" readonly></td>
                        <td><input type="text" name="average_gpa" value="<%=gpa_string%>" readonly></td>
                        <td><input type="text" name="gpa_required" value="<%=gpa_required%>" readonly></td>
                        <td><input type="text" name="completed" value="<%=completed%>" readonly></td>
                    </tr>
                    <%
                    }
                    %>
                </table>

                <p>Remaining courses for a <%=DEGREE_TYPE%> in '<%=degree_name%>' for
                student_num <b>'<%=student_num%>'</b>.
                <br><b>Note</b>: Any courses that the student has not taken with a passing grade is shown,
                even if the course's concentration is already complete.</p>
                <%
                Statement tmpStmt2 = conn.createStatement();
                tmpStmt2.executeUpdate("DROP TABLE IF EXISTS passed_ms_courses");
                tmpStmt2.executeUpdate("DROP TABLE IF EXISTS remaining_ms_courses");
                tmpStmt2.executeUpdate("DROP TABLE IF EXISTS upcoming_ms_courses");
                tmpStmt2.executeUpdate(
                        "CREATE TEMP TABLE passed_ms_courses AS " +
                        "SELECT concentration_name, department, course_num, class_title FROM Degree d " +
                        "JOIN CourseConcentration cc ON d.id = cc.degree_id " +
                        "JOIN Course co ON cc.course_id = co.id " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " + 
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "JOIN Section s ON cl.id = s.class_id " +
                        "JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "JOIN ClassesTaken ct ON se.id = ct.sectionenrollment_id " +
                        "WHERE degree_type = '" + DEGREE_TYPE + "' " +
                        "AND se.student_num = '" + student_num + "' " +
                        "AND grade_received NOT IN ('D', 'F', 'IN', 'U') " +
                        "ORDER BY concentration_name, department, course_num, class_title ASC");
                
                tmpStmt2.executeUpdate(
                        "CREATE TEMP TABLE remaining_ms_courses AS " +
                        "SELECT DISTINCT concentration_name, department, course_num, class_title " +
                        "FROM Degree d " +
                        "JOIN CourseConcentration cc ON d.id = cc.degree_id " +
                        "JOIN Course co ON cc.course_id = co.id " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " +
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "JOIN Quarter q ON cl.quarter = q.quarter AND cl.class_year = q.year " +
                        "WHERE degree_type = '" + DEGREE_TYPE + "' " +
                        "AND degree_name = '" + degree_name + "' " +
                        "AND NOT EXISTS ( " +
                        "    SELECT * FROM passed_ms_courses psm " +
                        "    WHERE psm.concentration_name = cc.concentration_name " +
                        "    AND psm.department = co.department " +
                        "    AND psm.course_num = co.course_num " +
                        "    AND psm.class_title = cl.class_title " +
                        ") ORDER BY concentration_name, department, course_num, class_title ASC");

                tmpStmt2.executeUpdate(
                        "CREATE TEMP TABLE upcoming_ms_courses AS " +
                        "SELECT DISTINCT ON (rmc.concentration_name, rmc.department, rmc.course_num, rmc.class_title) " +
                        "rmc.concentration_name AS c_name, rmc.department AS c_dpmt, " +
                        "rmc.course_num AS c_num, rmc.class_title AS c_title, " +
                        "cl.quarter AS c_quarter, cl.class_year AS c_year " +
                        "FROM remaining_ms_courses rmc " +
                        "JOIN Course co ON rmc.department = co.department " +
                        "AND rmc.course_num = co.course_num " +
                        "JOIN Class cl ON rmc.class_title = cl.class_title " +
                        "JOIN Quarter q ON cl.quarter = q.quarter " +
                        "AND cl.class_year = q.year " +
                        "GROUP BY rmc.concentration_name, rmc.department, rmc.course_num, " +
                        "rmc.class_title, cl.quarter, cl.class_year, q.id " +
                        "HAVING MIN(q.id) > " +
                        "    (SELECT id FROM Quarter WHERE quarter = '" +
                             CURRENT_QUARTER + "' AND year = '" + CURRENT_YEAR + "') " +
                        "ORDER BY rmc.concentration_name, rmc.department, rmc.course_num, rmc.class_title, q.id ASC");
                
                rs.close();
                rs = statement.executeQuery(
                        "SELECT * FROM remaining_ms_courses rmc " +
                        "LEFT OUTER JOIN upcoming_ms_courses umc " +
                        "ON rmc.concentration_name = umc.c_name " +
                        "AND rmc.course_num = umc.c_num " +
                        "AND rmc.department = umc.c_dpmt " +
                        "AND rmc.class_title = umc.c_title " +
                        "ORDER BY rmc.concentration_name, department, course_num, class_title");

                tmpStmt2.executeUpdate("DROP TABLE IF EXISTS passed_ms_courses");
                tmpStmt2.executeUpdate("DROP TABLE IF EXISTS remaining_ms_courses");
                tmpStmt2.executeUpdate("DROP TABLE IF EXISTS upcoming_ms_courses");
                tmpStmt2.close();
                %>
                <table border="1">
                    <tr>
                        <th>Concentration_Name</th>
                        <th>Course_Info</th>
                        <th>Class_Title</th>
                        <th>Next_Offering</th>
                    </tr>
                    <%
                    while (rs.next()) {
                    	String concentration_name = rs.getString("concentration_name");
                        String course_info = rs.getString("department") + " " + rs.getString("course_num");
                        String class_title = rs.getString("class_title");
                        String next_offering = "Not available";
                        if(rs.getString("c_quarter") != null && rs.getString("c_year") != null) {
                            next_offering = rs.getString("c_quarter") + " " + rs.getString("c_year");
                        }
                        %>
                        <tr>
                            <td><input type="text" name="concentration_name" value="<%=concentration_name%>" readonly></td>
                            <td><input type="text" name="course_info" value="<%=course_info%>" readonly></td>
                            <td><input type="text" name="class_title" value="<%=class_title%>" readonly></td>
                            <td><input type="text" name="next_offering" value="<%=next_offering%>" readonly></td>
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
