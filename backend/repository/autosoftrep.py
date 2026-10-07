"""
Warstwa dostepu do bazy danych (repozytorium) dla API Flask.

Kazda metoda otwiera wlasna, krotka sesje SQLAlchemy (patrz get_db_session),
wykonuje zapytanie i zwraca obiekty DTO (proste dataclassy), a nie obiekty ORM.
Dzieki temu wynik mozna bezpiecznie uzyc juz po zamknieciu sesji
(np. w jsonify w kontrolerze).
"""

import os
from contextlib import contextmanager
from datetime import datetime, timezone
from typing import Optional

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

from model.models import (
    Base, Company, Machine, MachineDataORM,
    MachinePartStat, MachinePartErrorOccurrence,
    MachinePart, MachinePartError, MachineError
)

from dto.machine import MachineDTO
from dto.companydto import CompanyDTO
from dto.machine_data import MachineDataDTO
from dto.machine_part_stat import MachinePartStatDTO
from dto.machine_error import ErrorDTO
from dto.machine_part import MachinePartDTO
from dto.machine_part_error_occurrence import MachinePartErrorOccurrenceDTO
from dto.machine_part_error import MachinePartErrorDTO

# Adres bazy mozna nadpisac zmienna srodowiskowa DATABASE_URL.
# Domyslna wartosc dziala dla kontenera backendu uruchomionego w Docker Desktop
# (Windows/Mac), gdzie Postgres jest wystawiony na porcie 5432 hosta.
DATABASE_URL = os.environ.get(
    "DATABASE_URL",
    "postgresql+psycopg2://postgres:Test1234!@host.docker.internal:5432/postgres",
)

# pool_pre_ping=True – przed uzyciem polaczenia z puli sprawdza, czy baza
# nadal odpowiada (np. po restarcie kontenera Postgresa).
engine = create_engine(DATABASE_URL, echo=False, pool_pre_ping=True)

# Tworzy brakujace tabele (istniejacych nie modyfikuje – to nie sa migracje).
Base.metadata.create_all(engine)

# expire_on_commit=False – obiekty ORM zachowuja wartosci po commicie,
# wiec mozna je czytac rowniez po zamknieciu sesji.
SessionLocal = scoped_session(sessionmaker(bind=engine, expire_on_commit=False))


def _utcnow() -> datetime:
    """Aktualny czas UTC bez strefy (kolumny w bazie sa typu TIMESTAMP bez strefy)."""
    return datetime.now(timezone.utc).replace(tzinfo=None)


@contextmanager
def get_db_session():
    """Sesja z automatycznym commitem (lub rollbackiem przy wyjatku) i zamknieciem."""
    session = SessionLocal()
    try:
        yield session
        session.commit()
    except Exception:
        session.rollback()
        raise
    finally:
        session.close()


