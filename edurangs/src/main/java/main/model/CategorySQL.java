package main.model;

class CategorySQL {
	final static String SELETE = "select * from CATEGORYS WHERE CPNO = ? order by CPNO , CPLEVEL";
	final static String ASELETE = "select * from CATEGORYS order by CPNO , CPLEVEL";
}
