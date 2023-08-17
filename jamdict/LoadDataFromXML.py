import os
import logging
import threading

def getLogger():
    return logging.getLogger(__name__)

def jmne_xml(self):
    if not jmne_xml and jmnedict_xml_file:
        with threading.Lock():
            getLogger().info("Loading JMnedict from XML file at {}".format(jmnedict_xml_file))
            self._jmne_xml = JMNEDictXML.from_file(self.jmnedict_xml_file)
            getLogger().info("Loaded JMnedict entries: {}".format(len(_jmne_xml)))
    return self._jmne_xml


def import_data(self):
    # import JMNEdict
    if jmne_xml is not None and os.path.isfile(self.jmnedict_xml_file):
        getLogger().info("Importing JMNEdict data")
        if self.jmdict is not None and self.jmnedict_file == self.db_file:
            self.jmnedict.insert_name_entities(self.jmne_xml, ctx=ctx)
        elif self.jmnedict is not None:
            getLogger().warning(f"Building Kanjidic2 DB using a different DB context {self.jmne_file} vs {self.db_file}")
            with self.jmnedict.ctx() as ne_ctx:
                self.jmnedict.insert_name_entities(self.jmne_xml, ctx=ne_ctx)
        else:
            getLogger().warning(f"JMNE DB path could not be found")
    else:
        getLogger().warning("JMNEdict XML data is not available - skipped!")
    _buckmode_off = getattr(ctx, "buckmode_off", None)
    if _buckmode_off is not None:
        _buckmode_off()
    ctx.commit()

