package mvc.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import login.model.LoginService;
import mvc.domain.Member;

/**
 * Application Lifecycle Listener implementation class LoginInfo
 *
 */
@WebListener
public class LoginInfo implements HttpSessionListener {

	String email;
    public LoginInfo() {
        // TODO Auto-generated constructor stub
    }
    public LoginInfo(String email) {
        this.email = email;
    }
    public void sessionCreated(HttpSessionEvent se)  { 
    }

    public void sessionDestroyed(HttpSessionEvent se)  { 
    	if(email!=null) {
    		LoginService service = LoginService.getInstance();
    		service.LogOutState(email);
    	}
    }
	
}
