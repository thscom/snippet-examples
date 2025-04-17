from typing import List, Sequence
from fastapi import APIRouter
from sqlmodel import select

from deps import SessionDep
from model.user import User

router = APIRouter()


@router.post("/users", response_model=User, tags=["user"])
async def create_user(session: SessionDep):
    user: User = User(username="test", password="test")
    session.add(user)
    session.commit()
    session.refresh(user)
    return user


@router.get("/users", response_model=List[User], tags=["user"])
async def find_all_users(session: SessionDep):
    users: Sequence[User] = session.exec(select(User)).all()
    return users
