import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'


@Entity()
export class User {
    @PrimaryGeneratedColumn()
    id!: number;

    @Column("varchar", { length: 256, unique: true }) 
    name!: string;

    @Column("varchar", { length: 128, unique: true })
    email!: string;

    @Column("text")
    password!: string;
}