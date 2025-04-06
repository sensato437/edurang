package file.fileset;

import java.nio.file.Paths;

public class Path {
	static String basePath = Paths.get("").toAbsolutePath().toString();	
	public static final String FILE_STORE = Paths.get(basePath, "workspace", "edurang", "src", "main", "webapp", "upload").toString();
}
