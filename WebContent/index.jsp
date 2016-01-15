<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
	<head>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <title>Home for Administrator</title>
	  <link rel="stylesheet" href="css/style.css" title="style1">
	  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" title="style1">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	  <script src="https://apis.google.com/js/client.js?onload=checkAuth"></script>
	  <script type="text/javascript">
	    // Your Client ID can be retrieved from your project in the Google
	    // Developer Console, https://console.developers.google.com
	    var CLIENT_ID = '214179547583-5r5al6lfbmvpdbgcaj8bgru2t5sdvgqk.apps.googleusercontent.com';
	
	    var SCOPES = ["https://www.googleapis.com/auth/calendar.readonly"];
	
	    /**
	     * Check if current user has authorized this application.
	     */
	    function checkAuth() {
	      gapi.auth.authorize(
	        {
	          'client_id': CLIENT_ID,
	          'scope': SCOPES.join(' '),
	          'immediate': true
	        }, handleAuthResult);
	    }
	
	    /**
	     * Handle response from authorization server.
	     *
	     * @param {Object} authResult Authorization result.
	     */
	    function handleAuthResult(authResult) {
	      var authorizeDiv = document.getElementById('authorize-div');
	      if (authResult && !authResult.error) {
	        // Hide auth UI, then load client library.
	        authorizeDiv.style.display = 'none';
	        loadCalendarApi();
	      } else {
	        // Show auth UI, allowing the user to initiate authorization by
	        // clicking authorize button.
	        authorizeDiv.style.display = 'inline';
	      }
	    }
	
	    /**
	     * Initiate auth flow in response to user clicking authorize button.
	     *
	     * @param {Event} event Button click event.
	     */
	    function handleAuthClick(event) {
	      gapi.auth.authorize(
	        {client_id: CLIENT_ID, scope: SCOPES, immediate: false},
	        handleAuthResult);
	      return false;
	    }
	
	    /**
	     * Load Google Calendar client library. List upcoming events
	     * once client library is loaded.
	     */
	    function loadCalendarApi() {
	      gapi.client.load('calendar', 'v3', listUpcomingEvents);
	    }
	
	    /**
	     * Print the summary and start datetime/date of the next ten events in
	     * the authorized user's calendar. If no events are found an
	     * appropriate message is printed.
	     */
	    function listUpcomingEvents() {
	      var request = gapi.client.calendar.events.list({
	        'calendarId': 'primary',
	        'timeMin': (new Date()).toISOString(),
	        'showDeleted': false,
	        'singleEvents': true,
	        'maxResults': 10,
	        'orderBy': 'startTime'
	      });
	
	      request.execute(function(resp) {
	        var events = resp.items;
	        appendPre('Upcoming events:');
	
	        if (events.length > 0) {
	          for (i = 0; i < events.length; i++) {
	            var event = events[i];
	            var when = event.start.dateTime;
	            if (!when) {
	              when = event.start.date;
	            }
	            appendPre(i+1 + ". " + event.summary + ' (' + when + ')')
	          }
	        } else {
	          appendPre('No upcoming events found.');
	        }
	
	      });
	    }
	
	    /**
	     * Append a pre element to the body containing the given message
	     * as its text node.
	     *
	     * @param {string} message Text to be placed in pre element.
	     */
	    function appendPre(message) {
	      var pre = document.getElementById('output');
	      var textContent = document.createTextNode(message + '\n');
	      pre.appendChild(textContent);
	    }
	
	  </script>
	  
	</head>

	<body>
				<!--session timeout-->
		<%
			String memberId = (String)session.getAttribute("id");
			
			boolean login = (memberId == null) ? false : true;
			if(!login) {
			  response.sendRedirect("login.jsp");
			}
			else {
		%>
		
		<jsp:include page="/view/nav.jsp" flush="false" />
		
		<div class="container">
		  <div id="login">
		    ID: ${id}<br>
		    Name: ${name}<br>
		    User level: ${level}<br>
		  </div>
		  <div id="announcement">
		    <h2>Announcement</h2>
		    <ul>
		      <li>announcement1</li>
		      <li>announcement2</li>
		      <li>announcement3</li>
		    </ul>
		  </div>
		  <div id="schedule">
		    <h2>Schedules</h2>
		
		    <div id="authorize-div" style="display: none">
		      <span>Authorize access to Google Calendar API</span>
		      <!--Button for the user to click to initiate auth sequence -->
		      <button id="authorize-button" onclick="handleAuthClick(event)">
		        Authorize
		      </button>
		    </div>
		    <pre id="output"></pre>
		  </div>
		</div>
		
		<% } %>
	</body>
</html>


