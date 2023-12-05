<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DSS Monitoring</title>
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            background-color: #1e1e1e;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #4caf50;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #333;
            color: #ffffff;
        }

        label, select, input {
            margin: 10px;
        }

        select, input {
            padding: 8px;
        }

        /* Navigation bar style */
        .navbar {
            background-color: #333;
            overflow: hidden;
        }

        .navbar a {
            float: right;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            margin-left: 10px;
        }

        .update-button {
            margin-left: 1330px;
            background-color: #4caf50;
            border: none;
            padding: 8px 15px;
            font-size: 14px;
            cursor: pointer;
            border-radius: 7px;
            margin-top: 8px;
            transition: background-color 0.3s ease;
        }

        .update-button:hover {
            background-color: #45a049;
        }

        /* Loading animation styles */
        #loadingContainer {
            display: none;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 9999;
        }

        .loading-circle {
            border: 4px dotted #ffffff;
            border-radius: 50%;
            border-top: 4px dotted #4caf50;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>

<body>
    <div class="navbar">
        <button class="update-button" onclick="runUpdateScript()">Update</button>
        <a href="/logout">Logout</a>
    </div>

    <div class="loading-container" id="loadingContainer">
        <div class="loading-circle"></div>
    </div>

    <h2>DSS Monitoring</h2>
    <label for="filterSelect">Filter by: </label>
    <select id="filterSelect">
        <option value="serverip">Server IP</option>
        <option value="timestamp">Timestamp</option>
        <option value="event">Event</option>
        <option value="username">Username</option>
        <option value="userip">User IP</option>
        <option value="command">Command</option>
    </select>
    <input type="text" id="filterInput" placeholder="Enter filter value" onkeydown="filterTable(event)">

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Server IP</th>
                <th>Timestamp</th>
                <th>Event</th>
                <th>Username</th>
                <th>User IP</th>
                <th>Command</th>
            </tr>
        </thead>
        <tbody id="eventTableBody">
            <!-- Table rows will be dynamically added here -->
        </tbody>
    </table>

    <script>
        var events; // Global variable to store events data

        // Function to fetch events data
        function fetchEvents() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        events = JSON.parse(xhr.responseText);
                        renderEvents(events);
                    } else {
                        console.error('Error fetching events:', xhr.statusText);
                    }
                }
            };
            xhr.open('GET', 'http://192.168.234.130:8080/rawdata', true);
            xhr.send();
        }

        // Function to render events
        function renderEvents(eventsData) {
            var tableBody = document.getElementById('eventTableBody');

            // Clear existing rows
            tableBody.innerHTML = '';

            // Sort events by ID in descending order
            eventsData.sort(function (a, b) {
                return b.id - a.id;
            });

            // Iterate over events, create table rows, and reassign IDs starting from 1
            for (var i = 0; i < eventsData.length; i++) {
                var event = eventsData[i];

                // Create a new row
                var row = tableBody.insertRow(i);

                // Add cells and populate with data
                var idCell = row.insertCell(0);
                var serverIpCell = row.insertCell(1);
                var timestampCell = row.insertCell(2);
                var eventCell = row.insertCell(3);
                var usernameCell = row.insertCell(4);
                var userIpCell = row.insertCell(5);
                var commandCell = row.insertCell(6);

                // Reassign IDs starting from 1
                idCell.innerHTML = i + 1;

                // Populate other cells with data
                serverIpCell.innerHTML = event.serverip;
                timestampCell.innerHTML = event.timestamp;
                eventCell.innerHTML = event.event;
                usernameCell.innerHTML = event.username;
                userIpCell.innerHTML = event.userip;
                commandCell.innerHTML = event.command;
            }
        }

        // Function to filter the table
        function filterTable(event) {
            if (event.key === 'Enter') {
                var filterSelect = document.getElementById('filterSelect');
                var filterInput = document.getElementById('filterInput');
                var selectedFilter = filterSelect.options[filterSelect.selectedIndex].value;
                var filterValue = filterInput.value.toLowerCase();

                var filteredEvents = events.filter(function (event) {
                    if (selectedFilter === 'command') {
                        return event.command.toLowerCase().includes(filterValue);
                    } else {
                        return event[selectedFilter].toLowerCase().includes(filterValue);
                    }
                });

                renderEvents(filteredEvents);
            }
        }

        // Function to run the "monitorlinux.sh" script
        function runUpdateScript() {
            // Show loading animation
            document.getElementById('loadingContainer').style.display = 'flex';

            // Set a timeout to hide the loading animation after 5 seconds
            setTimeout(function () {
                document.getElementById('loadingContainer').style.display = 'none';

                // Refresh the page
                location.reload();
            }, 5000);

            // You can add further handling for the script execution
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        console.log('Script execution successful');
                        // You can add further handling if needed
                    } else {
                        console.error('Error executing script:', xhr.statusText);
                    }
                }
            };
            xhr.open('GET', 'http://192.168.234.130:8080/runscript', true);
            xhr.send();
        }

        // Call the function when the page loads
        window.onload = function () {
            fetchEvents();

            // Disable back and forward buttons
            history.pushState(null, null, document.URL);
            window.addEventListener('popstate', function () {
                history.pushState(null, null, document.URL);
            });

            // Disable back and forward buttons
            window.history.forward();
            function noBack() { window.history.forward(); }
            document.onkeydown = noBack;
            document.onkeypress = noBack;
            document.onkeyup = noBack;
        };
    </script>
</body>

</html>
