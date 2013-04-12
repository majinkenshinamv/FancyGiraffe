<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Template &middot; Bootstrap</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le styles -->
        <link href="css/bootstrap.css" rel="stylesheet">
        <style type="text/css">
            body {
              padding-top: 20px;
              padding-bottom: 60px;
            }
            
            /* Custom container */
            .container {
              margin: 0 auto;
              max-width: 1000px;
            }
            .container > hr {
              margin: 60px 0;
            }
            
            /* Main marketing message and sign up button */
            .jumbotron {
              margin: 80px 0;
              text-align: center;
            }
            .jumbotron h1 {
              font-size: 60px;
              line-height: 1;
            }
            .jumbotron .lead {
              font-size: 24px;
              line-height: 1.25;
            }
            .jumbotron .btn {
              font-size: 21px;
              padding: 14px 24px;
            }
            
            /* Supporting marketing content */
            .marketing {
              margin: 60px 0;
            }
            .marketing p + h4 {
              margin-top: 28px;
            }
            
            
            /* Customize the navbar links to be fill the entire space of the .navbar */
            .navbar .navbar-inner {
              padding: 0;
            }
            .navbar .nav {
              margin: 0;
              display: table;
              width: 100%;
            }
            .navbar .nav li {
              display: table-cell;
              width: 1%;
              float: none;
            }
            .navbar .nav li a {
              font-weight: bold;
              text-align: center;
              border-left: 1px solid rgba(255,255,255,.75);
              border-right: 1px solid rgba(0,0,0,.1);
            }
            .navbar .nav li:first-child a {
              border-left: 0;
              border-radius: 3px 0 0 3px;
            }
            .navbar .nav li:last-child a {
              border-right: 0;
              border-radius: 0 3px 3px 0;
            }
        </style>
        <link href="css/bootstrap-responsive.css" rel="stylesheet">

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
                    <!--[if lt IE 9]>
                                          <script src="../assets/js/html5shiv.js"></script>
                                        <![endif]-->
        <!-- Fav and touch icons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
        <link rel="shortcut icon" href="../assets/ico/favicon.png">
    </head>

    <body>
        
        <%
            ResultSet rs = null;
            Connection con = null;
            Statement statement = null;
            try
            {
                String host = "jdbc:derby://localhost:1527/fancyGiraffe";
                String uName = "username";
                String uPass = "password";
                con = DriverManager.getConnection(host, uName, uPass);
                statement = con.createStatement();
                String sql = "SELECT * FROM APP.ASSETS";
                rs = statement.executeQuery(sql);
            }
            catch (SQLException ex)
            {
                
            }
        %>

        <div class="container">

            <div class="masthead">
                <h3 class="muted">Asset Management Tool</h3>
                <div class="navbar">
                    <div class="navbar-inner">
                        <div class="container">
                            <ul class="nav">
                                <li><a href="index.html">Home</a></li>
                                <li><a href="assets.html">Assets</a></li>
                                <li><a href="locations.html">Locations</a></li>
                                <li class="active"><a href="#">Relocate</a></li>
                                <li><a href="reports.html">Reports</a></li>
                                <li><a href="#">Help</a></li>
                            </ul>
                        </div>
                    </div>
                </div><!-- /.navbar -->
            </div>

            <div class="container" style="margin-top: 50px; padding: 20px;">
                <form class="form-inline">
                    <input type="text" class="input-small" placeholder="assetID">
                    <select>
                        <option>Office</option>
                        <option>Warehouse</option>
                        <option>Main St</option>
                    </select>
                    <button type="submit" class="btn" style="margin-left: 40px;" onclick="showStuff('assetQueueTable'); hideStuff('successMessage'); return false">Assign w/o Grouping</button>
                    <button type="submit" class="btn btn-success" style="margin-left: 10px;" onclick="hideStuff('assetQueueTable'); showStuff('successMessage'); return false">Group and Assign</button>
                </form>
                <hr>
                
                <table class="table table-striped table-bordered" id="assetQueueTable" style="display: none">
                    <caption style="margin-bottom: 5px;"><h4>Asset Queue</h4><span class="badge badge-success pull-right">x4  </span></caption>
                    <thead>
                    <tr>
                        <th>AssetID</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>MFR</th>
                        <th>AssetType</th>
                    </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getString("AssetID") %></td>
                        <td><%= rs.getString("Location") %></td>
                        <td><%= rs.getString("Description") %></td>
                        <td><%= rs.getString("MFR") %></td>
                        <td><%= rs.getString("AssetType") %></td>
                    </tr>
                        <% } %>
                    </tbody>
                </table>
                    
                    <% 
                        rs.close();
                        statement.close();
                        con.close(); 
                    %>
                
                <div id="successMessage" class="alert alert-success" style="display: none"><span class="label label-success">Success!</span>
                    4 items were moved to OFFICE.<strong style="margin-left: 30px;">GroupID: OFFICE0012</strong>
                </div>
            </div>
            <hr>

            <div class="footer">
                <p>&copy; Company 2013</p>
            </div>

        </div> <!-- /container -->
        
        <!-- Le javascript -->
        <script src="http://code.jquery.com/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/bootstrap-dropdown.js"></script>

        <script type="text/javascript">
            function showStuff(id) {
                document.getElementById(id).style.display = 'table';
            }
            function hideStuff(id) {
                document.getElementById(id).style.display = 'none';
            }
        </script>

    </body>
</html>