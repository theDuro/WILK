"""DTO probki danych procesowych maszyny (tabela machine_data)."""

from dataclasses import dataclass, field
from datetime import datetime
from typing import Optional

from model.models import MachineDataORM

@dataclass
class MachineDataDTO:
    machine_id: int
    is_running: bool
    has_error: bool
    cycle_completed: int
    tag1: Optional[float]
    tag2: Optional[float]
    tag3: Optional[float]
    tag4: Optional[float]
    timestamp: datetime = field(default_factory=datetime.now)

    @classmethod
    def from_dict(cls, data: dict) -> "MachineDataDTO":
        return cls(
            machine_id=data["machine_id"],
            is_running=data["is_running"],
            has_error=data["has_error"],
            cycle_completed=data["cycle_completed"],
            tag1=data.get("tag1"),
            tag2=data.get("tag2"),
            tag3=data.get("tag3"),
            tag4=data.get("tag4"),
            timestamp=datetime.now()
        )

    def to_dict(self):
        return {
            "machine_id": self.machine_id,
            "is_running": self.is_running,
            "has_error": self.has_error,
            "cycle_completed": self.cycle_completed,
            "tag1": self.tag1,
            "tag2": self.tag2,
            "tag3": self.tag3,
            "tag4": self.tag4,
            "timestamp": self.timestamp.isoformat() if self.timestamp else None
        }

    @classmethod
    def from_orm(cls, orm_obj: MachineDataORM) -> "MachineDataDTO":
        return cls(
            machine_id=orm_obj.machine_id,
            is_running=orm_obj.is_running,
            has_error=orm_obj.has_error,
            cycle_completed=orm_obj.cycle_completed,
            tag1=orm_obj.tag1,
            tag2=orm_obj.tag2,
            tag3=orm_obj.tag3,
            tag4=orm_obj.tag4,
            timestamp=orm_obj.timestamp
        )

    def to_orm(self) -> MachineDataORM:
        return MachineDataORM(
            machine_id=self.machine_id,
            is_running=self.is_running,
            has_error=self.has_error,
            cycle_completed=self.cycle_completed,
            tag1=self.tag1,
            tag2=self.tag2,
            tag3=self.tag3,
            tag4=self.tag4,
            timestamp=self.timestamp
        )
