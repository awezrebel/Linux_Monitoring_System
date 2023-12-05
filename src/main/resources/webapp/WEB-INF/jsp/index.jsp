<html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Page</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #3498db, #6c5ce7);
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }

    .login-container {
      background-color: #fff;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      width: 400px;
      text-align: center;
    }

    .login-container h2 {
      color: #333;
      margin-bottom: 20px;
      font-size: 24px;
      font-weight: bold;
    }

    .login-form {
      display: flex;
      flex-direction: column;
      margin-top: 20px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      font-size: 16px;
      margin-bottom: 8px;
      display: block;
      color: #555;
    }

    .form-group input {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      font-size: 16px;
    }

    .login-btn {
      background: linear-gradient(to right, #3498db, #6c5ce7);
      color: #fff;
      padding: 12px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 18px;
      transition: background 0.3s ease;
    }

    .login-btn:hover {
      background: linear-gradient(to right, #2980b9, #5a4bd1);
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>Linux User Monitoring</h2>
    <form class="login-form">
      <div class="form-group">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="Enter your username" required>
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
      </div>
      <button type="submit" class="login-btn">Login</button>
    </form>

    <script>
        function submitLoginForm() {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            const loginData = {
                username: username,
                password: password
            };

            // Make an AJAX request to the Spring Boot API
            fetch('http://localhost:8080/api/login/verify', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(loginData),
            })
            .then(response => response.json())
            .then(data => {
                alert(data); // Show the response from the server
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
  </div>
</body>
</html>
