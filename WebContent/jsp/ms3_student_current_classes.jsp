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
    <h1>Classes for Current Quarter</h1>
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
            <form action="ms3_student_current_classes.jsp" method="POST">
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
            	<p>Classes for student_num '<b><%=student_num%></b>' for the current quarter:
            	<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>.</p>
            	<%
                rs = statement.executeQuery(
                        "SELECT class_title, quarter, class_year, units_taking, section_num " +
                        "FROM SectionEnrollment se " +
                        "JOIN Section s ON se.section_id = s.id " +
                        "JOIN Class c ON s.class_id = c.id " +
                        "WHERE c.quarter = '" + CURRENT_QUARTER + "' " +
                        "AND c.class_year = '" + CURRENT_YEAR + "' " +
                        "AND se.student_num = '" + student_num + "' " +
                        "ORDER BY class_year, quarter, class_title");
                %>
                <table border="1">
                    <tr>
                        <th>Class_Title</th>
                        <th>Quarter</th>
                        <th>Class_Year</th>
                        <th>Units_Taking</th>
                        <th>Section_Num</th>
                    </tr>
                    <%
                    while (rs.next()) {
                        %>
                        <tr>
                            <td><input type="text" name="class_title" value="<%=rs.getString("class_title")%>" readonly></td>
                            <td><input type="text" name="quarter" value="<%=rs.getString("quarter")%>" readonly></td>
                            <td><input type="text" name="class_year" value="<%=rs.getString("class_year")%>" readonly></td>
                            <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                            <td><input type="text" name="section_num" value="<%=rs.getString("section_num")%>" readonly></td>
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
