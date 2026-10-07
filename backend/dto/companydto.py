"""DTO firmy (tabela companies) – uzywane przy logowaniu."""

from dataclasses import dataclass
from typing import Optional
from model.models import Company  # model ORM (SQLAlchemy)

@dataclass
class CompanyDTO:
    id: Optional[int]
    name: str
    login: str
    password: str  # haslo z tabeli companies (nie zwracac go na zewnatrz!)

    @classmethod
    def from_orm(cls, orm_obj: Company) -> "CompanyDTO":
        return cls(
            id=orm_obj.id,
            name=orm_obj.name,
            login=orm_obj.login,
            password=orm_obj.password
        )

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "login": self.login,
            "password": self.password,
        }

    def to_orm(self) -> Company:
        return Company(
            id=self.id,
            name=self.name,
            login=self.login,
            password=self.password
        )
