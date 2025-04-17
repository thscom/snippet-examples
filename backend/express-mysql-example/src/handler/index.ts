import type { Request, Response } from 'express'
import { DataSource } from "typeorm"
import { User } from "../entity"


export function IndexHandler(dataSource: DataSource) {
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
    return async (req: Request, res: Response) => {
        const manager = dataSource.getRepository(User)
        const users = await manager.find()
        // const user = new User()
        // user.name = "Timber"
        // user.email = "Saw@test.com"
        // user.password = "xxx"
        // await .save(user)
        req.log.info('Hello World!')
        res.json(users)
    }
} 