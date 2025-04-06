package comment.model;
import java.util.ArrayList;
import java.util.List;

import mvc.domain.Comments;

public class CommentService {
	private CommentDAO dao;
	private static final CommentService instance = new CommentService();
	private CommentService() {
		dao = new CommentDAO();
	}
	
	public ArrayList<Comments> list(long pNo) {
		return dao.list(pNo);
	}
	
	public static CommentService getInstance() {
		return instance;
	}

	public boolean insertS(Comments comment) {
		return dao.insert(comment);
	}

	public boolean rInsertS(Comments comment) {
		return dao.rInsert(comment);
	}

	public boolean updateS(Comments comment) {
		return dao.update(comment);
	}

	public boolean deleteS(long coNo) {
		return dao.delete(coNo);
	}


}
