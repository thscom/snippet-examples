import { Schema } from "mongoose";

const ObjectId = Schema.ObjectId;

export const UserSchema = new Schema({
  id: ObjectId,
  name: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
});
