<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/general.css">
</head>

<body>
    <%
    int course_id = 0;
    if(request.getParameter("course_id") != null) {
        course_id = Integer.parseInt(request.getParameter("course_id"));
    }
    
    String faculty_name = request.getParameter("faculty_name");
    
    int quarter_id = 0;
    if(request.getParameter("quarter_id") != null) {
        quarter_id = Integer.parseInt(request.getParameter("quarter_id"));
    }
    %>
    <jsp:include page="/html/menu.html" />
    <h1>Previous Grade Distributions</h1>
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
            Statement statement = conn.createStatement();
            ResultSet rs = null;

            if(request.getParameter("course_id") == null && request.getParameter("faculty_name") == null &&
                    request.getParameter("quarter_id") == null) {

                %>
                <p>Select a course, a professor, and a quarter (optional).</p>
                <%
                rs = statement.executeQuery("SELECT * FROM Course ORDER BY department, course_num ASC");
                %>
                <form action="ms5_grade_distributions.jsp" method="POST">
                  <select name="course_id" required>
                  <%
                  if(!rs.isBeforeFirst()) {
                  %>
                    <option selected disabled>No courses available</option>
                  <%
                  } else {
                    %>
                    <option selected disabled>Select Course</option>
                    <%
                    while (rs.next()) {
                        String info = rs.getString("department") + " " + rs.getString("course_num");
                        %>
                        <option value="<%=rs.getInt("id")%>"><%=info%></option>
                        <%
                    }
                  }
                  %>
                  </select>
                  
                  <%
                  rs.close();
                  rs = statement.executeQuery("SELECT * FROM Faculty ORDER BY faculty_name ASC");
                  %>
                  <select name="faculty_name" required>
                  <%
                  if(!rs.isBeforeFirst()) {
                  %>
                    <option selected disabled>No Professors available</option>
                  <%
                  } else {
                    %>
                    <option selected disabled>Select Professor</option>
                    <%
                    while (rs.next()) {
                        String info = rs.getString("faculty_name");
                        %>
                        <option value="<%=info%>"><%=info%></option>
                        <%
                    }
                  }
                  %>
                  </select>

                  <%
                  rs.close();
                  rs = statement.executeQuery("SELECT * FROM Quarter ORDER BY id ASC");
                  %>
                  <select name="quarter_id">
                  <%
                    if(!rs.isBeforeFirst()) {
                        %>
                        <option selected disabled>No Quarter available</option>
                        <%
                    } else {
                        %>
                        <option selected disabled>Select Quarter</option>
                        <%
                        while (rs.next()) {
                            String info = rs.getString("quarter") + " " + rs.getString("year");
                            %>
                            <option value="<%=rs.getInt("id")%>"><%=info%></option>
                            <%
                        }
                    }
            %>
            </select>
            <input type="submit" value="Submit">
          </form>
          <%
          } else if (request.getParameter("course_id") != null && request.getParameter("faculty_name") != null &&
                  request.getParameter("quarter_id") != null) {
              rs = statement.executeQuery(
                      "SELECT * " +
                      "FROM CPQG WHERE course_id = " + course_id + " " +
                      "AND faculty_name = '" + faculty_name + "' " +
                      "AND quarter_id = " + quarter_id);
              if(!rs.isBeforeFirst()) {
                  %>
                  <p><%=faculty_name%> did not teach this course
                  (id: <%=course_id%>) in this quarter (id: <%=quarter_id%>).</p>
                  <%
              } else {
                  rs.next();
              %>
              <p>Course: <b><%=rs.getString("department") + " " + rs.getString("course_num")%></b></p>
              <p>Faculty_name: <b><%=rs.getString("faculty_name")%></b></p>
              <p>Quarter: <b><%=rs.getString("quarter") + " " + rs.getString("year")%></b></p>
              <table border="1">
                <tr>
                  <th>Grade</th>
                  <th>Count</th>
                </tr>
                <tr>
                  <td><input type="text" value="A" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("A")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="B" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("B")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="C" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("C")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="D" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("D")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="OTHER" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("OTHER")%>"></td>
                </tr>
              </table>
              <%
              }
          } else if (request.getParameter("course_id") != null && request.getParameter("faculty_name") != null) {
              rs = statement.executeQuery(
                      "SELECT * " +
                      "FROM CPG WHERE course_id = " + course_id + " " +
                      "AND faculty_name = '" + faculty_name + "'");
              if(!rs.isBeforeFirst()) {
                  %>
                  <p><%=faculty_name%> has never taught this course (id: <%=course_id%>).</p>
                  <%
              } else {
                  rs.next();
              %>
              <p>Course: <b><%=rs.getString("department") + " " + rs.getString("course_num")%></b></p>
              <p>Faculty_name: <b><%=rs.getString("faculty_name")%></b></p>
              <table border="1">
                <tr>
                  <th>Grade</th>
                  <th>Count</th>
                </tr>
                <tr>
                  <td><input type="text" value="A" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("A")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="B" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("B")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="C" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("C")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="D" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("D")%>"></td>
                </tr>
                <tr>
                  <td><input type="text" value="OTHER" readonly></td>
                  <td><input type="text" value="<%=rs.getInt("OTHER")%>"></td>
                </tr>
              </table>
              <%
              }
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
</body>

</html>