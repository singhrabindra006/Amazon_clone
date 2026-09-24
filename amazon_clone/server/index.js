const express = require("express");
const mongoose = require("mongoose");

// IMPORTS FROM OTHER FILES
const authRouter = require("./routes/auth");

// INIT
const PORT = 3000;

const app = express();

// MIDDLEWARE
// CLIENT -> SERVER -> CLIENT
app.use(express.json()); // Allows server to read JSON data

app.use("/api", authRouter);

// CONNECTION
mongoose
  .connect("mongodb://127.0.0.1:27017/amazon_clone")
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at Port ${PORT}`);
});
