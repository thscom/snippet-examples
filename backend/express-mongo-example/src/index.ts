import express from "express";
import type { Application } from "express";
import { pinoHttp } from "pino-http";
import pretty from "pino-pretty";
import cors from "cors";
import { IndexHandler } from "./handler";
import { SwaggerSetup } from "./swagger";
import { initializeDatabase } from "./schema";

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

initializeDatabase();

app.get("/", IndexHandler);

app.listen(port, () => {
  console.log(`App listening on http://localhost:${port}`);
});
