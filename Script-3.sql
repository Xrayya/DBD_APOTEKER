------------------------
--          DDL       --
------------------------
CREATE SCHEMA APOTEK;

CREATE TABLE APOTEK.SUPPLIER (
    ID_SUPPLIER             VARCHAR(5) NOT NULL PRIMARY KEY,
    ALAMAT_SUPPLIER         VARCHAR(45)
);

CREATE TABLE APOTEK.APOTEKER (
    ID_AP                   VARCHAR(5) NOT NULL PRIMARY KEY,
    NAMA_DEPAN              VARCHAR(20),
    NAMA_BELAKANG           VARCHAR(20),
    ALAMAT_TEMPAT_TINGGAL   VARCHAR(45),
    GENDER                  CHAR(1) CHECK (GENDER IN ('P', 'W')),
    TGL_LAHIR               DATE,
    STRATA                  VARCHAR(20),
    JURUSAN                 VARCHAR(20),
    UNIVERSITAS             VARCHAR(45),
    TAHUN_LULUS             INTEGER
);

CREATE TABLE APOTEK.OBAT (
    ID_OBAT                 VARCHAR(5) NOT NULL PRIMARY KEY,
    ID_AP                   VARCHAR(5),
    NAMA_OBAT               VARCHAR(45),
    HARGA                   INTEGER,
    CARA_PAKAI              VARCHAR(255),
    FOREIGN KEY(ID_AP)
        REFERENCES APOTEK.APOTEKER(ID_AP)
);

CREATE TABLE APOTEK.SUPLAI (
    ID_OBAT                 VARCHAR(5),
    ID_SUPPLIER             VARCHAR(5),
    FOREIGN KEY(ID_SUPPLIER)
        REFERENCES APOTEK.SUPPLIER(ID_SUPPLIER),
    FOREIGN KEY(ID_OBAT)
        REFERENCES APOTEK.OBAT(ID_OBAT)
);

CREATE TABLE APOTEK.PEMBELI (
    ID_PEMBELI              VARCHAR(5) NOT NULL PRIMARY KEY,
    NAMA_DEPAN              VARCHAR(20),
    NAMA_BELAKANG           VARCHAR(20),
    GENDER                  CHAR(1) CHECK (GENDER IN ('P', 'W')),
    TGL_LAHIR               DATE
);

CREATE TABLE APOTEK.KARYAWAN (
    ID_KARYAWAN             VARCHAR(5) NOT NULL PRIMARY KEY,
    NAMA_DEPAN              VARCHAR(20),
    NAMA_BELAKANG           VARCHAR(20)
);

CREATE TABLE APOTEK.TRANSAKSI_PEMBELIAN (
    ID_PEMBELI              VARCHAR(5) NOT NULL,
    ID_KARYAWAN             VARCHAR(5) NOT NULL,
    ID_OBAT                 VARCHAR(5) NOT NULL,
    JUMLAH_BARANG           INTEGER,
    WAKTU_TRANSAKSI         DATE,
    FOREIGN KEY(ID_PEMBELI)
        REFERENCES APOTEK.PEMBELI(ID_PEMBELI),
    FOREIGN KEY(ID_KARYAWAN)
        REFERENCES APOTEK.KARYAWAN(ID_KARYAWAN),
    FOREIGN KEY(ID_OBAT)
        REFERENCES APOTEK.OBAT(ID_OBAT)
);

------------------------
-- 		  DML	      --
------------------------

INSERT INTO APOTEK.SUPPLIER 
VALUES
    ('S01', 'Jl. Sumbersari No.54, Kota Malang'),
    ('S02', 'Perumahan Grand Residence Blok T-5, Surabaya'),
    ('S03', 'Jl. Babatan No.420, Kota Pasuruan');

SELECT * FROM APOTEK.SUPPLIER;

INSERT INTO APOTEK.APOTEKER 
VALUES
    ('A01', 'Azhary', 'Munir', 'Jl.Watugong No.24, Malang', 'P', '2003-1-14', 'S1', 'SISTEM INFORMASI',
        'UNIVERSITAS BRAWIJAYA', '2022'),
    ('A02', 'Muhammad', 'Jibril', 'Jl.Watugong No.2, Malang', 'P', '2003-9-3', 'S1', 'KEDOKTERAN',
        'UNIVERSITAS BRAWIJAYA', '2022'),
    ('A03', 'Novia', 'Balqis', 'Jl.Kenangan No.69, Malang', 'W', '1997-4-27','S1', 'KEDOKTERAN',
        'UNIVERSITAS BRAWIJAYA', '2022');

SELECT * FROM APOTEK.APOTEKER;

