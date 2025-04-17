import type { Request, Response } from "express";
import { User } from "../schema";

/** @swagger
 *  /:
 *    get:
 *      summary: Get all users
 *      tags: [User]
 *      produces:
 *        - application/json
 *      operationId: getUsers
 *      description: Get all users
 *      responses:
 *        200:
 *          description: Returns all users
 */
export async function IndexHandler(req: Request, res: Response) {
  //   const user = new User();
  //   user.name = "Timber";
  //   user.email = "Saw@test.com";
  //   user.password = "xxx";
  //   await user.save();
  const users = await User.find({});
  req.log.info("Hello World!");
  res.json(users);
}
