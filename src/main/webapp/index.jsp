<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smartphone Sales Application</title>
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
    <br>
    <label for="name">Name:</label>
    <input type="text" name="name" id="name" required>
    <br>
    <label for="email">Email:</label>
    <input type="email" name="email" id="email" required>
    <br>
    <label for="address">Shipping Address:</label>
    <textarea name="address" id="address" rows="4" required></textarea>
    <br>
    <button type="submit">Submit Order</button>
  </form>
</body>
</html>
