from puchikarui import ExecutionContext
import logging
import os
import threading


def getLogger():
    return logging.getLogger(__name__)

reuse_ctx=True
__jm_ctx = None
db_file = "C:\\Users\\de925289\\Downloads\\PythonExperiment\\LoadJmdictToDatabase\\jamdict\\data\\JMdict_e"
_db_sqlite = None

def __make_db_ctx() -> ExecutionContext:
    """ Try to reuse context if allowed """
    try:
        if not reuse_ctx:
            return jmdict.ctx()
        elif __jm_ctx is None and db_file and (db_file == ":memory:" or os.path.isfile(db_file)):
            __jm_ctx = jmdict.ctx()
    except Exception:
        getLogger().warning("JMdict data could not be accessed.")
    return __jm_ctx

def jmdict(self):
    if not _db_sqlite and self.db_file:
        with threading.Lock():
            _db_sqlite = JamdictSQLite(data_source, auto_expand_path=self.auto_expand)
    return _db_sqlite