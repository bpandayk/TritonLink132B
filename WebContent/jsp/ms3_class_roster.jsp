<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <%
    int class_id = 0;
    if (request.getParameter("class_id") != null) {
        class_id = Integer.parseInt(request.getParameter("class_id"));
    }
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Class Roster</h1>
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
            
            if(request.getParameter("class_id") == null) {
                    rs = statement.executeQuery(
                        "SELECT department, course_num, cl.id AS cl_id, class_title, quarter, class_year FROM Course co " +
                        "JOIN ClassInstance ci ON co.id = ci.course_id " +
                        "JOIN Class cl ON ci.class_id = cl.id " +
                        "ORDER BY department, course_num, quarter, class_year ASC");
            %>
            <p>Select a class to view its roster.<br>
            <b>Note:</b> Only classes that have corresponding courses are shown.</p>
            <form action="ms3_class_roster.jsp" method="POST">
            <select name="class_id" required>
            <%
                if(!rs.isBeforeFirst()) {
                %>
                    <option selected disabled>No classes available</option>
                <%
                } else {
                    %>
                    <option selected disabled>Select Class</option>
                    <%
                    while (rs.next()) {
                        String info = rs.getString("department") + " " + rs.getString("course_num") + " | " +
                                rs.getString("class_title") + " | " + rs.getString("quarter") + " - " +
                                rs.getString("class_year");
                        %>
                        <option value="<%=rs.getInt("cl_id")%>"><%=info%></option>
                        <%
                    }
                }
            %>
            </select>
            <input type="submit" value="Submit">
            </form>
            
            <%
            }  // end if request class_id == null
            else {
            	rs = statement.executeQuery(
            	    "SELECT class_title, quarter, class_year FROM Class c " +
            	    "JOIN ClassInstance ci ON c.id = ci.class_id " +
            	    "WHERE c.id = " + class_id);
            	rs.next();
                %>
                <p>Roster for class <b>'<%=rs.getString("class_title")%>'</b>
                for <b><%=rs.getString("quarter")%> <%=rs.getString("class_year")%></b>.<p>
                <%

                rs.close();
                rs = statement.executeQuery(
                    "SELECT s.section_num AS sec_num, st.student_num AS st_num, ssn, " +
                    "first_name, middle_name, last_name, residency, units_taking, grade_option " +
                    "FROM Student st " +
                    "JOIN SectionEnrollment se ON st.student_num = se.student_num " +
                    "JOIN Section s ON se.section_id = s.id " +
                    "JOIN Class c ON s.class_id = c.id " +
                    "WHERE c.id = " + class_id + " " +
                    "ORDER BY s.section_num, st.student_num ASC");

                if(!rs.isBeforeFirst()) {
                %>
                    <p>No students are enrolled in this class.</p>
                <%
                } else {
                    rs.next();
                    String curr_section_num = rs.getString("sec_num");
                    %>

                    <p>Section: <b><%=curr_section_num%></b></p>
                    <table border="1">
                      <tr>
                        <th>Student_Num</th>
                        <th>SSN</th>
                        <th>First_Name</th>
                        <th>Middle_Name</th>
                        <th>Last_Name</th>
                        <th>Residency</th>
                        <th>Units_Taking</th>
                        <th>Grade_Option</th>
                      </tr>
                      <tr>
                        <td><input type="text" name="student_num" value="<%=rs.getString("st_num")%>" readonly></td>
                        <td><input type="text" name="ssn" value="<%=rs.getString("ssn")%>" readonly></td>
                        <td><input type="text" name="first_name" value="<%=rs.getString("first_name")%>" readonly></td>
                        <td><input type="text" name="middle_name" value="<%=rs.getString("middle_name")%>" readonly></td>
                        <td><input type="text" name="last_name" value="<%=rs.getString("last_name")%>" readonly></td>
                        <td><input type="text" name="residency" value="<%=rs.getString("residency")%>" readonly></td>
                        <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                        <td><input type="text" name="grade_option" value="<%=rs.getString("grade_option")%>" readonly></td>
                      </tr>
                    <%
                    while (rs.next()) {
                        if (rs.getString("sec_num").equals(curr_section_num)) {
                        %>
                        <tr>
                          <td><input type="text" name="student_num" value="<%=rs.getString("st_num")%>" readonly></td>
                          <td><input type="text" name="ssn" value="<%=rs.getString("ssn")%>" readonly></td>
                          <td><input type="text" name="first_name" value="<%=rs.getString("first_name")%>" readonly></td>
                          <td><input type="text" name="middle_name" value="<%=rs.getString("middle_name")%>" readonly></td>
                          <td><input type="text" name="last_name" value="<%=rs.getString("last_name")%>" readonly></td>
                          <td><input type="text" name="residency" value="<%=rs.getString("residency")%>" readonly></td>
                          <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                          <td><input type="text" name="grade_option" value="<%=rs.getString("grade_option")%>" readonly></td>
                        </tr>
                        <%
                        } else {
                    	    curr_section_num = rs.getString("sec_num");
                    	    %>
                    	    </table>
                    	    <hr><br>
                            <p>Section: <b><%=curr_section_num%></b></p>
                            <table border="1">
                              <tr>
                                <th>Student_Num</th>
                                <th>SSN</th>
                                <th>First_Name</th>
                                <th>Middle_Name</th>
                                <th>Last_Name</th>
                                <th>Residency</th>
                                <th>Units_Taking</th>
                                <th>Grade_Option</th>
                              </tr>
                              <tr>
                                <td><input type="text" name="student_num" value="<%=rs.getString("st_num")%>" readonly></td>
                                <td><input type="text" name="ssn" value="<%=rs.getString("ssn")%>" readonly></td>
                                <td><input type="text" name="first_name" value="<%=rs.getString("first_name")%>" readonly></td>
                                <td><input type="text" name="middle_name" value="<%=rs.getString("middle_name")%>" readonly></td>
                                <td><input type="text" name="last_name" value="<%=rs.getString("last_name")%>" readonly></td>
                                <td><input type="text" name="residency" value="<%=rs.getString("residency")%>" readonly></td>
                                <td><input type="text" name="units_taking" value="<%=rs.getInt("units_taking")%>" readonly></td>
                                <td><input type="text" name="grade_option" value="<%=rs.getString("grade_option")%>" readonly></td>
                              </tr>
                            <%
                        } // end inner else
                    }  // end ResultSet while
                    %>
                    </table>
                    <%
                }  // end empty ResultSet else
            }  // end else request class_id
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
