<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>
<body>
    <%
    String section_num = request.getParameter("section_num");
    String start_date = request.getParameter("start_date");
    String end_date = request.getParameter("end_date");
    
    final String CURRENT_QUARTER = "WINTER";  // default per project requirements
    final String CURRENT_YEAR = "2016";       // default per project requirements
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Review Session Schedule</h1>
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
            
            if(section_num == null) {
                    rs = statement.executeQuery(
                            "SELECT department||' '||course_num AS course_info, class_title, section_num " +
                            "FROM Section s " +
                            "JOIN Class cl ON s.class_id = cl.id " +
                            "JOIN ClassInstance ci ON cl.id = ci.class_id " +
                            "JOIN Course co ON ci.course_id = co.id " +
                            "WHERE cl.quarter = '" + CURRENT_QUARTER + "' " +
                            "AND cl.class_year = '" + CURRENT_YEAR + "' " +
                            "ORDER BY course_info, class_title, section_num");
            %>
            <p>Select the section number, and enter a start and end date (inclusive) for the review session.
            <br><b>Note</b>: Only sections of the current quarter
            (<b><%=CURRENT_QUARTER%>&nbsp;<%=CURRENT_YEAR%></b>) are displayed.</p>
            <form action="ms3_review_session_schedule.jsp" method="POST">
            <select name="section_num" required>
            <%
                if(!rs.isBeforeFirst()) {
                %>
                    <option selected disabled>No sections available</option>
                <%
                } else {
                    %>
                    <option selected disabled>Select Section</option>
                    <%
                    while (rs.next()) {
                        String info = rs.getString("course_info") + " | " + rs.getString("class_title") + " | " +
                                rs.getString("section_num");
                        %>
                        <option value="<%=rs.getString("section_num")%>"><%=info%></option>
                        <%
                    }
                }
            %>
            </select>
            Start:<input type="text" name="start_date" placeholder="yyyy-mm-dd" required>
            End:<input type="text" name="end_date" placeholder="yyyy-mm-dd" required>
            <input type="submit" value="Submit">
            </form>
            
            <%
            }  // end if request section_num == null
            else {
                %>
                <p>Review session for section_num <%=section_num%>
                between <%=start_date%> and <%=end_date%> (inclusive).</p>
                <%
                
                Statement tmpStmt = conn.createStatement();
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS enrolled_section_times");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS review_session_intervals");
                
                // distinct start,end of all sections taken by students who are enrolled in this section_num
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE enrolled_section_times AS " +
                        "SELECT DISTINCT start_datetime AS enrolled_start_time, end_datetime AS enrolled_end_time " +
                        "FROM SectionEnrollment se " +
                        "JOIN Section s ON se.section_id = s.id " +
                        "JOIN WeeklyMeeting wm ON s.id = wm.section_id " + 
                        "WHERE student_num IN ( " +
                        "    SELECT student_num " +
                        "    FROM SectionEnrollment se " +
                        "    JOIN Section s ON se.section_id = s.id " +
                        "    WHERE s.section_num = '" + section_num + "')");
                
                // generate hourly timestamps of the input start_time, end_time
                tmpStmt.executeUpdate(
                        "CREATE TEMP TABLE review_session_intervals AS " +
                        "SELECT review_start_time, review_start_time + INTERVAL '1 hour' AS review_end_time " +
                        "FROM generate_series('" + start_date + "'::date, '" + end_date + "'::date + INTERVAL '1 day', " +
                        "'1 hour') AS review_start_time " +
                        "WHERE review_start_time::time >= '08:00:00' " +
                        "AND review_start_time::time <= '19:00:00'");

                // select non-overlapping times
                rs = statement.executeQuery(
                        "SELECT to_char(review_start_time, 'Month DD YYYY Day HH12:MI:SS AM')||' - '||to_char(review_end_time, 'HH12:MI:SS AM') " +
                        "AS available_times " +
                        "FROM review_session_intervals WHERE (review_start_time, review_end_time) NOT IN ( " +
                        "    SELECT review_start_time, review_end_time " +
                        "    FROM enrolled_section_times, review_session_intervals WHERE " +
                        "    (enrolled_start_time, enrolled_end_time) OVERLAPS (review_start_time, review_end_time) " +
                        "    )");
                
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS enrolled_section_times");
                tmpStmt.executeUpdate("DROP TABLE IF EXISTS review_session_intervals");
                tmpStmt.close();
                
                while(rs.next()) {
                %>
                    <p><%=rs.getString("available_times")%></p>
                <%
                }
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
