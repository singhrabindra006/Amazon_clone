const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser) {
      return res.status(400).json({
        msg: "User with same email already exists.",
      });
    }
    const hasedPassword = await bcryptjs.hash(password, 8);

    const user = new User({
      name,
      email,
      password: hasedPassword,
    });

    const savedUser = await user.save();

    res.json(savedUser);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({
      email,
    });

    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email doesnot exist" });
    }

    const isMatched = await bcryptjs.compare(password, user.password);

    if (!isMatched) {
      return res.status(400).json({ msg: "Incorrect Password." });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");

    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = authRouter;
