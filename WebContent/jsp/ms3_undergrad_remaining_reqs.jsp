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
    final String DEGREE_TYPE = "BS";  // default per project requirements
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Remaining Requirements for Bachelors</h1>
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
                            "JOIN Undergraduate u ON st.student_num = u.undergraduate_num " +
                            "JOIN SectionEnrollment se ON u.undergraduate_num = se.student_num " +
                            "JOIN Section s ON se.section_id = s.id " +
                            "JOIN Class c ON s.class_id = c.id " +
                            "WHERE c.quarter = '" + CURRENT_QUARTER + "' " +
                            "AND c.class_year = '" + CURRENT_YEAR + "' " +
                            "ORDER BY st.student_num ASC");
                %>
                <p>Select an <b><i>undergraduate</i></b> who is enrolled in the current quarter
                (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>) and a <b><i>degree</i></b>
                to check remaining requirements.
                <br><b>Note</b>: Undergraduates who are not enrolled in the current quarter
                (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>) are not shown.
                <br><b>Note</b>: Student_Num's are used instead of SSN.</p>
                <form action="ms3_undergrad_remaining_reqs.jsp" method="POST">
                <select name="student_num" required>
                <%
                if(!rs.isBeforeFirst()) {
                %>
                    <option selected disabled>No undergraduates available</option>
                <%
                } else {
                    %>
                    <option selected disabled>Select Undergraduate</option>
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
                    <option selected disabled>Select <%=DEGREE_TYPE%> Degree</option>
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
                <p>Remaining requirements for a <%=DEGREE_TYPE%> in '<%=degree_name%>' for
                student_num <b>'<%=student_num%>'</b></p>
            	<%
                rs = statement.executeQuery(
                        "SELECT SUM(units_taking) AS units_taken " +
                        "FROM Student st " +
                        "JOIN SectionEnrollment se ON st.student_num = se.student_num " +
                        "JOIN ClassesTaken ct ON se.id = ct.sectionenrollment_id " +
                        "WHERE grade_received NOT IN ('D', 'F', 'IN', 'U') " +
                        "AND st.student_num = '" + student_num + "' " +
                        "GROUP BY st.student_num");
                int u;
                if(!rs.isBeforeFirst()) {
                    u = 0;
                } else {
                    rs.next();
                    u = rs.getInt("units_taken");
                }
                rs.close();
                rs = statement.executeQuery(
                        "SELECT * FROM Degree WHERE degree_type = '" + DEGREE_TYPE + "' " +
                        "AND degree_name = '" + degree_name + "'");
                rs.next();
                int r = rs.getInt("required_units");
                %>
                <p>Completed: <b><%=u%></b> out of <b><%=r%></b> required units
                    (<b><%=(r - u > 0) ? (r - u) : 0%></b> remaining).</p>
                <%
                rs.close();
                rs = statement.executeQuery(
                        "SELECT degree_name, category_name, cc.required_units AS category_units_req, " +
                        "SUM(CASE WHEN grade_received IS NULL THEN 0 ELSE units_taking END) AS category_units_sum " +
                        "FROM Degree d " +
                        "JOIN CourseCategory cc ON d.id = cc.degree_id " +
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
                        "GROUP BY degree_name, category_name, degree_type, cc.required_units " +
                        "ORDER BY category_name ASC ");

                %>
                <table border="1">
                    <tr>
                        <th>Category_Name</th>
                        <th>Units_Received</th>
                        <th>Units_Required</th>
                        <th>Units_Remaining</th>
                    </tr>
                    <%
                    while (rs.next()) {
                    	String category_name = rs.getString("category_name");
                    	int units_received = rs.getInt("category_units_sum");
                    	int units_required = rs.getInt("category_units_req");
                    	int units_remaining = (units_required - units_received > 0) ? (units_required - units_received) : 0;
                        %>
                        <tr>
                            <td><input type="text" name="category_name" value="<%=category_name%>" readonly></td>
                            <td><input type="text" name="units_received" value="<%=units_received%>" readonly></td>
                            <td><input type="text" name="units_required" value="<%=units_required%>" readonly></td>
                            <td><input type="text" name="units_remaining" value="<%=units_remaining%>" readonly></td>
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
