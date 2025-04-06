package main.model;

import java.util.ArrayList;

import mvc.domain.Article;

public class MainService {
	private MainDAO dao;
	private static final MainService instance = new MainService();
	private MainService() {
		dao = new MainDAO();
	}
	
	public static MainService getInstance() {
		return instance;
	}
	
	public ArrayList<Article> list(String cat) {
		return dao.list(cat);
	}
}
