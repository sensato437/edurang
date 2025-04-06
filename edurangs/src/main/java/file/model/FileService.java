package file.model;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.UUID;

import file.fileset.Path;

public class FileService {
	//private FileDAO dao; //DB사용시?
	private static final FileService instance = new FileService();
	private String lastSavedFileName;
	public FileService() {
		//dao = new FileDAO();
	}
	
	public static FileService getInstance() {
		return instance;
	}
	
	public String getSubmittedFileName(Part part) {
		String header = part.getHeader("content-disposition");
		for(String cd : header.split(";")) { //content-disposition(cd)
			if(cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
			}
		}
		return null;
	}
	
	//파일을 가져와
	public File getFileS(String fileName) throws FileNotFoundException {
		if(fileName == null || fileName.trim().isEmpty()) {
			throw new IllegalArgumentException("fileName is required");
		}
		
		File file = new File(Path.FILE_STORE, fileName);
		if(!file.exists()) {
			throw new FileNotFoundException("File not found");
		}
		return file;	
	}
	
	public void viewImageS(File file, OutputStream os) {
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(file);
			byte[] bs = new byte[1024];
			int i;
			while ((i = fis.read(bs)) != -1) {
				os.write(bs, 0, i);
			}			
		}catch(IOException e) {
			//
		}finally {
			try {
				if (fis != null) fis.close();
			}catch(IOException ie) {}
		}
	}
	
	public boolean saveFile(Part filePart, HttpServletRequest request) {
		String fName = getSubmittedFileName(filePart);
		if(fName != null) fName = fName.trim();
		if(fName.length() == 0) {
			return false;
		}

		//파일 확장자 검증
		/*String[] allowedExtensions = {"jpg", "jpeg", "png", "gif"};
		String ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
		if (!Arrays.asList(allowedExtensions).contains(ext)) {
			return false;
		}*/	
		String uploadPath = Path.FILE_STORE;
		
		//Path.FILE_STORE;
		File uploadDir = new File(uploadPath);
		if(!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		String safefName = fName.replaceAll("[^a-zA-Z0-9.-]", "_");
		
		//File saveFile = new File(uploadDir, fName);
		//File saveFile = new File(uploadDir, safefName);
		
		//중복된 파일명
		String fNameNoExt = "";
		String ext = "";
		
		/*int idx = fName.lastIndexOf(".");
		if(idx > 0) {
			fNameNoExt = fName.substring(0, idx);
			ext = fName.substring(idx);
		} else {
			fNameNoExt = fName;
		}*/

		int idx = safefName.lastIndexOf(".");
		if(idx > 0) {
			fNameNoExt = safefName.substring(0, idx);
			ext = safefName.substring(idx);
		} else {
			fNameNoExt = safefName;
		}
		
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		String cutuuid = uuid.substring(0, 5);
		
		String uuidfName = fNameNoExt + cutuuid + ext;
		File saveFile = new File(uploadDir, uuidfName);
		
		/*int count= 1;
		while(saveFile.exists()) {
			saveFile = new File(uploadDir, fNameNoExt + count + ext);
			count++;
		}*/		
		
		InputStream is = null;
		FileOutputStream fos = null;
		
		try {
			is = filePart.getInputStream(); //ds
			fos = new FileOutputStream(saveFile); //data 목적지
			
			byte bs[] = new byte[1024];			
			int i = 0;
			while((i = is.read(bs)) != -1) {
				fos.write(bs, 0, i);
			}
			fos.flush();
			
			this.lastSavedFileName = uuidfName;
			return true;
		}catch(IOException ie) {
			System.out.println("파일 저장 실패: " + ie.getMessage());
			return false;
		}finally {
			try {
				if (is != null) is.close();
				if (fos != null) fos.close();
			}catch(IOException e) {}
		}
	}
	
	public String getLastSavedFileName(){
		return lastSavedFileName;
	}
}
