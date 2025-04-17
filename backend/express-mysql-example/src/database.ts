import { DataSource } from 'typeorm'
import { User } from './entity'

export const AppDataSource = new DataSource({
    type: "mysql",
    host: "localhost",
    port: 3306,
    username: "root",
    password: "example",
    database: "test",
    synchronize: true,
    logging: true,
    entities: [User],
    subscribers: [],
    migrations: [],
})