package main.model;

import java.util.ArrayList;

import mvc.domain.Category;

public class CategoryService {
	private CategoryDAO dao;
	
	private static final CategoryService instance = new CategoryService();
	private CategoryService() {
		dao = new CategoryDAO();
	}
	
	public static CategoryService getInstance() {
		return instance;
	}
	
	public ArrayList<Category> categorysS(long cpNo){
		return dao.categorys(cpNo);
	}
}
