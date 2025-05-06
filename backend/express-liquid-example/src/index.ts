import express from "express";
import type { Application } from "express";
import cors from "cors";
import { Liquid } from "liquidjs";

const app: Application = express();
const port: number = 3000;

app.use(cors());

const engine = new Liquid({
  root: __dirname + "/tpl",
  cache: true,
});

app.engine("liquid", engine.express());
app.set("view engine", "liquid");
app.set("views", __dirname + "/tpl");

app.get("/", (req, res) => {
  res.render("hello", {
    title: "Hello World",
    message: "Hello World",
  });
});

app.listen(port, () => {
  console.log(`Example app listening on  http://localhost:${port}`);
});
