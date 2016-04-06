<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="../js/classEnrollmentEntryForm.js"></script>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <%-- -------- Include menu HTML code -------- --%>
    <jsp:include page="/html/menu.html" />
    <h3>Enrollment Entry Form</h3>
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
                            "INSERT INTO SectionEnrollment (student_num, section_id, units_taking) " +
                            "VALUES (?, ?, ?)");

                        pstmt.setString(1, request.getParameter("student_num"));
                        pstmt.setInt(2, Integer.parseInt(request.getParameter("sid")));
                        pstmt.setInt(3, Integer.parseInt(request.getParameter("units_taking")));
           
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
                if(request.getParameter("current_year") == null && request.getParameter("current_quarter") == null) {
                    %>
                <p>Select current quarter and year to view enrollment information.<br>
                <b>Default:</b> WINTER 2016</p>
                <table border="1">
                    <tr>
                        <th>Current Quarter</th>
                        <th>Current Year</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                    <form action="class_enrollment_entry_form.jsp" method="POST">
                      <td><select name="current_quarter" required>
                          <option disabled>Quarter</option>
                          <option value="FALL">FALL</option>
                          <option value="WINTER" selected>WINTER</option>
                          <option value="SPRING">SPRING</option>
                          <option value="SUMMER">SUMMER</option>
                      </select></td>
                      <td><select name="current_year" required>
                              <option disabled selected>Year</option>
                          <%
                          for (int year = 2020; year >= 1960; year--) {%>
                              <option value="<%=year%>" <%=(year == 2016) ? "selected" : ""%>><%=year%></option>
                          <%
                          }
                          %>
                      </select></td>
                      <td><input type="submit" value="Confirm"></td>
                    </form>
                    </tr>
                    </table>
                    <%
                } else {
                    rs = statement.executeQuery(
                    	/*
                        "SELECT s.id AS sid, department, course_num, class_title, " +
                        "section_num, grade_option, min_units, max_units " +
                        "FROM Section s, Course co, ClassInstance ci, " +
                        "Class cl WHERE co.id = ci.course_id AND cl.id = ci.class_id AND " +
                        "s.class_id = ci.class_id AND cl.class_year = '" + request.getParameter("current_year") + "' " +
                        "AND cl.quarter = '" + request.getParameter("current_quarter") + "' " +
                        "ORDER BY department, course_num ASC");
                        */
                        "SELECT s.id AS sid, department, course_num, class_title, section_num, section_limit, " +
                        "co.grade_option AS g_option, min_units, max_units, COUNT(se.id) AS section_enrollment_count " +
                        "FROM Section s LEFT OUTER JOIN SectionEnrollment se ON s.id = se.section_id " +
                        "JOIN Class cl ON cl.id = s.class_id " +
                        "JOIN ClassInstance ci ON ci.class_id = cl.id " +
                        "JOIN Course co ON ci.course_id = co.id " +
                        "WHERE cl.quarter = '" + request.getParameter("current_quarter") + "' " +
                        "AND cl.class_year = '" + request.getParameter("current_year")+ "' " +
                        "GROUP BY s.id, department, course_num, class_title, section_num, section_limit, co.grade_option, " +
                        "min_units, max_units ORDER BY department, course_num ASC");
                    
                    %>
                    <p><b>Note:</b> Only class sections that are linked to courses are shown.</p>
                    <table border="1">
                    <tr>
                        <th>Department</th>
                        <th>Course_Num</th>
                        <th>Class_Title</th>
                        <th>Grade_Option</th>
                        <th>Min_Units</th>
                        <th>Max_Units</th>
                        <th>Section_Num</th>
                        <th>Students_Enrolled</th>
                        <th>Waitlist</th>
                    </tr>
                    <%
                    while ( rs.next() ) {
                    %>
                    <tr>
                      <td><input name="department" value="<%=rs.getString("department")%>" size="15" readonly></td>
                      <td><input name="course_num" value="<%=rs.getString("course_num")%>" size="15" readonly></td>
                      <td><input name="class_title" value="<%=rs.getString("class_title")%>" size="20" readonly></td>
                      <td><input name="grade_option" value="<%=rs.getString("g_option")%>" size="15" readonly></td>
                      <td><input name="min_units" value="<%=rs.getInt("min_units")%>" size="10" readonly></td>
                      <td><input name="max_units" value="<%=rs.getInt("max_units")%>" size="10" readonly></td>
                      <td><input name="section_num" value="<%=rs.getString("section_num")%>" size="15" readonly></td>
                      <td>
                        <input name="section_enrollment_count" 
                          value="<%=rs.getInt("section_enrollment_count")%> / <%=rs.getInt("section_limit")%>" size="10">
                        <input type="button" style="float:right;" value="Edit"
                          onclick="editClassEnrollment(<%=rs.getInt("sid")%>, '<%=rs.getString("section_num")%>',
                                  <%=rs.getInt("min_units")%>, <%=rs.getInt("max_units")%>,
                                  '<%=rs.getString("g_option")%>', <%=rs.getInt("section_limit")%>);">
                      </td>
                      <td><input type="button" value="Edit"
                            onclick="editClassWaitlist(<%=rs.getInt("sid")%>, '<%=rs.getString("section_num")%>');"></td>
                    </tr>
                    <%
                    } // end while
                    %>
                    </table>
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
    <hr>
    <iframe style="display:none;" width="900" height="300" frameBorder="0"
       id="edit_enrollment_iframe" name="edit_enrollment_iframe"></iframe>
    <iframe style="display:none;" width="900" height="300" frameBorder="0"
       id="edit_waitlist_iframe" name="edit_waitlist_iframe"></iframe>
</body>

</html>