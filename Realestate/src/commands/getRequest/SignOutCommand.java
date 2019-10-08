package commands.getRequest;

import commands.FrontCommand;
import org.apache.shiro.SecurityUtils;
import service.AppSession;

import javax.servlet.ServletException;
import java.io.IOException;

/**
 * Get Index Page Command after signing out
 */
public class SignOutCommand extends FrontCommand {
    public void process() throws ServletException, IOException {
        if (AppSession.isAuthenticated()) {
            SecurityUtils.getSubject().logout();
        }
        forward("/index.jsp");
    }
}
