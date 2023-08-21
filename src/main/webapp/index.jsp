<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smartphone Sales Application</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
  }
  h1 {
    color: #333;
    text-align: center;
    padding: 20px;
  }
  form {
    max-width: 400px;
    margin: 0 auto;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
  }
  select, input[type="text"], input[type="email"], textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
  }
  select {
    appearance: none;
    background-color: #f9f9f9;
  }
  textarea {
    resize: vertical;
  }
  button[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
  }
  button[type="submit"]:hover {
    background-color: #0056b3;
  }
</style>
</head>
<body>
  <h1>Smartphone Sales Application</h1>
  <form action="submit_order.php" method="post">
    <label for="model">Select Smartphone Model:</label>
    <select name="model" id="model">
      <option value="iphone">iPhone</option>
      <option value="samsung">Samsung Galaxy</option>
      <option value="google">Google Pixel</option>
      <option value="oneplus">OnePlus</option>
    </select>
    <label for="name">Name:</label>
    <input type="text" name="name" id="name" required>
    <label for="email">Email:</label>
    <input type="email" name="email" id="email" required>
    <label for="address">Shipping Address:</label>
    <textarea name="address" id="address" rows="4" required></textarea>
    <button type="submit">Submit Order</button>
  </form>
</body>
</html>