INSERT INTO APOTEK.OBAT
VALUES
    ('M01', NULL, 'PROGMAG LIQ', 8500, 'Diminum 1-2 jam sebelum makan, saat timbul gejala, atau sebelum tidur.
        Kocok dulu sebelum diminum'),
    ('M02', NULL, 'ANTASIDA DOEN', 4000, 'Diminum 1-2 jam sebelum tidur. Sebaiknya diberikan dalam keadaan
        perut kosong'),
    ('M03', NULL, 'MYLANTA LIQ', 5000, 'Diminum 1-2 jam sebelum makan, saat timbul gejala, atau sebelum tidur.
        Kocok dulu sebelum diminum'),
    ('M04', NULL, 'RANITIDINE 10 TAB', 2000, 'Dapat diminum sebelum atau sesudah makan. Digunakan sebanyak
        satu atau dua kali sehari. Minum sesuai dosis. Minum secara teratur.'),
    ('M05', NULL, 'OMEPRAZOLE', 3609, 'dapat diminum sehari sekali, sebelum makan di pagi hari. Telan kapsul
        secara utuh, jangan mengunyah atau menghancurkan kapsul.'),
    ('M06', 'A01', 'M-H02', 10000, 'Diminum satu kapsul saat maag'),
    ('B01', NULL, 'WOODS', 21000, 'Dewasa dan anak usia > 12 tahun: 2 sendok teh (10 ml), di minum 3 kali sehari.
        Anak usia 6-12 tahun: 1 sendok teh (5 ml), di minum 3 kali sehari.'),
    ('B02', NULL, 'SILADEX', 1900, 'Diminum setelah makan'),
    ('B03', NULL, 'PIM-TRA-KOL', 5500, 'Diminum setelah makan'),
    ('B04', NULL, 'OBP-01', 3000, 'Diminum setelah makan'),
    ('B05', NULL, 'KONIDIN', 17000, 'Diminum setelah makan'),
    ('B06', NULL, 'KOMIX', 7000, 'Diminum setelah makan'),
    ('B07', NULL, 'VICKS', 15000, 'Diminum setelah makan'),
    ('KM01', NULL, 'LISTERINE', 32000, 'Dikumur sesudah makan atau sebelum tidur'),
    ('KM02', NULL, 'BETADINE', 27000, 'Dikumur sesudah makan atau sebelum tidur'),
    ('KM03', NULL, 'PEPSODENT', 24000, 'Dikumur sesudah makan atau sebelum tidur'),
    ('KM04', NULL, 'COLGATE PLAX', 22000, 'Dikumur sesudah makan atau sebelum tidur'),
    ('KL01', NULL, 'INERSON', 28000, 'Dioleskan pada are yang luka atau gatal secara merata'),
    ('KL02', NULL, 'SALEP PAGODA', 12000, 'Dioleskan pada are yang luka atau gatal secara merata'),
    ('KL03', 'A02', 'BOORTALK', 7000, 'Ditaburkan ke kulit secara merata pada bagian tubuh yang sering
        mengalami gesekan');

SELECT * FROM APOTEK.OBAT;

INSERT INTO APOTEK.SUPLAI
VALUES
    ('M01', 'S02'),
    ('KL01', 'S01'),
    ('M02', 'S03'),
    ('KM01', 'S02'),
    ('M01', 'S03'),
    ('M01', 'S01'),
    ('M02', 'S01'),
    ('M03', 'S03'),
    ('M04', 'S01'),
    ('M05', 'S02'),
    ('M06', 'S01'),
    ('KM01', 'S03'),
    ('B01', 'S03'),
    ('B02', 'S03'),
    ('B03', 'S02'),
    ('B04', 'S01'),
    ('B05', 'S02'),
    ('B05', 'S03'),
    ('KL03', 'S01'),
    ('B06', 'S03'),
    ('B07', 'S02'),
    ('B01', 'S01'),
    ('KM01', 'S01'),
    ('KM02', 'S03'),
    ('M03', 'S01'),
    ('KM03', 'S02'),
    ('KM04', 'S03'),
    ('KL01', 'S02'),
    ('KL02', 'S01'),
    ('KL03', 'S03');

SELECT * FROM APOTEK.SUPLAI;

INSERT INTO APOTEK.PEMBELI 
VALUES 
    ('001', 'Abdan', 'Fikri', 'P', '2002-10-15'),
    ('002', 'Itqany', 'Rachman', 'P', '2003-4-21'),
    ('003', 'Naufal', 'Dzaky', 'P', '2003-7-25'),
    ('004', 'Achmad', 'Nizar', 'P', '2003-5-24'),
    ('005', 'Gading', 'Mahendra', 'P', '2005-10-12'),
    ('006', 'Indra', 'Hermawan', 'P', '2003-3-20'),
    ('007', 'Frederica', 'Greenhill', 'W', '1996-4-12'),
    ('008', 'Sisca', 'Kohl', 'W', '1984-6-22'),
    ('009', 'Yor', 'Forger', 'W', '1981-4-9'),
    ('010', 'Syifa', 'Nayla', 'W', '2003-3-24');

SELECT * FROM APOTEK.PEMBELI;

INSERT INTO APOTEK.KARYAWAN 
VALUES
    ('K01', 'Yanto', 'Hermawan'),
    ('K02', 'Sueb', 'Gabriel'),
    ('K03', 'Marcel', 'Jamaludin'),
    ('K04', 'Vivi', 'Skyavers');

SELECT * FROM APOTEK.KARYAWAN;

INSERT INTO APOTEK.TRANSAKSI_PEMBELIAN
VALUES
    ('001', 'K01','M01', 1, '2022-06-22'),
    ('001', 'K01', 'KL01', 1, '2022-06-22'),
    ('001', 'K01', 'KM01', 2, '2022-06-22'),
    ('010', 'K03', 'KM01', 2, '2022-06-30'),
    ('004', 'K03', 'B03', 5, '2022-06-30'),
    ('007', 'K02', 'B02', 5, '2022-07-01');

SELECT * FROM APOTEK.TRANSAKSI_PEMBELIAN;

------------------------
--    Other Queries   --
------------------------

SELECT      ID_PEMBELI, NAMA_DEPAN, NAMA_BELAKANG,
            GENDER, TGL_LAHIR
FROM        APOTEK.PEMBELI
WHERE       NAMA_DEPAN LIKE 'A%';

CREATE VIEW APOTEK.JUMLAH_TRANSAKSI AS
SELECT      ID_OBAT,
            COUNT(ID_OBAT) AS JUMLAH_TRANSAKSI_PEMBELIAN
FROM        APOTEK.TRANSAKSI_PEMBELIAN
GROUP BY    ID_OBAT;

SELECT      O.ID_OBAT, COALESCE (O.ID_AP, 'TIDAK DIRACIK') AS ID_AP,
            O.NAMA_OBAT, O.HARGA,
            COALESCE(JK.JUMLAH_TRANSAKSI_PEMBELIAN, 0) AS JUMLAH_TRANSAKSI_PEMBELIAN
FROM        APOTEK.OBAT O
            LEFT OUTER JOIN APOTEK.JUMLAH_TRANSAKSI JK
            ON O.ID_OBAT = JK.ID_OBAT
ORDER BY    O.ID_OBAT;

SELECT      AVG(HARGA) AS RATA_RATA_HARGA_OBAT
FROM        APOTEK.OBAT;

SELECT      *
FROM        APOTEK.PEMBELI
WHERE       GENDER = 'P' AND
            YEAR(CURRENT DATE) - YEAR(TGL_LAHIR) >= 19;

SELECT      COUNT(ID_OBAT) AS TOTAL_JENIS_OBAT
FROM        APOTEK.OBAT;

SELECT      MIN(HARGA) AS OBAT_TERMURAH, MAX(HARGA) AS OBAT_TERMAHAL
FROM        APOTEK.OBAT;

SELECT      O.NAMA_OBAT, O.HARGA,
            CONCAT(CONCAT(A.NAMA_DEPAN, ' '), A.NAMA_BELAKANG) AS NAMA_LENGKAP_APOTEKER
FROM        APOTEK.APOTEKER A, APOTEK.OBAT O
WHERE       O.ID_AP = A.ID_AP;

SELECT      O.ID_OBAT, O.NAMA_OBAT,
            S.ID_SUPPLIER, S.ALAMAT_SUPPLIER
FROM        APOTEK.SUPPLIER S
            JOIN APOTEK.SUPLAI S_O
            ON S.ID_SUPPLIER = S_O.ID_SUPPLIER
            JOIN APOTEK.OBAT O
            ON S_O.ID_OBAT = O.ID_OBAT
ORDER BY    O.ID_OBAT;

SELECT      ID_PEMBELI AS ID, NAMA_DEPAN, NAMA_BELAKANG
FROM        APOTEK.PEMBELI
UNION
SELECT      ID_AP AS ID, NAMA_DEPAN, NAMA_BELAKANG
FROM        APOTEK.APOTEKER
UNION
SELECT      ID_KARYAWAN AS ID, NAMA_DEPAN, NAMA_BELAKANG
FROM        APOTEK.KARYAWAN;

SELECT      P.JUMLAH_PEMBELI AS JUMLAH_PEMBELI_PRIA,
            W.JUMLAH_PEMBELI AS JUMLAH_PEMBELI_WANITA
FROM        (
                SELECT COUNT(*) AS JUMLAH_PEMBELI
                FROM APOTEK.PEMBELI
                WHERE GENDER = 'W'
            ) W, 
            (
                SELECT COUNT(*) AS JUMLAH_PEMBELI
                FROM APOTEK.PEMBELI
                WHERE GENDER = 'P'
            ) P;