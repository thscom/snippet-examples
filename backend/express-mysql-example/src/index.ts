import "reflect-metadata";
import { AppDataSource } from "./database";
import express from "express";
import type { Application } from "express";
import { pinoHttp } from "pino-http";
import pretty from "pino-pretty";
import cors from "cors";
import { IndexHandler } from "./handler";
import { SwaggerSetup } from "./swagger";

const app: Application = express();
const port = 3000;

app.use(cors());

app.use(
  pinoHttp(
    pretty({
      colorize: true,
      ignore: "pid,hostname,req,res,responseTime",
      messageFormat: `{req.method} {req.url} {res.statusCode} {msg}`,
    })
  )
);

SwaggerSetup(app);

AppDataSource.initialize()
  .then(async () => {
    console.log("Database connected");
  })
  .catch((error) => console.log(error));

app.get("/", IndexHandler(AppDataSource));

app.listen(port, () => {
  console.log(`App listening on http://localhost:${port}`);
});
