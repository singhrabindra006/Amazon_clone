const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = 3000;
const app = express();

// Parse incoming JSON requests
app.use(express.json());

app.use(authRouter);

mongoose
  .connect("mongodb://127.0.0.1:27017/amazon_clone")
  .then(() => {
    console.log("MongoDB Connected Successfully");
  })
  .catch((err) => {
    console.log("MongoDB Connection Error:", err.message);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connected at port ${PORT}`);
});
