package file.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import file.fileset.Path;
import file.model.FileService;

@WebServlet("/file/file.do")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024 * 10,  // 10MB
		maxFileSize = 1024 * 1024 * 20,       // 20MB
		maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class FileBController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private static final String UPLOAD_DIR = "D:/HJ/eclipse/workspace/edurang/src/main/webapp/upload";
	
	public void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String m = request.getParameter("m"); //m을 파라미터로 받아서 전송
		if(m != null) {
			m = m.trim();
			switch(m) {		
                //case "upload": upload(request,response); break;		
				case "uploadImage": uploadImage(request,response); break;
				case "sImage": sImage(request, response); break; // 이미지 제공 기능 추가
				//default: response.sendRedirect("file.do"); break;
			}
		}else {
			//
		}
	}

	// 이미지 제공 메소드 추가
    /*private void sImage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fileName = request.getParameter("file"); // 파일명 파라미터
        if (fileName == null || fileName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is required");
            return;
        }

        File file = new File(Path.FILE_STORE, fileName);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }

        // MIME 타입 설정
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "image/jpeg"; // 기본 MIME 타입 (JPEG로 가정)
        }

        // 응답 헤더 설정
        response.setContentType(mimeType);
        response.setContentLength((int) file.length());

        // 파일 스트리밍
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.out.println("FileBController.serveImage 문제: " + e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while serving image");
        }
    }*/
	
	private void sImage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		String fileName = request.getParameter("file");
		
		try {
			FileService service = FileService.getInstance();
			File file = service.getFileS(fileName);
			
			//mimetype 설정
			String mimeType = getServletContext().getMimeType(file.getName());
			if (mimeType == null) {
				mimeType = "image/jpeg";
			}
			
			// 응답 헤더 설정
	        response.setContentType(mimeType);
	        response.setContentLength((int) file.length());
			
	        //파일 스트리밍
	        service.viewImageS(file, response.getOutputStream());	        
		}catch(Exception e) {}		
	}

	/*private void uploadImage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {        
        try{
            Part filePart = request.getPart("file"); //summernote의 "file"필드
            
            // FileService의 saveFile 메서드 호출
            FileService service = FileService.getInstance();
            boolean saveResult = service.saveFile(filePart, request);
            
            if (!saveResult) {
                response.getWriter().write("파일 저장 실패!");
                return;
            }
            
            // 파일명 추출 (FileService에서 처리된 파일명)
            String ofName = service.getSubmittedFileName(filePart);
            
            // Summernote에 반환할 JSON 응답 생성
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.println("{\"url\": \"" + request.getContextPath() + "/upload/" + ofName + "\"}");
        }catch(Exception e){
            System.out.println("FileBController.uploadImage 문제: " + e);
        }
    }*/
	
	private void uploadImage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {        
        try{        	
        	Collection<Part> fileParts = request.getParts(); //Collection으로 여러 파일들을
            
        	List<String> fileUrls = new ArrayList<>(); //업로드한 파일들 url list        	
        	
	    	for (Part filePart : fileParts) { //꺼냄
	    		if (filePart.getName().equals("file")) { //Summernote의 "file" 필드
		    		// FileService의 saveFile 메서드 호출
		            FileService service = FileService.getInstance();
		            boolean saveResult = service.saveFile(filePart, request);
		            
		            if (!saveResult) {
		                response.getWriter().write("파일 저장 실패!");
		                return;
		            }
		            
		            // 파일명 추출 (FileService에서 처리된 파일명)
		            //String ofName = service.getSubmittedFileName(filePart);           
					String ofName = service.getLastSavedFileName();
		            
		            String fileUrl = request.getContextPath() + "/file/file.do?m=sImage&file=" + ofName; //url 생성했으면
		            fileUrls.add(fileUrl); //추가하자
	    		}
	    	}
	    	
	    	//JSon응답 Gson 없이 만들어볼까?
	    	response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        PrintWriter out = response.getWriter();
	            
	        //
	        /*out.println("{\"url\": [");
	        for(int i=0; i<fileUrls.size(); i++) {
	        	out.println("\"" + fileUrls.get(i) + "\"");
	        	if(i < fileUrls.size() - 1) {
	        		out.print(", "); //마지막은 , 넣지 말라는 소리
	        	}
	        }
	        out.println("]}");*/
	        
	        // 파일 URL 배열을 JSON 배열 형식으로 직접 작성
	        StringBuilder jsonResponse = new StringBuilder("{\"urls\": [");
	        for (int i = 0; i < fileUrls.size(); i++) {
	            jsonResponse.append("\"").append(fileUrls.get(i)).append("\"");
	            if (i < fileUrls.size() - 1) {
	                jsonResponse.append(",");
	            }
	        }
	        jsonResponse.append("]}");
	        
	        // JSON 응답을 클라이언트에 반환
	        out.println(jsonResponse.toString());
	        
        }catch(Exception e){
            System.out.println("FileBController.uploadImage 문제: " + e);
        }
    }
}