class AutoSoftRepository:

    # ------------------ COMPANY / MACHINE ------------------
    def create_company(self, name: str, login: str, password: str) -> Company:
        # login i password sa w modelu NOT NULL, wiec musza zostac podane
        with get_db_session() as session:
            company = Company(name=name, login=login, password=password)
            session.add(company)
            session.flush()
            return company

    def create_machine(self, company_id: int, name: str, config: Optional[dict] = None) -> Machine:
        with get_db_session() as session:
            machine = Machine(company_id=company_id, name=name, config=config or {})
            session.add(machine)
            session.flush()
            return machine

    def get_company_with_login(self, login: str) -> Optional[CompanyDTO]:
        with get_db_session() as session:
            orm_object = session.query(Company).filter_by(login=login).first()
            if orm_object:
                return CompanyDTO.from_orm(orm_object)
            return None

    # ------------------ MACHINE DATA ------------------
    def add_machine_data(self, machine_id: int, is_running: bool, has_error: bool,
                         cycle_completed: int, tag1=None, tag2=None, tag3=None, tag4=None) -> MachineDataORM:
        with get_db_session() as session:
            data = MachineDataORM(
                machine_id=machine_id,
                is_running=is_running,
                has_error=has_error,
                cycle_completed=cycle_completed,
                tag1=tag1,
                tag2=tag2,
                tag3=tag3,
                tag4=tag4
            )
            session.add(data)
            session.flush()
            return data

    def get_all_machine_data_dto(self):
        with get_db_session() as session:
            orm_objects = session.query(MachineDataORM).all()
            return [MachineDataDTO.from_orm(obj) for obj in orm_objects]

    def get_machine_data_dto_by_id(self, machine_id: int):
        with get_db_session() as session:
            results = session.query(MachineDataORM).filter_by(machine_id=machine_id).all()
            return [MachineDataDTO.from_orm(obj) for obj in results]

    def get_machine_data_by_id_and_time_range(self, machine_id: int, start_time, end_time):
        with get_db_session() as session:
            results = (
                session.query(MachineDataORM)
                .filter(MachineDataORM.machine_id == machine_id)
                .filter(MachineDataORM.timestamp >= start_time)
                .filter(MachineDataORM.timestamp <= end_time)
                .all()
            )
            return [MachineDataDTO.from_orm(obj) for obj in results]

    def get_all_machine_data_by_company_id_dto(self, company_id: int):
        with get_db_session() as session:
            results = (
                session.query(MachineDataORM)
                .join(Machine)
                .filter(Machine.company_id == company_id)
                .all()
            )
            return [MachineDataDTO.from_orm(obj) for obj in results]

    # ------------------ MACHINE ------------------
    def get_machines(self):
        with get_db_session() as session:
            orm_objects = session.query(Machine).all()
            return [MachineDTO.from_orm(obj) for obj in orm_objects]

    def get_machines_dto_by_company_id(self, company_id: int):
        with get_db_session() as session:
            orm_objects = session.query(Machine).filter_by(company_id=company_id).all()
            return [MachineDTO.from_orm(obj) for obj in orm_objects]

    def get_machine_config(self, machine_id: int) -> dict:
        """Zwraca konfiguracje maszyny (kolumna JSONB). ValueError, gdy maszyny nie ma."""
        with get_db_session() as session:
            machine = session.get(Machine, machine_id)
            if not machine:
                raise ValueError(f"Machine with id {machine_id} not found")
            return machine.config or {}

    def update_machine_config(self, machine_id: int, new_config: dict) -> None:
        """Nadpisuje konfiguracje maszyny. ValueError, gdy maszyny nie ma."""
        with get_db_session() as session:
            machine = session.get(Machine, machine_id)
            if not machine:
                raise ValueError(f"Machine with id {machine_id} not found")
            machine.config = new_config
            # commit wykona get_db_session po wyjsciu z bloku

    # ------------------ ERRORS (stara tabela 'errors') ------------------
    def get_all_errors_by_company_id(self, company_id: int):
        with get_db_session() as session:
            results = (
                session.query(MachineError)
                .join(Machine)
                .filter(Machine.company_id == company_id)
                .all()
            )
            return [ErrorDTO.from_orm(obj) for obj in results]

    def get_error_by_machine_id(self, machine_id: int):
        with get_db_session() as session:
            results = session.query(MachineError).filter(MachineError.machine_id == machine_id).all()
            return [ErrorDTO.from_orm(obj) for obj in results]

    # ------------------ MACHINE PARTS ------------------
    def get_machine_parts_by_machine_id(self, machine_id: int):
        with get_db_session() as session:
            results = session.query(MachinePart).filter_by(machine_id=machine_id).all()
            return [MachinePartDTO.from_orm(obj) for obj in results]

    def get_errors_for_part(self, part_id: int):
        """Slownik alarmow (machine_part_errors) zdefiniowanych dla danej czesci."""
        with get_db_session() as session:
            results = session.query(MachinePartError).filter_by(part_id=part_id).all()
            return [MachinePartErrorDTO.from_orm(obj) for obj in results]

    # ------------------ WYSTAPIENIA ALARMOW ------------------
    def get_occurrences_by_machine_id(self, machine_id: int):
        with get_db_session() as session:
            results = (
                session.query(MachinePartErrorOccurrence)
                .join(MachinePart, MachinePart.id == MachinePartErrorOccurrence.part_id)
                .filter(MachinePart.machine_id == machine_id)
                .all()
            )
            return [MachinePartErrorOccurrenceDTO.from_orm(obj) for obj in results]

    def get_all_occurrences(self):
        with get_db_session() as session:
            results = session.query(MachinePartErrorOccurrence).all()
            return [MachinePartErrorOccurrenceDTO.from_orm(obj) for obj in results]

    def get_occurrences_by_part_id_and_date(self, part_id: int, date_from: datetime):
        """Wystapienia alarmow danej czesci od date_from."""
        with get_db_session() as session:
            results = (
                session.query(MachinePartErrorOccurrence)
                .filter(MachinePartErrorOccurrence.part_id == part_id)
                .filter(MachinePartErrorOccurrence.occurred_at >= date_from)
                .all()
            )
            return [MachinePartErrorOccurrenceDTO.from_orm(obj) for obj in results]

    def get_error_ids_for_part_in_date_range(self, part_id: int, date_from: datetime):
        """Lista error_id wystapien dla czesci od date_from."""
        with get_db_session() as session:
            results = (
                session.query(MachinePartErrorOccurrence.error_id)
                .filter(MachinePartErrorOccurrence.part_id == part_id)
                .filter(MachinePartErrorOccurrence.occurred_at >= date_from)
                .all()
            )
            return [row[0] for row in results]

    def get_error_code_for_part_in_date_range(self, part_id: int, date_from: datetime):
        """Unikalne kody alarmow (np. 'A305') dla czesci od date_from."""
        with get_db_session() as session:
            results = (
                session.query(MachinePartErrorOccurrence.error_code)
                .filter(MachinePartErrorOccurrence.part_id == part_id)
                .filter(MachinePartErrorOccurrence.occurred_at >= date_from)
                .distinct()
                .all()
            )
            return [row[0] for row in results]

    def get_last_errors(self, machine_id: int, limit: int = 10):
        """Ostatnie `limit` wystapien alarmow dla maszyny (najnowsze pierwsze)."""
        with get_db_session() as session:
            results = (
                session.query(MachinePartErrorOccurrence)
                .join(MachinePart, MachinePart.id == MachinePartErrorOccurrence.part_id)
                .filter(MachinePart.machine_id == machine_id)
                .order_by(MachinePartErrorOccurrence.id.desc())
                .limit(limit)
                .all()
            )
            return [MachinePartErrorOccurrenceDTO.from_orm(obj) for obj in results]

    def get_error_code_for_machine_in_date_range(self, machine_id: int, date_from: datetime):
        """Wystapienia alarmow (pelne rekordy) dla calej maszyny od date_from."""
        with get_db_session() as session:
            results = (
                session.query(MachinePartErrorOccurrence)
                .join(MachinePart, MachinePart.id == MachinePartErrorOccurrence.part_id)
                .filter(MachinePart.machine_id == machine_id)
                .filter(MachinePartErrorOccurrence.occurred_at >= date_from)
                .all()
            )
            return [MachinePartErrorOccurrenceDTO.from_orm(obj) for obj in results]

    # ------------------ LICZNIKI CZESCI ------------------
    def get_stats_for_machine(self, machine_id: int):
        """Liczniki/stany (machine_part_stats) wszystkich czesci maszyny."""
        with get_db_session() as session:
            results = (
                session.query(MachinePartStat)
                .join(MachinePart, MachinePart.id == MachinePartStat.part_id)
                .filter(MachinePart.machine_id == machine_id)
                .all()
            )
            return [MachinePartStatDTO.from_orm(obj) for obj in results]

    def update_machine_part_stat(self, part_id: int, counter: int, is_empty: bool) -> bool:
        """
        Aktualizuje rekordy w tabeli machine_part_stats dla danej czesci.
        Zwraca True, jesli cos zaktualizowano, False jesli nie ma takiego part_id.
        """
        with get_db_session() as session:
            updated = (
                session.query(MachinePartStat)
                .filter(MachinePartStat.part_id == part_id)
                .update({"counter": counter, "is_empty": is_empty}, synchronize_session=False)
            )
            # commit nastapi automatycznie po wyjsciu z kontekstu
            return updated > 0

    def insert_part_error_occurrences(self, error_ids: list[int]) -> bool:
        """
        Dodaje wystapienia (machine_part_error_occurrences) dla podanych error_id
        na podstawie slownika machine_part_errors.
        Zwraca True, jesli dodano rekordy, False gdy lista byla pusta
        lub zadne ID nie istnieje w slowniku.
        """
        if not error_ids:
            return False

        with get_db_session() as session:
            errors = session.query(MachinePartError).filter(MachinePartError.id.in_(error_ids)).all()
            if not errors:
                return False

            now = _utcnow()
            occurrences = [
                MachinePartErrorOccurrence(
                    error_id=e.id,
                    part_id=e.part_id,
                    occurred_at=now,
                    error_code=e.error_code,
                    description=e.description
                )
                for e in errors
            ]

            session.add_all(occurrences)
            # commit nastapi automatycznie po wyjsciu z context managera
            return True
