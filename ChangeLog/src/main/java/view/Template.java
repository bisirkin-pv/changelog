package view;

import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import spark.template.freemarker.FreeMarkerEngine;



public class Template {
    private static FreeMarkerEngine template;
    public static void setTemplate(){
        template = new FreeMarkerEngine();
        Configuration freemarkerConfiguration = new Configuration();
        freemarkerConfiguration.setTemplateLoader(new ClassTemplateLoader(Template.class
                , "/templates/"));
        template.setConfiguration(freemarkerConfiguration);
    }
    public static FreeMarkerEngine getTemplate(){
        return template;
    }
}
