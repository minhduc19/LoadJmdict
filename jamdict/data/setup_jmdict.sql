/* Add meta info */
CREATE TABLE IF NOT EXISTS meta (
       key TEXT PRIMARY KEY NOT NULL,
       value TEXT NOT NULL
);

-------------------------------------------------------------------------------------
-- JMDict
-------------------------------------------------------------------------------------

CREATE TABLE Entry (
	ID SERIAL PRIMARY KEY,
       idseq INTEGER NOT NULL UNIQUE
);

-- Entry's links (EntryInfo)
CREATE TABLE Link (
       ID SERIAL PRIMARY KEY
       ,idseq INTEGER
       ,tag TEXT
       ,description TEXT
       ,uri TEXT
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

-- Entry's bibinfo (EntryInfo)
CREATE TABLE Bib (
       ID SERIAL PRIMARY KEY
       ,idseq INTEGER
       ,tag TEXT
       ,text TEXT
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

-- Entry's etym (EntryInfo)
CREATE TABLE Etym (
	ID SERIAL PRIMARY KEY,
       idseq INTEGER
       ,text TEXT
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

-- Entry's audit (EntryInfo)
CREATE TABLE Audit (
	ID SERIAL PRIMARY KEY,
       idseq INTEGER
       ,upd_date TEXT
       ,upd_detl TEXT
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

-------------------------------------------------------------------------------------
-- Kanji reading(s) of an entry
-------------------------------------------------------------------------------------
CREATE TABLE Kanji (
       ID SERIAL PRIMARY KEY
       ,idseq INTEGER
       ,text TEXT
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

-- Kanji's info
CREATE TABLE KJI (
	ID SERIAL PRIMARY KEY,
       kid INTEGER
       ,text TEXT
       ,FOREIGN KEY (kid) REFERENCES Kanji(id)
);

-- Kanji priority
CREATE TABLE KJP (
	ID SERIAL PRIMARY KEY,
       kid INTEGER
       ,text TEXT
       ,FOREIGN KEY (kid) REFERENCES Kanji(id)
);

-------------------------------------------------------------------------------------
-- Kana reading(s) of an entry
-------------------------------------------------------------------------------------
CREATE TABLE Kana (
       ID SERIAL PRIMARY KEY
       ,idseq INTEGER
       ,text TEXT
       ,nokanji BOOLEAN
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

-- re_restr
CREATE TABLE KNR (
	ID SERIAL PRIMARY KEY,
       kid INTEGER
       ,text TEXT
       ,FOREIGN KEY (kid) REFERENCES Kana(id)
);

-- Kana's info
CREATE TABLE KNI (
	ID SERIAL PRIMARY KEY,
       kid INTEGER
       ,text TEXT
       ,FOREIGN KEY (kid) REFERENCES Kana(id)
);

-- Kana priority
CREATE TABLE KNP (
	ID SERIAL PRIMARY KEY,
       kid INTEGER
       ,text TEXT
       ,FOREIGN KEY (kid) REFERENCES Kana(id)
);

-------------------------------------------------------------------------------------
-- Senses of an entry
-------------------------------------------------------------------------------------
CREATE TABLE Sense (
       ID SERIAL PRIMARY KEY
       ,idseq INTEGER
       ,FOREIGN KEY (idseq) REFERENCES Entry(idseq)
);

CREATE TABLE stagk (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE stagr (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE pos (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE xref (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE antonym (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE field (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE misc (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE SenseInfo (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE SenseSource (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,lang TEXT
       ,lstype TEXT
       ,wasei TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE dialect (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

CREATE TABLE SenseGloss (
	ID SERIAL PRIMARY KEY,
       sid INTEGER
       ,lang TEXT
       ,gend TEXT
       ,text TEXT
       ,FOREIGN KEY (sid) REFERENCES Sense(id)
);

-------------------------------------------------------------------------------------
-- INDICES - JMDict
-------------------------------------------------------------------------------------

CREATE INDEX Link_idseq ON Link(idseq);
CREATE INDEX Link_tag ON Link(tag);
CREATE INDEX Bib_idseq ON Link(idseq);
CREATE INDEX Etym_idseq ON Etym(idseq);
CREATE INDEX Audit_idseq ON Audit(idseq);

CREATE INDEX Kanji_idseq ON Kanji(idseq);
CREATE INDEX Kanji_text ON Kanji(text);
CREATE INDEX KJI_kid ON KJI(kid);
CREATE INDEX KJP_kid ON KJP(kid);

CREATE INDEX Kana_idseq ON Kana(idseq);
CREATE INDEX Kana_text ON Kana(text);
CREATE INDEX KNR_kid ON KNR(kid);
CREATE INDEX KNR_text ON KNR(text);
CREATE INDEX KNI_kid ON KNI(kid);
CREATE INDEX KNI_text ON KNI(text);
CREATE INDEX KNP_kid ON KNP(kid);
CREATE INDEX KNP_text ON KNP(text);

CREATE INDEX Sense_idseq ON Sense(idseq);
CREATE INDEX stagk_sid ON stagk(sid);
CREATE INDEX stagk_text ON stagk(text);
CREATE INDEX stagr_sid ON stagr(sid);
CREATE INDEX stagr_text ON stagr(text);
CREATE INDEX pos_sid ON pos(sid);
CREATE INDEX pos_text ON pos(text);
CREATE INDEX xref_sid ON xref(sid);
CREATE INDEX xref_text ON xref(text);
CREATE INDEX antonym_sid ON antonym(sid);
CREATE INDEX antonym_text ON antonym(text);
CREATE INDEX field_sid ON field(sid);
CREATE INDEX field_text ON field(text);
CREATE INDEX misc_sid ON misc(sid);
CREATE INDEX misc_text ON misc(text);
CREATE INDEX SenseInfo_sid ON SenseInfo(sid);
CREATE INDEX SenseInfo_text ON SenseInfo(text);
CREATE INDEX SenseSource_sid ON SenseSource(sid);
CREATE INDEX SenseSource_text ON SenseSource(text);
CREATE INDEX dialect_sid ON dialect(sid);
CREATE INDEX dialect_text ON dialect(text);
CREATE INDEX SenseGloss_sid ON SenseGloss(sid);
CREATE INDEX SenseGloss_lang ON SenseGloss(lang);
CREATE INDEX SenseGloss_gend ON SenseGloss(gend);
CREATE INDEX SenseGloss_text ON SenseGloss(text);