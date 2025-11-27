create database charantu;
use charantu;

CREATE TABLE SUPPLIERS (
    sid INTEGER PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE PARTS (
    pid INTEGER PRIMARY KEY,
    pname VARCHAR(50),
    color VARCHAR(20)
);
CREATE TABLE CATALOG (
    sid INTEGER,
    pid INTEGER,
    cost REAL,
    PRIMARY KEY (sid, pid),
    FOREIGN KEY (sid) REFERENCES SUPPLIERS(sid),
    FOREIGN KEY (pid) REFERENCES PARTS(pid)
);
INSERT INTO SUPPLIERS VALUES
(10001, 'Acme Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');
INSERT INTO PARTS VALUES
(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');
INSERT INTO CATALOG VALUES
(10001, 20001, 10),
(10001, 20002, 10),
(10001, 20003, 30),
(10001, 20004, 10),
(10001, 20005, 10),
(10002, 20001, 10),
(10002, 20002, 20),
(10003, 20003, 30),
(10004, 20003, 40);

select distinct pname from PARTS AS P,CATALOG AS C where P.pid=C.pid;
select sname from SUPPLIERS S 
WHERE ((SELECT pid from PARTS P)=(select pid
 from CATALOG C WHERE C.sid=S.sid));
SELECT S.sname
FROM Suppliers S
WHERE (SELECT COUNT(P.pid)
       FROM Parts P
       WHERE P.color = 'Red')
    =
      (SELECT COUNT(C.pid)
       FROM Catalog C, Parts P
       WHERE C.sid = S.sid
         AND C.pid = P.pid
         AND P.color = 'Red');

SELECT P.pname
FROM Parts P, Catalog C, Suppliers S
WHERE P.pid = C.pid
  AND C.sid = S.sid
  AND S.sname = 'Acme Widget'
  AND NOT EXISTS (
        SELECT *
        FROM Catalog C1, Suppliers S1
        WHERE P.pid = C1.pid
          AND C1.sid = S1.sid
          AND S1.sname <> 'Acme Widget'
  );
SELECT DISTINCT C.sid
FROM Catalog C
WHERE C.cost >
      (SELECT AVG(C1.cost)
       FROM Catalog C1
       WHERE C1.pid = C.pid);

SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
  AND C.sid = S.sid
  AND C.cost = (SELECT MAX(C1.cost)
                FROM Catalog C1
                WHERE C1.pid = P.pid);



