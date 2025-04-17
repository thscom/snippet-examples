import mongoose from "mongoose";
import { UserSchema } from "./user";

export function initializeDatabase() {
  mongoose
    .connect("mongodb://127.0.0.1/", {
      user: "root",
      pass: "example",
      dbName: "test",
    })
    .then(async () => {
      console.log("Database connected");
    })
    .catch((error) => console.log(error));
}

export const User = mongoose.model("User", UserSchema);
