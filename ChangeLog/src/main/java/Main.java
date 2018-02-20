import spark.ModelAndView;
import view.Template;

import static spark.Spark.*;

public class Main {
    public static void main(String[] args) {
        exception(Exception.class, (e, req, res) -> e.printStackTrace());
        staticFiles.location("public");
        //4567
        port(8080);
        Template.setTemplate();

        get("/", (req, res) -> Template.getTemplate().render(
                new ModelAndView(null, "base.ftl"))
        );
    }
}
