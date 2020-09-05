UPDATE ms_access_migration.badbits SET badbits.BitField1 = 0
WHERE badbits.BitField1 Is Null;

UPDATE ms_access_migration.badbits SET badbits.BitField2 = 0
WHERE badbits.BitField2 Is Null;
