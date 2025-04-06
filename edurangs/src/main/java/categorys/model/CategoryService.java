package categorys.model;

import java.util.ArrayList;

import mvc.domain.Category;

public class CategoryService {
	CategoryDAO dao;
	private static final CategoryService instance = new CategoryService();
	private CategoryService() {
		dao = new CategoryDAO();
	}
	public static CategoryService getInstance() {
		return instance;
	}
	public ArrayList<Category> searchS(int cNo){
		return dao.search(cNo);
	}
}
