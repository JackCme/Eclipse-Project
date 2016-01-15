<%@page contentType="text/html; charset=utf-8" errorPage="error.jsp" %>

<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login</title>
  <link rel="stylesheet" href="css/style.css" title="style1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
  <style>
    html{
      overflow-x:hidden;
      overflow-y:hidden;
    }
    .main-title{
      border-style:solid;
      border-color:black;
      margin:50px 30px 100px 30px;
      padding-top:40px;
      padding-bottom: 40px;
      text-align:center;
    }

  </style>
</head>
<body>
<div class="main-title">Title</div>
<div class="col-md-15">
  <div class="modal-dialog" style="margin-bottom:0">
    <div class="panel panel-group panel-default">
      <div class="panel-heading">
        <h2>Sign In</h2>
      </div>
      <div class="panel-body">
        <form role="form" method="post" action="LoginCheck">
          <fieldset>
            <div class="form-group">
              <input class="form-control" placeholder="Enter your ID" name="id" >
            </div>
            <div class="form-group">
              <input class="form-control" placeholder="Enter your password" name="pwd" type="password">
            </div>
            <div class="checkbox">
              <label>
                <input name="remember" type="checkbox" value="Remember Me">Remember Me
              </label>
            </div>
              <input type="submit" class="btn btn-sm btn-success" value="submit">
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
