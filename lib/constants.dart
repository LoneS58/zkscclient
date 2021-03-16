import 'package:flutter/material.dart';

String v = "v.B100800";

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0)));

List allscrips = [
  "786",
  "AABS",
  "AAL",
  "AASM",
  "AATM",
  "ABL",
  "ABOT",
  "ABSON",
  "ACPL",
  "ADAMS",
  "ADMM",
  "ADOS",
  "ADTM",
  "AEL",
  "AGHA",
  "AGIC",
  "AGIL",
  "AGL",
  "AGP",
  "AGSML",
  "AGTL",
  "AHCL",
  "AHL",
  "AHTM",
  "AICL",
  "AKBL",
  "AKDCL",
  "AKGL",
  "AKZO",
  "ALAC",
  "ALNRS",
  "ALQT",
  "ALTN",
  "AMBL",
  "AMSL",
  "AMTEX",
  "ANL",
  "ANNT",
  "ANSM",
  "ANTM",
  "APL",
  "APOT",
  "AQTM",
  "ARM",
  "ARPAK",
  "ARPL",
  "ARUJ",
  "ASC",
  "ASHT",
  "ASIC",
  "ASL",
  "ASRL",
  "ASTL",
  "ASTM",
  "ATBA",
  "ATIL",
  "ATLH",
  "ATRL",
  "AVN",
  "AWTX",
  "AWWAL",
  "AYTM",
  "AYZT",
  "AZMT",
  "AZTM",
  "BAFL",
  "BAFS",
  "BAHL",
  "BAPL",
  "BATA",
  "BCL",
  "BCML",
  "BEEM",
  "BELA",
  "BERG",
  "BFMOD",
  "BGL",
  "BHAT",
  "BIFO",
  "BIIC",
  "BILF",
  "BIPL",
  "BIPLS",
  "BNL",
  "BNWM",
  "BOK",
  "BOP",
  "BPBL",
  "BPL",
  "BROT",
  "BRR",
  "BTL",
  "BUXL",
  "BWCL",
  "BWHL",
  "BYCO",
  "CCM",
  "CECL",
  "CENI",
  "CEPB",
  "CFL",
  "CHAS",
  "CHBL",
  "CHCC",
  "CJPL",
  "CLCPS",
  "CLOV",
  "COLG",
  "COST",
  "COTT",
  "CPAL",
  "CPPL",
  "CRTM",
  "CSAP",
  "CSIL",
  "CSM",
  "CTM",
  "CWSM",
  "CYAN",
  "DAAG",
  "DADX",
  "DATM",
  "DAWH",
  "DBCI",
  "DBSL",
  "DCL",
  "DCM",
  "DCR",
  "DCTL",
  "DEL",
  "DFML",
  "DFSM",
  "DGKC",
  "DIIL",
  "DINT",
  "DKL",
  "DKTM",
  "DLL",
  "DMIL",
  "DMTM",
  "DMTX",
  "DNCC",
  "DOL",
  "DOLCPS",
  "DOMF",
  "DSFL",
  "DSIL",
  "DSL",
  "DSML",
  "DWAE",
  "DWSM",
  "DWTM",
  "DYNO",
  "ECOP",
  "EFERT",
  "EFGH",
  "EFUG",
  "EFUL",
  "ELCM",
  "ELSM",
  "EMCO",
  "ENGL",
  "ENGRO",
  "EPCL",
  "EPQL",
  "ESBL",
  "EWIC",
  "EWLA",
  "EXIDE",
  "EXTR",
  "FABL",
  "FAEL",
  "FANM",
  "FASM",
  "FATIMA",
  "FCCL",
  "FCEL",
  "FCEPL",
  "FCIBL",
  "FCONM",
  "FCSC",
  "FDIBL",
  "FDMF",
  "FECM",
  "FECTC",
  "FEM",
  "FEROZ",
  "FFBL",
  "FFC",
  "FFL",
  "FFLM",
  "FFLNV",
  "FHAM",
  "FIBLM",
  "FIL",
  "FIM",
  "FIMM",
  "FLYNG",
  "FML",
  "FNBM",
  "FNEL",
  "FPJM",
  "FPRM",
  "FRCL",
  "FRSM",
  "FSWL",
  "FTHM",
  "FTMM",
  "FTSM",
  "FUDLM",
  "FZCM",
  "GADT",
  "GAIL",
  "GAMON",
  "GASF",
  "GATI",
  "GATM",
  "GENP",
  "GFIL",
  "GGGL",
  "GGL",
  "GHGL",
  "GHNI",
  "GHNL",
  "GIL",
  "GLAT",
  "GLAXO",
  "GLOT",
  "GLPL",
  "GOC",
  "GOEM",
  "GRYL",
  "GSKCH",
  "GSPM",
  "GTYR",
  "GUSM",
  "GUTM",
  "GVGL",
  "GWLC",
  "HABSM",
  "HACC",
  "HADC",
  "HAEL",
  "HAFL",
  "HAJT",
  "HAL",
  "HASCOL",
  "HATM",
  "HBL",
  "HCAR",
  "HCL",
  "HGFA",
  "HICL",
  "HIFA",
  "HINO",
  "HINOON",
  "HIRAT",
  "HKKT",
  "HMB",
  "HMICL",
  "HMIM",
  "HMM",
  "HRPL",
  "HSM",
  "HSPI",
  "HTL",
  "HUBC",
  "HUMNL",
  "HUSI",
  "HWQS",
  "IBFL",
  "IBLHL",
  "ICCI",
  "ICCT",
  "ICI",
  "ICIBL",
  "ICL",
  "IDRT",
  "IDSM",
  "IDYM",
  "IFSL",
  "IGIBL",
  "IGIHL",
  "IGIIL",
  "IGIL",
  "ILP",
  "ILTM",
  "IML",
  "IMSL",
  "INDU",
  "INIL",
  "INKL",
  "INL",
  "INMF",
  "ISHT",
  "ISIL",
  "ISL",
  "ISTM",
  "ITSL",
  "ITTEFAQ",
  "JATM",
  "JDMT",
  "JDWS",
  "JGICL",
  "JKSM",
  "JLICL",
  "JOPP",
  "JOVC",
  "JPGL",
  "JSBL",
  "JSCL",
  "JSGCL",
  "JSIL",
  "JSML",
  "JUBS",
  "JVDC",
  "KACM",
  "KAKL",
  "KAPCO",
  "KASBM",
  "KCL",
  "KEL",
  "KHSM",
  "KHTC",
  "KHYT",
  "KML",
  "KOHC",
  "KOHE",
  "KOHP",
  "KOHTM",
  "KOIL",
  "KOSM",
  "KPUS",
  "KSBP",
  "KSTM",
  "KTML",
  "LEUL",
  "LINDE",
  "LMSM",
  "LOADS",
  "LOTCHEM",
  "LPCL",
  "LPGL",
  "LPL",
  "LUCK",
  "MACFL",
  "MACTER",
  "MARI",
  "MCB",
  "MCBAH",
  "MDTL",
  "MDTM",
  "MEBL",
  "MEHT",
  "MERIT",
  "MFFL",
  "MFL",
  "MFTM",
  "MIRKS",
  "MLCF",
  "MODAM",
  "MOHE",
  "MOIL",
  "MOON",
  "MQTM",
  "MRNS",
  "MSCL",
  "MSOT",
  "MTIL",
  "MTL",
  "MUBT",
  "MUGHAL",
  "MUKT",
  "MUREB",
  "MWMP",
  "MZSM",
  "NAFL",
  "NAGC",
  "NATF",
  "NATM",
  "NBP",
  "NCL",
  "NCML",
  "NCPL",
  "NESTLE",
  "NETSOL",
  "NEXT",
  "NIB",
  "NICL",
  "NINA",
  "NMFL",
  "NML",
  "NONS",
  "NORS",
  "NPL",
  "NPSM",
  "NRL",
  "NRSL",
  "NSRM",
  "OGDC",
  "OLPL",
  "OLSM",
  "OML",
  "ORIXM",
  "ORM",
  "OTSU",
  "PACE",
  "PAEL",
  "PAKCEM",
  "PAKD",
  "PAKL",
  "PAKMI",
  "PAKOXY",
  "PAKRI",
  "PAKT",
  "PASL",
  "PASM",
  "PCAL",
  "PCML",
  "PDGH",
  "PECO",
  "PGCL",
  "PGF",
  "PGIC",
  "PGLC",
  "PHDL",
  "PIAA",
  "PIAB",
  "PIBTL",
  "PICL",
  "PICT",
  "PIF",
  "PIL",
  "PIM",
  "PINL",
  "PIOC",
  "PKGI",
  "PKGP",
  "PKGS",
  "PMI",
  "PMPK",
  "PMRS",
  "PNGRS",
  "PNSC",
  "POL",
  "POML",
  "POWER",
  "PPL",
  "PPP",
  "PPVC",
  "PREMA",
  "PRET",
  "PRIB",
  "PRIC",
  "PRL",
  "PRWM",
  "PSEL",
  "PSMC",
  "PSO",
  "PSX",
  "PSYL",
  "PTC",
  "PUDF",
  "QUET",
  "QUICE",
  "QUSW",
  "RAVT",
  "RCML",
  "REDCO",
  "REGAL",
  "REWM",
  "RICL",
  "RMPL",
  "RPL",
  "RUBY",
  "RUPL",
  "SAIF",
  "SALT",
  "SANE",
  "SANSM",
  "SAPL",
  "SAPT",
  "SARC",
  "SASML",
  "SAZEW",
  "SBL",
  "SCBPL",
  "SCHT",
  "SCL",
  "SDIL",
  "SDOT",
  "SEARL",
  "SEL",
  "SEPCO",
  "SEPL",
  "SERF",
  "SERT",
  "SFAT",
  "SFL",
  "SFLL",
  "SGABL",
  "SGFL",
  "SGPL",
  "SHCI",
  "SHCM",
  "SHDT",
  "SHEL",
  "SHEZ",
  "SHFA",
  "SHJS",
  "SHNI",
  "SHSML",
  "SIBL",
  "SICL",
  "SIEM",
  "SILK",
  "SINDM",
  "SING",
  "SITC",
  "SJTM",
  "SKRS",
  "SLCL",
  "SLL",
  "SLSO",
  "SLYT",
  "SMBL",
  "SMCPL",
  "SML",
  "SMTM",
  "SNAI",
  "SNBL",
  "SNGP",
  "SPEL",
  "SPL",
  "SPLC",
  "SPWL",
  "SRSM",
  "SRVI",
  "SSGC",
  "SSIC",
  "SSML",
  "SSOM",
  "STCL",
  "STJT",
  "STML",
  "STPL",
  "SUCM",
  "SUHJ",
  "SURAJ",
  "SURC",
  "SUTM",
  "SYS",
  "SZTM",
  "TAJT",
  "TATM",
  "TCLTC",
  "TDIL",
  "TELE",
  "TGL",
  "THALL",
  "THAS",
  "THCCL",
  "TICL",
  "TOMCL",
  "TOWL",
  "TPL",
  "TPLI",
  "TPLP",
  "TPLT",
  "TREET",
  "TREI",
  "TRG",
  "TRIBL",
  "TRIPF",
  "TRPOL",
  "TRSM",
  "TSBL",
  "TSMF",
  "TSML",
  "TSPL",
  "UBDL",
  "UBL",
  "UCAPM",
  "UDPL",
  "UNIC",
  "UNITY",
  "UPFL",
  "USMT",
  "UVIC",
  "WAHN",
  "WAVES",
  "WTL",
  "WYETH",
  "YOUW",
  "ZAHID",
  "ZELP",
  "ZHCM",
  "ZIL",
  "ZTL",
];
