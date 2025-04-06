package admin.model;

import java.util.ArrayList;

import mvc.domain.Blacklist;
import mvc.domain.ReportDetail;
import mvc.domain.SignUpMember;
import mvc.domain.Statistics;

public class AdminService {
	private AdminDAO dao;
	
	private static final AdminService instance = new AdminService();
	private AdminService() {
		dao = new AdminDAO();
	}
	public static AdminService getInstance() {
		return instance;
	}
	
	public ArrayList<Statistics> pBoardStatisticsS() {
		return dao.pBoardStatistics();
	}
	
	public ArrayList<SignUpMember> signUpStatisticsS(){
		return dao.signUpStatistics();
	}
	public ArrayList<ReportDetail> reportListS(int page){
		return dao.reportList(page);
	}
	public long reportSizeS() {
		return dao.reportSize();
	}
	
	public ArrayList<Blacklist> blacklistS(int page){
		return dao.blacklist(page);
	}
	
	public long blackSizeS() {
		return dao.blacklistSize();
	}
}
